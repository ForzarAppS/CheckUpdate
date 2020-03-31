package com.fas.checkupdate;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.method.LinkMovementMethod;
import android.view.View;
import android.widget.TextView;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

public class AboutActivity extends AppCompatActivity {

    //почта
    TextView mail;

    //ссылка на обновление
    final String Link = "https://yadi.sk/d/_Cu2g_PYW9gIuw";
    //текущая версия
    String NowVersion;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);

        TextView NowVersion = (TextView)findViewById(R.id.NowVersion);

        try {
            PackageInfo pInfo = this.getPackageManager().getPackageInfo(getPackageName(), 0);
            NowVersion.setText("v"+pInfo.versionName+" (01.04.2020)");
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }

        TextView vk = (TextView)findViewById(R.id.LinkVk);
        if (vk != null) {
            vk.setMovementMethod(LinkMovementMethod.getInstance());
        }

        mail = (TextView)findViewById(R.id.LinkMail);
    }

    //кнопка что нового
    public void onNewClick(View view) {
        String str="";

        /*str=str+"v1.0 (01.04.2020):"+"\n";
        str=str+"▶ Релизная версия"+"\n"+"\n";*/

        str=str+"v1.0 (01.04.2020):"+"\n";
        str=str+"▶ Релизная версия";

        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(R.string.NewUpdate)
                .setMessage(str)
                .setCancelable(false)
                .setNegativeButton("ОК",
                        new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                dialog.cancel();
                            }
                        });
        AlertDialog alert = builder.create();
        alert.show();
    }

    //кнопка почты
    public void onMailClick(View view) {
        Intent intent = new Intent(Intent.ACTION_SENDTO);
        intent.setData(Uri.parse("mailto:")); // only email apps should handle this
        intent.putExtra(Intent.EXTRA_EMAIL, mail.getText());
        if (intent.resolveActivity(getPackageManager()) != null) {
            startActivity(intent);
        }
        else{
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle("Ошибка!")
                    .setMessage("Нет почтового клиента!")
                    .setCancelable(false)
                    .setNegativeButton("ОК",
                            new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    dialog.cancel();
                                }
                            });
            AlertDialog alert = builder.create();
            alert.show();
        }
    }

    //парсер
    public class GetTask extends AsyncTask<Void, Void, Void> {

        //контекст
        private Context context;

        //содержимое тега
        Element DataAll;

        //вывод сообщений обновлений
        Boolean Message;

        //ссылка обновления
        String FileUpdate;
        //текущая версия
        String NowVersion;

        //передача контекста
        public GetTask(Context context, Boolean Message, String FileUpdate, String NowVersion){
            this.context=context;
            this.Message=Message;
            this.FileUpdate=FileUpdate;
            this.NowVersion=NowVersion;
        }

        @Override
        protected Void doInBackground(Void... voids) {
            //получение данных
            getAnswer(FileUpdate);

            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            super.onPostExecute(result);

            //настройка данных
            setData();
        }

        //получение данных
        public void getAnswer(String Link) {
            //переменная html документа
            Document DocHTML = null;

            try {
                //путь к HTML странице
                DocHTML = Jsoup.connect(Link).get();

                //имя тега, по которому будет произведён поиск
                DataAll = DocHTML.select("title").first();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        //настройка данных
        public void setData() {
            //вспомогательная переменная
            String Data;
            //выходные данные
            //ссылка на обновление
            String LinkUpdate;
            //новая версия
            String NewVersion;

            //переход к строке
            Data = DataAll.toString();
            //название файла без расширения
            Data = Data.substring(7, Data.indexOf("</title>")-18);
            //название файла без расширения и названия проекта
            Data = Data.substring(Data.indexOf("_v_")+3);
            //проверка на незаполненность ссылки на новую версию
            if (Data.indexOf("_") > 0) {
                //проверка на новую версию
                if(!NowVersion.equals(Data.substring(0,Data.indexOf("_")))){
                    //ссылка на обновление
                    LinkUpdate = "https://yadi.sk/d/"+Data.substring(Data.indexOf("_")+1);
                    //новая версия
                    NewVersion = Data.substring(0, Data.indexOf("_"));

                    //вывод диалога
                    ShowDialog("Внимание!","Выпущена новая версия программы (v"+NewVersion+"). Перейти на страницу для скачивания?", LinkUpdate);
                }
                else{
                    if (Message) {
                        //вывод сообщения
                        ShowMessage("Внимание!", "Обновление не требуется.");
                    }
                }
            }
            else{
                if (Message) {
                    //вывод сообщения
                    ShowMessage("Информация", "Обновлений нет.");
                }
            }
        }
    }

    //вывод сообщения
    protected void ShowMessage(String Title, String Message) {
        androidx.appcompat.app.AlertDialog.Builder builder = new androidx.appcompat.app.AlertDialog.Builder(this);
        builder.setTitle(Title)
                .setMessage(Message)
                .setCancelable(false)
                .setNegativeButton("ОК",
                        new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                dialog.cancel();
                            }
                        });
        androidx.appcompat.app.AlertDialog alert = builder.create();
        alert.show();
    }

    //вывод диалога
    protected void ShowDialog(String Title, String Message, final String Link) {
        androidx.appcompat.app.AlertDialog.Builder builder = new androidx.appcompat.app.AlertDialog.Builder(this);
        builder.setTitle(Title)
                .setMessage(Message)
                .setCancelable(false)
                .setPositiveButton("Да",
                        new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                Intent Openlink = new Intent(Intent.ACTION_VIEW, Uri.parse(Link));
                                startActivity(Openlink);
                            }
                        })
                .setNegativeButton("Нет",
                        new DialogInterface.OnClickListener() {
                            public void onClick(DialogInterface dialog, int id) {
                                dialog.cancel();
                            }
                        });
        androidx.appcompat.app.AlertDialog alert = builder.create();
        alert.show();
    }

    //проверка соединения с интернетом
    public boolean isNetwork(){
        boolean network_WiFi=false;
        boolean network_Mobile=false;

        ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo[] networkInfo = connectivityManager.getAllNetworkInfo();

        for(NetworkInfo info: networkInfo){
            if(info.getTypeName().equalsIgnoreCase("WIFI")){
                if(info.isConnected()){
                    network_WiFi=true;
                }
            }

            if(info.getTypeName().equalsIgnoreCase("MOBILE")){
                if(info.isConnected()){
                    network_Mobile=true;
                }
            }
        }
        return network_Mobile||network_WiFi;
    }

    //получить версию обновления
    protected void Version() {
        try {
            PackageInfo pInfo = this.getPackageManager().getPackageInfo(getPackageName(), 0);
            NowVersion = pInfo.versionName;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
    }

    //кнопка проверки обновления
    public void onCheckUpdateClick(View view) {
        Version();
        //проверка соединения с интернетом
        if(isNetwork()) {
            new GetTask(this,true, Link, NowVersion).execute();
        }
        else {
            //вывод сообщения
            ShowMessage("Внимание!","Отсутствует интернет-соединение!");
        }
    }
}