/*
ID: eric_ya1
LANG: JAVA
TASK: ${NAME}
*/

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;

class ${NAME} {

    private static final boolean FILE = false;
    private static final String LN = System.getProperty("line.separator");
    
    private void run(BufferedReader br, BufferedWriter bw) throws IOException {
    
    }

    public static void main(String[] args) throws IOException {
        BufferedReader br;
        BufferedWriter bw;
        
        if (FILE) {
            br = new BufferedReader(new FileReader("${NAME}.in"));
            bw = new BufferedWriter(new FileWriter("${NAME}.out"));
        } else {
            br = new BufferedReader(new InputStreamReader(System.in));
            bw = new BufferedWriter(new OutputStreamWriter(System.out));
        }
        
        new ${NAME}().run(br, bw);
        br.close();
        bw.close();
    }
}

