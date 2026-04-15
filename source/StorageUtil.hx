package;

import lime.system.System as LimeSystem;
import haxe.io.Path;
import haxe.Exception;

#if sys
import sys.*;
import sys.io.*;
#end

#if android
import android.content.Context as AndroidContext;
import android.widget.Toast as AndroidToast;
import android.os.Environment as AndroidEnvironment;
import android.Permissions as AndroidPermissions;
import android.Settings as AndroidSettings;
import android.Tools as AndroidTools;
import android.os.Build.VERSION as AndroidVersion;
import android.os.Build.VERSION_CODES as AndroidVersionCode;
#end

using StringTools;

class StorageUtil {
	public static function getStorageDirectory():String
		return haxe.io.Path.addTrailingSlash(Environment.getExternalStorageDirectory() + '/.' + lime.app.Application.current.meta.get('file'));
	public static function requestPermissions():Void
	{
		if (AndroidVersion.SDK_INT >= AndroidVersionCode.TIRAMISU)
			AndroidPermissions.requestPermissions(['READ_MEDIA_IMAGES', 'READ_MEDIA_VIDEO', 'READ_MEDIA_AUDIO', 'READ_MEDIA_VISUAL_USER_SELECTED']);
		else
			AndroidPermissions.requestPermissions(['READ_EXTERNAL_STORAGE', 'WRITE_EXTERNAL_STORAGE']);

		if (!AndroidEnvironment.isExternalStorageManager())
			AndroidSettings.requestSetting('MANAGE_APP_ALL_FILES_ACCESS_PERMISSION');

		if ((VERSION.SDK_INT >= VERSION_CODES.TIRAMISU
			&& !Permissions.getGrantedPermissions().contains('android.permission.READ_MEDIA_IMAGES'))
			|| (VERSION.SDK_INT < VERSION_CODES.TIRAMISU
				&& !Permissions.getGrantedPermissions().contains('android.permission.READ_EXTERNAL_STORAGE')))
			CoolUtil.showPopUp('If you accepted the permissions you are all good!' + '\nIf you didn\'t then expect a crash' + '\nPress OK to see what happens', 'Notice!');

		try
		{
			if (!FileSystem.exists(StorageUtil.getStorageDirectory()))
				FileSystem.createDirectory(StorageUtil.getStorageDirectory());
		}
		catch (e:Dynamic)
		{
			CoolUtil.showPopUp('Please create directory to\n' + StorageUtil.getStorageDirectory() + '\nPress OK to close the game', 'Error!');
			lime.system.System.exit(1);
		}
	}
}
