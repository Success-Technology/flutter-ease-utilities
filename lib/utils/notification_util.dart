


import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ease_utilities/utils/file_operation_util.dart';
import 'package:flutter_ease_utilities/utils/phone_system_util.dart';


class NotificationServices  
{
 
  /// Getting Channel Key 
  static late final key;

  static int count =1010;

  


   /// First Initialization of Notification Channel Key and Descriptions
   static Future<void> initialize({required String channelKey,required String appName,required String channelDescription})async
   {


    bool isInitialized =  await AwesomeNotifications().initialize(
       'resource://drawable/notification_icon', 
       [            // notification icon 
          NotificationChannel(
              channelGroupKey: appName,
              channelKey: channelKey,
              channelName: appName,
              channelDescription: channelDescription,
              channelShowBadge: true,
              importance: NotificationImportance.High,
              enableVibration: true,
              defaultColor: Colors.black,
              ledColor: Colors.indigo
          ),

       ]
    );

    if(isInitialized)
    {
      key = channelKey;
    }
    else 
    {
      //Implement Exception Handling
    }
   }
     
   

   /// Action Listener for getting notifications
   static void notificationServiceListener(Function(ReceivedAction goods) onAction)
   {
     AwesomeNotifications().actionStream.listen(onAction);
   }

   /// Getting NotificationCalendar Object
   static Future<NotificationCalendar> getScheduleTime(BuildContext context)async 
   {
     TimeOfDay nowTime = TimeOfDay.now();
     TimeOfDay? selectedTime =await showTimePicker(
      context: context,
      initialTime: nowTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
     DateTime today = DateTime.now();
     NotificationCalendar dueTime = NotificationCalendar.fromDate(   
    date : DateTime(  
      today.year,today.month,today.day,nowTime.hour,nowTime.minute
    )
    ) ;
   
    if(selectedTime != null && selectedTime != nowTime)
      {
        dueTime = NotificationCalendar.fromDate(   
        date : DateTime(  
          today.year,today.month,today.day,selectedTime.hour,selectedTime.minute
        )
        ) ;
        return dueTime;
      }
    return dueTime;
   }

   /// Getting Week Day Schedule Object [NotificationWeekAndDay]

  static Future<NotificationCalendar> getScheduleDayAndTime(
    BuildContext context,
  ) async {
    List<String> weekdays = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',

    ];
    
    TimeOfDay nowTime = TimeOfDay.now();
    TimeOfDay dueTime = nowTime;
    DateTime now = DateTime.now();
    int todayWeekDay = now.weekday;
    int? selectedDay;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:const Text(
            'Select day of the week',
            textAlign: TextAlign.center,
            style:TextStyle(color:Colors.black45)
          ),
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.7),width: 1.5)),
          content: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 3,
            children: [
              for (int index = 0; index < weekdays.length; index++)
                OutlinedButton(
                  onPressed: ()async {
                    selectedDay = index + 1;
                    dueTime = await showTimePicker(
                      context: context,
                      initialTime: nowTime,
                      initialEntryMode: TimePickerEntryMode.dial,
                    ) ?? nowTime;

                    Navigator.pop(context);

                  },
                  style: OutlinedButton.styleFrom(
                     shape: const StadiumBorder()
                  ),
                  child: Text(
                   "  ${ weekdays[index]}  ",
                  ),
                ),
               
              OutlinedButton(
                onPressed: ()async {
                  selectedDay = todayWeekDay;
                  dueTime = await showTimePicker(
                    context: context,
                    initialTime: nowTime,
                    initialEntryMode: TimePickerEntryMode.dial,
                  ) ?? nowTime;

                  Navigator.pop(context);

                },
                style: OutlinedButton.styleFrom(
                   shape: const StadiumBorder(),
                   side: BorderSide(color:Theme.of(context).primaryColor ),
                
                ),
                child:const Text(
                 "    Today    "
                ),
              ),
            ],
          ),
        );
      },
    );

    return NotificationCalendar(weekday: selectedDay,hour: dueTime.hour,minute : dueTime.minute);
  }


   /// Creating notification 
   static Future<void> createNotification(BuildContext context,{required String title, required String bodyText,String? image,required Map<String,String> data,List<NotificationActionButton>? actionButtons,bool showLog:false}) async
   {
      bool isCreated =false;
      
       isCreated = await AwesomeNotifications().createNotification(content: getSampleContent( title: title,bodyText: bodyText,data: data,image: image),schedule: await getScheduleDayAndTime(context),actionButtons: actionButtons,
    );
   
    
    if(isCreated && showLog)
    {
       showSnack(context,'Notification is created');
    }

    
    
   }

   /// Custom Notification \
   /// User asset image with prefix --> "asset://assets/yourPhoto.png"
   static Future<void> createCustomNotification(BuildContext context,{required NotificationContent content,List<NotificationActionButton>? actionButtons}) async
   {
       AwesomeNotifications().createNotification(content: content,schedule:await getScheduleDayAndTime(context),actionButtons: actionButtons,
    );
   }

   /// Testing Notification
   /// User asset image with prefix --> "asset://assets/yourPhoto.png"
  static Future<void> testNotification(BuildContext context,{required String title, required String bodyText,String? image,required Map<String,String> data,List<NotificationActionButton>? actionButtons,bool showLog=false}) async
   {
      bool isCreated = await AwesomeNotifications().createNotification(content: getSampleContent( title: title,bodyText: bodyText,data: data,image: image),actionButtons: actionButtons,
    );
    
    if(isCreated && showLog)
    {
       showSnack(context,'Notification is created');
    }

    debugConsole(image.toString());
    
   }

   /// Funny Easy Default Notification Content \
   /// ID must be different ones each other
   static NotificationContent getSampleContent({required String title, required String bodyText,String? image,required Map<String,String> data}) 
   {
       return NotificationContent( //simgple notification
        id: count++,
        channelKey: NotificationServices.key, //set configuration wuth key "basic"
        title: title,
        body: bodyText,
        payload: data,
        autoDismissible: false,
        category: NotificationCategory.Reminder,
        notificationLayout: NotificationLayout.BigPicture,
        wakeUpScreen: true,
        color: Colors.red,
        // roundedBigPicture: true,
        bigPicture: image,
    );
   }


   /// Getting All Scheduled Notifications \
   /// Return : `List<NotificationModel>` 
   static Future<List<NotificationModel>> getScheduledNotifications()async 
   {
     return AwesomeNotifications().listScheduledNotifications();
   }


   /// Deleting notifications created 
   static Future<void> deleteNotification(int id)async 
   {
      await AwesomeNotifications().cancelSchedule(id);
   }

   /// Deleting all notifications created 
   static Future<void> clearNotifications()async 
   {
      await AwesomeNotifications().cancelAllSchedules();
   }

   
}



