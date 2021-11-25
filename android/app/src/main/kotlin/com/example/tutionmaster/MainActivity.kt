package com.example.tutionmaster

import io.flutter.embedding.android.FlutterActivity;
import android.view.WindowManager.LayoutParams;
import android.os.Bundle;

class MainActivity: FlutterActivity() {
@Override
protected void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  
  getWindow().addFlags(LayoutParams.FLAG_SECURE); 
  
}
}
