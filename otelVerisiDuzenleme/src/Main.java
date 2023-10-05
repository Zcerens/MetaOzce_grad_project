import java.io.*;

public class Main {
    public static void main(String[] args) {

        String dosyaAdi = "metin.txt"; // Değiştirilecek metin dosyasının adı
        String hedefDosyaAdi = "yeni_metin.txt"; // Değiştirilmiş metnin kaydedileceği dosya

        try {
            BufferedReader br = new BufferedReader(new FileReader(dosyaAdi));
            BufferedWriter bw = new BufferedWriter(new FileWriter(hedefDosyaAdi));

            String satir;
            while ((satir = br.readLine()) != null) {
                // "trad" kelimesini "bip" ile değiştir
                satir = satir.replaceAll("trap", "bip");
                bw.write(satir); // Değiştirilmiş satırı yeni dosyaya yaz
                bw.newLine(); // Yeni satır ekleyerek düzgün biçimde yaz
            }

            br.close();
            bw.close();
            System.out.println("Değiştirme işlemi tamamlandı.");
        } catch (IOException e) {
            e.printStackTrace();
        }
       
    }
}