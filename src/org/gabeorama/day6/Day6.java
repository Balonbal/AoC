package org.gabeorama.day6;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by Sly on 08.12.2016.
 */
public class Day6 {

    public static void run(String input) {
        List<Map<Character, Integer>> list = new ArrayList<>(input.length());
        for (int i = 0; i < input.length(); i++) {
            list.add(new HashMap<>());
        }
        for (String line: input.split("\n")) {
            for (int i = 0; i < line.length(); i++) {
                if (list.get(i).containsKey(line.charAt(i))) list.get(i).put(line.charAt(i), list.get(i).get(line.charAt(i)) + 1);
                else list.get(i).put(line.charAt(i), 1);
            }
        }

        for (Map<Character, Integer> map: list) {
            String top = map.entrySet().stream().sorted(Map.Entry.comparingByKey())
                    //.sorted(Collections.reverseOrder(Map.Entry.comparingByValue())) //for part 1
                    .sorted(Map.Entry.comparingByValue()) //for part 2
                    .limit(1)
                    .map(Map.Entry::getKey)
                    .map(x -> Character.toString(x))
                    .collect(Collectors.joining(""));
            System.out.print(top);
        }
    }

}
