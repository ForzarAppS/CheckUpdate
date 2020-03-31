package com.fas.checkupdate;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.text.method.LinkMovementMethod;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

public class HelpActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_help);

        TextView disk = (TextView)findViewById(R.id.disk);
        if (disk != null) {
            disk.setMovementMethod(LinkMovementMethod.getInstance());
        }
    }

    public void onAClick(View view)
    {
        // выводим сообщение
        String str = "";
        str=str+"             ####"+"\n";
        str=str+"         ########"+"\n";
        str=str+"     ############"+"\n";
        str=str+"## ############ ##"+"\n";
        str=str+"## ############ ##"+"\n";
        str=str+"## ############ ##"+"\n";
        str=str+"      ############"+"\n";
        str=str+"      ############"+"\n";
        str=str+"        ###          ###"+"\n";
        str=str+"        ###          ###";

        final Toast toast = Toast.makeText(this, str, Toast.LENGTH_SHORT);
        toast.show();
    }

    public void onWClick(View view)
    {
        // выводим сообщение
        String str = "";
        str=str+"#####    #####"+"\n";
        str=str+"#####    #####"+"\n";
        str=str+"#####    #####"+"\n";
        str=str+""+"\n";
        str=str+"#####    #####"+"\n";
        str=str+"#####    #####"+"\n";
        str=str+"#####    #####";

        final Toast toast = Toast.makeText(this, str, Toast.LENGTH_SHORT);
        toast.show();
    }
}