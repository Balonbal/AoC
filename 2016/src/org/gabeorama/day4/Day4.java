package org.gabeorama.day4;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Created by Sly on 08.12.2016.
 */
public class Day4 {

    public static void run(String input) {
        int count = 0;
        for (String line: input.split("\n")) {
            Map<Character, Integer> map = new HashMap<>();

            String token = line.substring(line.lastIndexOf("-") + 1);
            int key = Integer.parseInt(token.substring(0, token.indexOf("[")));
            String letters = token.substring(token.indexOf("[") + 1, token.indexOf("]"));
            String fullText = line.substring(0, line.lastIndexOf("-")).replaceAll("-", "");

            for (int i = 0; i < fullText.length(); i++) {
                char c = fullText.charAt(i);
                if (map.containsKey(c)) map.put(c, map.get(c) + 1);
                else map.put(c, 1);
            }

            String top = map.entrySet().stream().sorted(Map.Entry.comparingByKey())
                    .sorted(Collections.reverseOrder(Map.Entry.comparingByValue()))
                    .limit(5)
                    .map(Map.Entry::getKey)
                    .map(x -> Character.toString(x))
                    .collect(Collectors.joining(""));

            if (top.equals(letters)) count += key;
        }

        System.out.printf("Sum is %d\n", count);
    }

    public static void run2(String input) {
        for (String line: input.split("\n")) {
            String token = line.substring(line.lastIndexOf("-") + 1);
            int key = Integer.parseInt(token.substring(0, token.indexOf("[")));
            line = line.substring(0, line.lastIndexOf("-"));
            for (int i = 0; i  <= 26; i++) {
                StringBuilder builder = new StringBuilder();
                for (int j = 0; j < line.length(); j++) {
                    if (line.charAt(j) == '-') { builder.append(" "); continue; }
                    char c = (char) (line.charAt(j) + i);
                    if (c > 'z') c = (char) (line.charAt(j) - (26 - i));
                    builder.append(c);

                }
                if (builder.toString().contains("north")) System.out.printf("%d: %s", key, builder.toString());
            }
        }
    }
}
