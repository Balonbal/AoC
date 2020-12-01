package org.gabeorama.day8;

import java.util.stream.IntStream;

/**
 * Created by Sly on 09.12.2016.
 */
public class Day8 {



    public static void run(String input) {
        int[][] LCD = new int[6][50];
        for (String s: input.split("\n")) {
            if (s.matches("rect \\d+x\\d+")) {
                int A = Integer.parseInt(s.substring(s.indexOf(" ") + 1, s.indexOf("x")));
                int B = Integer.parseInt(s.substring(s.indexOf("x") + 1));

                for (int i = 0; i < B; i++) {
                    for (int j = 0; j < A; j++) {
                        LCD[i][j] = 1;
                    }
                }
            } else if (s.matches("rotate row y=\\d+ by \\d+")) {
                int y = Integer.parseInt(s.substring(s.indexOf("=") + 1, s.indexOf(" ", s.indexOf("="))));
                int m = Integer.parseInt(s.substring(s.lastIndexOf(" ") + 1));

                int[] row = LCD[y].clone();
                for (int i = 0; i < LCD[y].length; i++) {
                    int pos = i - m;
                    if (pos < 0) pos = row.length - m + i;
                    LCD[y][i] = row[pos];
                }
            } else if (s.matches("rotate column x=\\d+ by \\d+")) {
                int x = Integer.parseInt(s.substring(s.indexOf("=") + 1, s.indexOf(" ", s.indexOf("="))));
                int m = Integer.parseInt(s.substring(s.lastIndexOf(" ") + 1));

                for (int i = 0; i < m; i++) {
                    int last = LCD[5][x];
                    for (int j = 5; j > 0; j--) {
                        LCD[j][x] = LCD[j - 1][x];
                    }
                    LCD[0][x] = last;
                }
            }
        }

        printLCD(LCD);

    }

    private static void printLCD(int[][] lcd) {
        int sum = 0;
        for (int[] line: lcd) {
            for (int i: line) {
                System.out.print(i == 1 ? "#" : ".");
                if (i == 1) sum++;
            }
            System.out.println();
        }
        System.out.printf("Sum of 1s: %d", sum);
    }
}
