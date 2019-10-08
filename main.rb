# encoding: utf-8
require 'mygame/boot'


SDL::WM.set_caption("YJSNSPINNER","YJS")
SDL::WM.icon = (SDL::Surface.load('./image/icon.png'))

include Math

class Main < Scene::Base
  def init
    MyGame.background_color=[0, 0, 255]
    @o = [0, 0] #中心座標
    @a = 0.00 #加速度
    @theta = 0 #角度
    @color_mode = 0 #色替えモード
    @color_t = 0
    @images = []
    3.times {
      @images << TransparentImage.new("./image/01.png", :angle => 0)
    }
    @r = @images[0].h - 12#半径
    @image = TransparentImage.new("./image/02.png", :angle => 0, :x => screen.w / 2, :y => 200, :scale => 0.5)
    @button = Image.new("./image/Button.png")
    @button_back = Image.new("./image/Button_back.png", :hide => true)
    @font = ShadowFont.new("SPIN", :size => 45, :color => [0, 0, 0])
    @color = [0, 0, 0]
    @mouse_mode = 0 #押されていない
    @mouse_hit = false
    @info = []
    initEvent
    load_bgm
    load_wav
  end

  def load_wav
    @enableWav = false
    begin
      @wave = []
      Dir[File.expand_path('../wav/', __FILE__) << '/*.wav'].each do |file|
        @wave << SDL::Mixer::Wave.load(file)
        @enableWav = true
      end
    rescue
      @enableWav = false
    end
  end

  def load_bgm
    begin
      @bgm = []
      @musicVolume = 70
      SDL::Mixer.setVolumeMusic(@musicVolume)
      @playing = -1 #再生中のファイル
      Dir[File.expand_path('../BGM/', __FILE__) << '/*.*'].each do |file|
        @bgm << SDL::Mixer::Music.load(file)
        @enableBGM = true
      end
    rescue
      @enableBGM = false
    end
  end

  def initEvent
    add_event(:mouse_button_down) {
      if @mouse_hit
        @a += 0.25
        SDL::Mixer.play_channel(-1,@wave[rand(@wave.size)],0) if @enableWav
      end
      @mouse_mode = 1
    }
    add_event(:mouse_button_up) {@mouse_mode = 0}
    add_event(:mouse_motion) {|e|
      if @button.hit?(e)
        @mouse_hit = true
      else
        @mouse_hit = false
      end
    }
  end

  def bgm_update
    if @enableBGM
      unless SDL::Mixer.play_music?
        if @playing + 1 >= @bgm.size
          @playing = -1
        else
          @playing += 1
          SDL::Mixer.setVolumeMusic(120)
          SDL::Mixer.playMusic(@bgm[@playing], 0)
        end
      end
    end
  end

  def key_event
    if new_key_pressed?(Key::X)
      @a = 0
    end
    if new_key_pressed?(Key::M) && @enableBGM
      if SDL::Mixer.pauseMusic?
        SDL::Mixer.resumeMusic
      else
        SDL::Mixer.pauseMusic
      end
    end
    if key_pressed?(Key::UP)
      @musicVolume += 1
      @musicVolume = 200 if @musicVolume > 200
      SDL::Mixer.setVolumeMusic(@musicVolume)
    end
    if key_pressed?(Key::DOWN)
      @musicVolume -= 1
      @musicVolume = 0 if @musicVolume < 0
      SDL::Mixer.setVolumeMusic(@musicVolume)
    end
    if key_pressed?(Key::R)
      load_bgm
      load_wav
    end
  end

  def update
    update_theta
    update_color
    update_location
    speed_update
    info_update
    bgm_update
    key_event
    if @mouse_mode == 1 && @mouse_hit
      @button_back.hide = false
    else
      @button_back.hide = true
    end
  end

  def info_update
    @info = []
    msg = []
    msg << "FPS: #{real_fps}/#{fps}"
    msg << "Seed: #{@a.round(5)}"
    msg << "Resi: #{getF.round(5)}"
    msg << "Volume: #{@musicVolume}"
    msg.each_with_index(){|e,i|
      @info << ShadowFont.new(e, :x => 2, :y => 17 * i + 2)
    }
  end

  def getF
    p = 1 #密度
    c = 0.001 #抵抗係数
    s = 1 #面積
    v = @a #速度
    p * c * s * v ** 2 #抵抗
  end

  def speed_update
    f = getF
    @a -= f + 0.0001
    @a = 0 if @a < 0
  end

  def update_theta #角度更新
    @theta += @a
  end

  def update_location
    @o = [@image.x, @image.y]
    @images.each_with_index { |e, i|
      e.x = sin(@theta + 90 * i) * @r + @o[0] - 2
      e.y = cos(@theta + 90 * i) * @r + @o[1]
      e.angle = 1
    }
    @button.x = (screen.w - @button.w) / 2
    @button.y = screen.h - (@button.h + 5)
    @button_back.y = @button.y
    @button_back.x = @button.x
    @font.x = (screen.w - @font.w) / 2
    @font.y = @button.y + 2
  end

  def update_color
    if @color_mode == 0
      if @color_t > 2
        @color_t = 2
        @color_mode = 1
      else
        if  @color[@color_t] < 255
          @color[@color_t] += 3
        else
          @color[@color_t] = 255
          @color_t += 1
        end
      end
    else
      if @color_t < 0
        @color_t = 0
        @color_mode = 0
      else
        if  @color[@color_t] > 0
          @color[@color_t] -= 3
        else
          @color[@color_t] = 0
          @color_t -= 1
        end
      end
    end
    @font = ShadowFont.new("SPIN", :size => 45, :color => @color)
  end

  def render
    @images.each {|e| e.render}
    @image.render
    @button.render
    @button_back.render
    @font.render
    @info.each {|e| e.render}
  end
end

Scene.main_loop Main