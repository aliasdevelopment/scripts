ffmpeg -hwaccels

ffmpeg -y -vaapi_device /dev/dri/renderD128 -f x11grab -video_size 1920x1080 -i :0 -vf 'format=nv12,hwupload' -c:v h264_vaapi -crf 28 -preset ultrafast /tmp/output.mp4

ffmpeg -vaapi_device /dev/dri/renderD128 -f v4l2 -video_size 1920x1080 -i /dev/video0 -vf 'format=nv12,hwupload' -c:v h264_vaapi output.mp4



ffmpeg -y -vaapi_device /dev/dri/renderD128 -f x11grab -video_size 1920x1080 -i :0 -vf 'hwupload,scale_vaapi=format=nv12' -c:v h264_vaapi -qp 24 /tmp/output.mp4


spawn ffmpeg -y -r 15 -f x11grab -draw_mouse 1 -video_size ${DIMENSION_X}x${DIMENSION_Y} -hwaccel vaapi -thread_queue_size 32768 -i :${APPLICATION_DISPLAY} -f x11grab -r 15 -video_size ${DIMENSION_X}x${DIMENSION_Y} -hwaccel vaapi -thread_queue_size 32768 -i :${APPLICATION_DISPLAY_OVERLAY} -filter_complex "\[0\]format=rgba,scale=500x800\[bottom\]; \[1\]chromakey=000000:0.01:0.0,scale=500x800\[top\],\[bottom\]\[top\]overlay\[out\]" -map "\[out\]" -codec:v libx264 -crf 28 -preset ultrafast -tune stillimage -pix_fmt yuv420p /tmp/output.mp4


ffmpeg -loglevel debug -y -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -f x11grab -s 1920x1080 -i :0 -filter_complex "[0]format=nv12,hwupload[out]" -map "[out]" -vcodec h264_vaapi -qp 19 -bf 2 -profile:v:0 high /tmp/output.mp4

ffmpeg -loglevel debug -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -i "input
file" -vf 'format=nv12,hwupload' -map 0:0 -map 0:1 -threads 8 -aspect
16:9 -y -f matroska -acodec copy -b:v 12500k -vcodec h264_vaapi
"output file"


ffmpeg -y -r 15 -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -f x11grab -draw_mouse 1 -thread_queue_size 1024 -i :99 -hwaccel vaapi -vaapi_device /dev/dri/renderD128 -f x11grab -r 15 -thread_queue_size 1024 -i :98 -filter_complex "[0]hwupload,scale_vaapi=format=nv12[bottom];[1]hwupload,scale_vaapi=format=nv12[top];[bottom][top]overlay[out]" -map "[out]" -vcodec h264_vaapi -qp 19 -bf 2 -profile:v:0 main /tmp/output.mp4

ffmpeg -y -i /tmp/main.mp4 -i /tmp/overlay.mp4 -filter_complex "[0]format=rgba,scale=500x800[bottom]; [1]chromakey=000000:0.05:0.0,scale=500x800[top],[bottom][top]overlay[out]" -map "[out]" -codec:v libx264 -pix_fmt yuv420p /tmp/output.mp4
