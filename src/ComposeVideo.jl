
using Gadfly

module ComposeVideo
	
	using Gadfly
		
	export 
	VideoBuilder,
	add_frame,
	display_video

	include("to_video.jl")

end 
