
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;

public class Video2Pic {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println(">>>>>>>>>> 没有提供视频文件路径，无法转换！");
            return;
        }

        String videoPath = args[0];
        File file = new File(videoPath);

        if (!file.exists() || !file.isFile()) {
            System.out.println(">>>>>>>>>> 视频文件路径错误，无法转换！");
            return;
        }

        String directory = file.getParent();
        String outputImagePath = directory + "\\images"; // 输出图片的路径和格式

        File outputFile = new File(outputImagePath);
        if (!outputFile.exists()) {
            outputFile.mkdirs();
        }

        // ffmpeg 命令
        String[] command = {
            "ffmpeg",
            "-i", 
			file.getAbsolutePath(),
            outputImagePath + "\\%03d.jpg"
        };

        // 执行命令
        try {
            ProcessBuilder processBuilder = new ProcessBuilder(command);
            processBuilder.redirectErrorStream(true);
            Process process = processBuilder.start();
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line;

            // 输出 FFmpeg 的输出信息
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }

            // 等待进程结束
            int exitCode = process.waitFor();
            if (exitCode == 0) {
                System.out.println(">>>>>>>>>> 视频转换为图片列表成功！");
                System.out.println(">>>>>>>>>> 图片路径：" + outputImagePath);
            } else {
                System.out.println(">>>>>>>>>> 视频转换失败，退出代码：" + exitCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}