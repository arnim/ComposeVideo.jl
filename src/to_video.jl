
type VideoBuilder
  already::Int
	path::String
	VideoBuilder() = new(0, mktempdir())
end


function add_frame(v::VideoBuilder, pl::Plot; width=480px, height=360px)
	location = v.path * "/" * string(v.already += 1) * ".png"
	draw(PNG(location, width, height), pl)
  run(`convert $location -background white -flatten $location`)
end


function html_video(filename)
	base64_video = base64(open(readbytes, filename))
	"""<video controls src="data:video/x-m4v;base64,$base64_video">"""
end

function display_video(v::VideoBuilder; frame_rate::Int = 10, loglevel::String="quiet")
	vid_loc = v.path * "/$(hash(rand())).mp4"
	e_exp = `ffmpeg -loglevel $loglevel -r $frame_rate -i $(v.path)/%d.png -c:v libx264 -crf 23 -pix_fmt yuv420p $vid_loc`	
	run(e_exp)
	display("text/html", html_video(vid_loc))
end


