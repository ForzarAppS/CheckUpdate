package com.fas.checkupdate;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

public class MainActivity extends AppCompatActivity {

    //поля ввода
    EditText etLink;
    EditText etNowVersion;

    //настройки
    SharedPreferences sp;
    SharedPreferences mSettings;
    public static final String APP_PREFERENCES = "mysettings";

    //ссылка на обновление
    final String Link = "https://yadi.sk/d/_Cu2g_PYW9gIuw";
    //текущая версия
    String NowVersion;

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

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //поля ввода
        etLink = (EditText) findViewById(R.id.etLink);
        etNowVersion = (EditText) findViewById(R.id.etNowVersion);

        etLink.setText(Link);
        Version();
        etNowVersion.setText(NowVersion);

        // получаем SharedPreferences, которое работает с файлом настроек
        sp = PreferenceManager.getDefaultSharedPreferences(this);
        mSettings = getSharedPreferences(APP_PREFERENCES, Context.MODE_PRIVATE);
    }

    //кнопка проверки
    public void onCheckClick(View view) {
        //проверка соединения с интернетом
        if(isNetwork()) {

            //проверка на пустую ссылку
            if(!etLink.getText().toString().equals("")){
                //проверка на пустую версию
                if(!etNowVersion.getText().toString().equals("")){
                    //вызов парсера
                    new GetTask(this, true, etLink.getText().toString(), etNowVersion.getText().toString()).execute();
                }
                else{
                    //вывод сообщения
                    ShowMessage("Информация","Заполните текущую версию.");
                }
            }
            else{
                //вывод сообщения
                ShowMessage("Информация","Заполните ссылку для проверки.");
            }
        }
        else {
            //вывод сообщения
            ShowMessage("Внимание!","Отсутствует интернет-соединение!");
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
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(Title)
                .setMessage(Message)
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

    //вывод диалога
    protected void ShowDialog(String Title, String Message, final String Link) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
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
        AlertDialog alert = builder.create();
        alert.show();
    }

    //создание меню
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    //нажатие на "настройки" в меню
    public void onSettingsMenuClick(MenuItem item) {
        Intent intent = new Intent(this, Preferences.class);
        startActivity(intent);
    }

    //нажатие на "помощь" в меню
    public void onHelpMenuClick(MenuItem item) {
        Intent intent = new Intent(this, HelpActivity.class);
        startActivity(intent);
    }

    //нажатие на "о программе" в меню
    public void onAboutMenuClick(MenuItem item) {
        Intent intent = new Intent(this, AboutActivity.class);
        startActivity(intent);
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

    @Override
    protected void onResume() {
        super.onResume();

        Version();

        if (sp.getBoolean("AutoUpdate", true)) {
            //проверка соединения с интернетом
            if(isNetwork()) {
                new GetTask(this,false, Link, NowVersion).execute();
            }
        }
    }
}