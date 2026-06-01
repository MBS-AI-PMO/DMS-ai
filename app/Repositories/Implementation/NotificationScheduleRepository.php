<?php

namespace App\Repositories\Implementation;

use App\Models\Documents;
use App\Models\ReminderSchedulers;
use App\Repositories\Contracts\NotificationScheduleInterface;
use App\Repositories\Implementation\ConnectionMappingRepository;
use Carbon\Carbon;
use App\Models\FrequencyEnum;
use App\Models\Reminders;
use App\Models\SendEmails;
use App\Models\UserNotifications;
use App\Models\UserNotificationTypeEnum;
use App\Models\Users;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\EmailRepositoryInterface;
use Illuminate\Support\Facades\Storage;


//use Your Model

/**
 * Class NotificationScheduleRepository.
 */
class NotificationScheduleRepository extends BaseRepository implements NotificationScheduleInterface
{
    /**
     * @var Model
     */
    protected $model;


    public $connectionMappingRepository;
    public $emailRepository;

    function __construct(EmailRepositoryInterface $emailRepository)
    {
        $this->connectionMappingRepository = new ConnectionMappingRepository();
        $this->emailRepository = $emailRepository;
    }

    /**
     * BaseRepository constructor.
     *
     * @param Model $model
     */
    public static function model()
    {
        return ReminderSchedulers::class;
    }

    public function dailyReminder()
    {
        $currentDate = Carbon::now();
        $dayOfTheWeek = Carbon::now()->dayOfWeek;

        $reminders = Reminders::with('reminderusers')
            ->join('dailyreminders', 'reminders.id', '=', 'dailyreminders.reminderId')
            ->where('reminders.frequency', '=', FrequencyEnum::Daily->value)
            ->whereDate('reminders.startDate', '<=', $currentDate)
            ->where('dailyreminders.dayOfWeek', '=', $dayOfTheWeek)
            ->where('dailyreminders.isActive', '=', 1)
            ->where(function ($query) use ($currentDate) {
                $query = $query->where('reminders.endDate', '')->orWhereNull('reminders.endDate')
                    ->orWhere(function ($query) use ($currentDate) {
                        $query->whereDate('reminders.endDate', '>=', $currentDate);
                    });
            })
            ->select('reminders.*')
            ->get();

        foreach ($reminders as $r) {
            foreach ($r['reminderusers'] as $users) {
                $duration = Carbon::create($currentDate->format("Y"), $currentDate->format("m"), $currentDate->format("d"),  $r['startDate']->format("h"), $r['startDate']->format("i"), $r['startDate']->format("s"));
                $model = ReminderSchedulers::create([
                    'duration' => $duration,
                    'isActive' => 1,
                    'frequency' => $r['frequency'],
                    'userId' => $users['userId'],
                    'isRead' => 0,
                    'isEmailNotification' => $r['isEmailNotification'],
                    'subject' => $r['subject'],
                    'message' => $r['message'],
                    'createdDate' => Carbon::now(),
                    'documentId' => $r['documentId'],
                ]);
                $model->save();
            }
        }
    }

    public function weeklyReminder()
    {
        $currentDate = Carbon::now();
        $dayOfTheWeek = Carbon::now()->dayOfWeek;

        $reminderQuery = Reminders::select(['reminders.*'])
            ->with(['reminderusers'])
            ->where('reminders.frequency', '=', FrequencyEnum::Weekly->value)
            ->whereDate('reminders.startDate', '<=', $currentDate)
            ->where('reminders.dayOfWeek', '=', $dayOfTheWeek)
            ->where(function ($query) use ($currentDate) {
                $query = $query->where('reminders.endDate', '')->orWhereNull('reminders.endDate')
                    ->orWhere(function ($query) use ($currentDate) {
                        $query->whereDate('reminders.endDate', '>=', $currentDate);
                    });
            });

        $reminders = $reminderQuery->get();
        foreach ($reminders as $r) {
            foreach ($r['reminderusers'] as $users) {
                $duration = Carbon::create($currentDate->format("Y"), $currentDate->format("m"), $currentDate->format("d"),  $r['startDate']->format("h"), $r['startDate']->format("i"), $r['startDate']->format("s"));
                $model = ReminderSchedulers::create([
                    'duration' => $duration,
                    'isActive' => 1,
                    'frequency' => $r['frequency'],
                    'userId' => $users['userId'],
                    'isRead' => 0,
                    'isEmailNotification' => $r['isEmailNotification'],
                    'subject' => $r['subject'],
                    'message' => $r['message'],
                    'createdDate' => Carbon::now(),
                    'documentId' => $r['documentId'],
                ]);
                $model->save();
            }
        }
    }

    public function monthyReminder()
    {
        $currentDate = Carbon::now();  //Carbon::create(2023, 02, 27);

        $lastDayOfMonth = Carbon::now()->endOfMonth()->format("d");

        $reminderQuery = Reminders::select(['reminders.*'])
            ->with(['reminderusers'])
            ->where('reminders.frequency', '=', FrequencyEnum::Monthly->value)
            ->whereDate('reminders.startDate', '<=', $currentDate)
            ->where(function ($query) use ($currentDate) {
                $query = $query->where('reminders.endDate', '')->orWhereNull('reminders.endDate')
                    ->orWhere(function ($query) use ($currentDate) {
                        $query->whereDate('reminders.endDate', '>=', $currentDate);
                    });
            });

        if ($lastDayOfMonth == 28) {
            $reminderQuery = $reminderQuery
                ->whereDay('reminders.startDate', '>=', 28);
        } else if ($lastDayOfMonth == 29) {
            $reminderQuery = $reminderQuery
                ->whereDay('reminders.startDate', '>=', 29);
        } else if ($lastDayOfMonth == 30) {
            $reminderQuery = $reminderQuery
                ->whereDay('reminders.startDate', '>=', 30);
        } else {
            $reminderQuery = $reminderQuery
                ->whereDay('reminders.startDate', '=', $currentDate->format("d"));;
        }

        $reminders = $reminderQuery->get();

        if ($reminders != null && $reminders->count() > 0) {
            foreach ($reminders as $r) {
                foreach ($r['reminderusers'] as $users) {
                    $duration = Carbon::create($currentDate->format("Y"), $currentDate->format("m"), $currentDate->format("d"),  $r['startDate']->format("h"), $r['startDate']->format("i"), $r['startDate']->format("s"));
                    $model = ReminderSchedulers::create([
                        'duration' => $duration,
                        'isActive' => 1,
                        'frequency' => $r['frequency'],
                        'userId' => $users['userId'],
                        'isRead' => 0,
                        'isEmailNotification' => $r['isEmailNotification'],
                        'subject' => $r['subject'],
                        'message' => $r['message'],
                        'createdDate' => Carbon::now(),
                        'documentId' => $r['documentId'],
                    ]);
                    $model->save();
                }
            }
        }
    }

    public function quarterlyReminder()
    {
        $currentDate = Carbon::now();
        $reminderQuery = Reminders::select(['reminders.*'])
            ->with(['reminderusers'])
            ->join('quarterlyreminders', 'reminders.id', '=', 'quarterlyreminders.reminderId')
            ->where('reminders.frequency', '=', FrequencyEnum::Quarterly->value)
            ->whereDate('reminders.startDate', '<=', $currentDate)
            ->where('quarterlyreminders.day', '=',  $currentDate->format("d"))
            ->where('quarterlyreminders.month', '=',  $currentDate->format("m"))
            ->where(function ($query) use ($currentDate) {
                $query = $query->where('reminders.endDate', '')->orWhereNull('reminders.endDate')
                    ->orWhere(function ($query) use ($currentDate) {
                        $query->whereDate('reminders.endDate', '>=', $currentDate);
                    });
            });

        $reminders = $reminderQuery->get();
        foreach ($reminders as $r) {
            foreach ($r['reminderusers'] as $users) {
                $duration = Carbon::create($currentDate->format("Y"), $currentDate->format("m"), $currentDate->format("d"),  $r['startDate']->format("h"), $r['startDate']->format("i"), $r['startDate']->format("s"));
                $model = ReminderSchedulers::create([
                    'duration' => $duration,
                    'isActive' => 1,
                    'frequency' => $r['frequency'],
                    'userId' => $users['userId'],
                    'isRead' => 0,
                    'isEmailNotification' => $r['isEmailNotification'],
                    'subject' => $r['subject'],
                    'message' => $r['message'],
                    'createdDate' => Carbon::now(),
                    'documentId' => $r['documentId'],
                ]);
                $model->save();
            }
        }
    }

    public function halfYearlyReminder()
    {
        $currentDate = Carbon::now();
        $reminderQuery = Reminders::select(['reminders.*'])
            ->with(['reminderusers'])
            ->join('halfyearlyreminders', 'reminders.id', '=', 'halfyearlyreminders.reminderId')
            ->where('reminders.frequency', '=', FrequencyEnum::HalfYearly->value)
            ->whereDate('reminders.startDate', '<=', $currentDate)
            ->where('halfyearlyreminders.day', '=',  $currentDate->format("d"))
            ->where('halfyearlyreminders.month', '=',  $currentDate->format("m"))
            ->where(function ($query) use ($currentDate) {
                $query = $query->where('reminders.endDate', '')->orWhereNull('reminders.endDate')
                    ->orWhere(function ($query) use ($currentDate) {
                        $query->whereDate('reminders.endDate', '>=', $currentDate);
                    });
            });

        $reminders = $reminderQuery->get();
        foreach ($reminders as $r) {
            foreach ($r['reminderusers'] as $users) {
                $duration = Carbon::create($currentDate->format("Y"), $currentDate->format("m"), $currentDate->format("d"),  $r['startDate']->format("h"), $r['startDate']->format("i"), $r['startDate']->format("s"));
                $model = ReminderSchedulers::create([
                    'duration' => $duration,
                    'isActive' => 1,
                    'frequency' => $r['frequency'],
                    'userId' => $users['userId'],
                    'isRead' => 0,
                    'isEmailNotification' => $r['isEmailNotification'],
                    'subject' => $r['subject'],
                    'message' => $r['message'],
                    'createdDate' => Carbon::now(),
                    'documentId' => $r['documentId'],
                ]);
                $model->save();
            }
        }
    }

    public function yearlyReminder()
    {
        $currentDate = Carbon::now();
        $reminderQuery = Reminders::select(['reminders.*'])
            ->with(['reminderusers'])
            ->where('reminders.frequency', '=', FrequencyEnum::Yearly->value)
            ->whereDate('reminders.startDate', '<=', $currentDate)
            ->whereDay('reminders.startDate', '=', $currentDate->format("d"))
            ->whereMonth('reminders.startDate', '=',  $currentDate->format("m"))
            ->where(function ($query) use ($currentDate) {
                $query = $query->where('reminders.endDate', '')->orWhereNull('reminders.endDate')
                    ->orWhere(function ($query) use ($currentDate) {
                        $query->whereDate('reminders.endDate', '>=', $currentDate);
                    });
            });

        $reminders = $reminderQuery->get();
        if ($reminders != null && $reminders->count() > 0) {
            foreach ($reminders as $r) {
                foreach ($r['reminderusers'] as $users) {
                    $duration = Carbon::create($currentDate->format("Y"), $currentDate->format("m"), $currentDate->format("d"),  $r['startDate']->format("h"), $r['startDate']->format("i"), $r['startDate']->format("s"));
                    $model = ReminderSchedulers::create([
                        'duration' => $duration,
                        'isActive' => 1,
                        'frequency' => $r['frequency'],
                        'userId' => $users['userId'],
                        'isRead' => 0,
                        'isEmailNotification' => $r['isEmailNotification'],
                        'subject' => $r['subject'],
                        'message' => $r['message'],
                        'createdDate' => Carbon::now(),
                        'documentId' => $r['documentId'],
                    ]);
                    $model->save();
                }
            }
        }
    }

    public function customDateReminderSchedule()
    {
        $currentDate = Carbon::now();
        $todate = $currentDate->startOfDay();
        $fromDate = $currentDate->endOfDay();

        $reminderQuery = Reminders::select(['reminders.*'])
            ->with(['reminderusers'])
            ->where('reminders.frequency', '=', FrequencyEnum::OneTime->value)
            ->where('reminders.isRepeated', '=', 0)
            ->whereDate('reminders.startDate', '>=', $todate)
            ->whereDate('reminders.startDate', '<=', $fromDate);

        $reminders = $reminderQuery->get();

        if ($reminders != null && $reminders->count() > 0) {
            foreach ($reminders as $r) {
                foreach ($r['reminderusers'] as $users) {
                    $duration = Carbon::create($currentDate->format("Y"), $currentDate->format("m"), $currentDate->format("d"),  $r['startDate']->format("h"), $r['startDate']->format("i"), $r['startDate']->format("s"));
                    $model = ReminderSchedulers::create([
                        'duration' => $duration,
                        'isActive' => 1,
                        'frequency' => $r['frequency'],
                        'userId' => $users['userId'],
                        'isRead' => 0,
                        'isEmailNotification' => $r['isEmailNotification'],
                        'subject' => $r['subject'],
                        'message' => $r['message'],
                        'createdDate' => Carbon::now(),
                        'documentId' => $r['documentId'],
                    ]);
                    $model->save();
                }
            }
        }
    }

    public function reminderSchedule()
    {
        $schedulerStatus = $this->connectionMappingRepository->getSchedulerServiceStatus();
        if (!$schedulerStatus) {
            $this->connectionMappingRepository->setSchedulerServiceStatus(true);
            $this->reminderSchedulerServiceQuery();
            $this->connectionMappingRepository->setSchedulerServiceStatus(false);
        }
    }

    public function sendEmailSchedule()
    {
        $schedulerStatus = $this->connectionMappingRepository->getEmailSchedulerStatus();
        if (!$schedulerStatus) {
            $this->connectionMappingRepository->setEmailSchedulerStatus(true);
            $this->sendEmailSchedulerCommand();
            $this->connectionMappingRepository->setEmailSchedulerStatus(false);
        }
    }

    public function reminderSchedulerServiceQuery()
    {
        $currentDate = Carbon::now();

        $reminderschedulers = ReminderSchedulers::select(['reminderschedulers.*'])
            ->where('isActive', '=', 1)
            ->where('duration', '<=', $currentDate)
            ->orderBy('duration', 'DESC')
            ->take(10)
            ->get();

        if ($reminderschedulers->count() > 0) {

            foreach ($reminderschedulers as $reminderScheduler) {

                $model = UserNotifications::create([
                    'userId' => $reminderScheduler['userId'],
                    'isRead' => 0,
                    'message' => $reminderScheduler['message'],
                    'documentId' => $reminderScheduler['documentId'],
                    'notificationType' => UserNotificationTypeEnum::REMINDER->value,
                ]);

                // $model->createdDate = Carbon::now();
                // $model->modifiedDate = Carbon::now();

                $model->save();

                $user = Users::where('id', $reminderScheduler['userId'])->first();

                if ($reminderScheduler->isEmailNotification) {

                    $sendEmailObject = clone  $reminderScheduler;

                    if ($reminderScheduler['documentId'] != null) {
                        $document =  $this->getDocument($reminderScheduler['documentId']);
                        $fileupload = $document->url;
                        $location = $document->location ?? 'local';
                        if (Storage::disk($location)->exists($fileupload)) {
                            $filename = pathinfo($document->name, PATHINFO_FILENAME);
                            $ext = pathinfo($document->url, PATHINFO_EXTENSION);
                            $sendEmailObject['path'] = Storage::path($fileupload);
                            $sendEmailObject['mime_type'] = Storage::mimeType($fileupload);
                            $sendEmailObject['file_name'] = $filename . '.' . $ext;
                            $sendEmailObject['location'] = $location;
                            $sendEmailObject['doc_url'] = $document->url;
                        }
                    }
                    $sendEmailObject['to_address'] = $user->email;

                    try {
                        $this->emailRepository->sendEmail($sendEmailObject);
                    } catch (\Exception $e) {
                        return $e->getMessage();
                    }
                }

                $reminderScheduler->isActive = false;
                $reminderScheduler->save();
            }
        }
    }

    public function sendEmailSchedulerCommand()
    {
        $sendEmailSchduler = SendEmails::select(['sendemails.*'])
            ->where('isSend', '=', 0)
            ->orderBy('createdDate', 'DESC')
            ->take(10)
            ->get();

        if ($sendEmailSchduler->count() > 0) {
            foreach ($sendEmailSchduler as $sendEmail) {
                if (!empty($sendEmail->email)  && $sendEmail->documentId != null) {
                    $document =  $this->getDocument($sendEmail->documentId);

                    $fileupload = $document->url;
                    $location = $document->location ?? 'local';

                    $sendEmailObject = clone  $sendEmail;

                    if (Storage::disk($location)->exists($fileupload)) {
                        $filename = pathinfo($document->name, PATHINFO_FILENAME);
                        $ext = pathinfo($document->url, PATHINFO_EXTENSION);
                        $sendEmailObject['path'] = Storage::path($fileupload);
                        $sendEmailObject['mime_type'] = Storage::mimeType($fileupload);
                        $sendEmailObject['file_name'] = $filename . '.' . $ext;
                        $sendEmailObject['location'] = $location;
                        $sendEmailObject['doc_url'] = $document->url;
                    }

                    try {
                        $sendEmailObject['to_address'] = $sendEmail->email;
                        $this->emailRepository->sendEmail($sendEmailObject);
                    } catch (\Exception $e) {
                    }
                }
                // }
                $sendEmail->isSend = true;
                $sendEmail->save();
            }
        }
    }

    private function getDocument($documentId)
    {
        $doc = Documents::where('id', $documentId)->first();
        return $doc;
    }
}
