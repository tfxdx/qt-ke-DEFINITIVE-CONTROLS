package;

import lime.system.System;
import haxe.io.Path;
import sys.FileSystem;
import android.os.Environment;
import android.Settings;
import android.Permissions;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

class StorageUtil {
	public static function getStorageDirectory():String
		return Path.addTrailingSlash(Environment.getExternalStorageDirectory() + '/.' + lime.app.Application.current.meta.get('file'));
	public static function requestPermissions():Void
	{
		if (VERSION.SDK_INT >= VERSION_CODES.TIRAMISU)
			Permissions.requestPermissions(['READ_MEDIA_IMAGES', 'READ_MEDIA_VIDEO', 'READ_MEDIA_AUDIO', 'READ_MEDIA_VISUAL_USER_SELECTED']);
		else
			Permissions.requestPermissions(['READ_EXTERNAL_STORAGE', 'WRITE_EXTERNAL_STORAGE']);

		if (!Environment.isExternalStorageManager())
			Settings.requestSetting('MANAGE_APP_ALL_FILES_ACCESS_PERMISSION');

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
			System.exit(1);
		}
	}
}
