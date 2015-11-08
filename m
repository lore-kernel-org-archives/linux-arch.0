From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 21/28] lkl tools: host lib: posix host operations
Date: Sun, 8 Nov 2015 06:01:08 +0200
Message-ID: <CAE1zotLiR_4KdPtVr8MANb2kKVhUZKzCCaUdEV=0cBTfkV2KQw@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<1446582059-17355-22-git-send-email-octavian.purdila@intel.com>
	<42449799.QsmXDGnQ4P@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:32770 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbKHEBK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 23:01:10 -0500
Received: by wiby19 with SMTP id y19so695963wib.0
        for <linux-arch@vger.kernel.org>; Sat, 07 Nov 2015 20:01:09 -0800 (PST)
In-Reply-To: <42449799.QsmXDGnQ4P@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Sun, Nov 8, 2015 at 1:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 November 2015 22:20:52 Octavian Purdila wrote:
>> +struct pthread_sem {
>> +     pthread_mutex_t lock;
>> +     int count;
>> +     pthread_cond_t cond;
>> +};
>> +
>> +static void *sem_alloc(int count)
>> +{
>> +     struct pthread_sem *sem;
>> +
>> +     sem = malloc(sizeof(*sem));
>> +     if (!sem)
>> +             return NULL;
>> +
>> +     pthread_mutex_init(&sem->lock, NULL);
>> +     sem->count = count;
>> +     pthread_cond_init(&sem->cond, NULL);
>> +
>> +     return sem;
>> +}
>
> What is the reason to have generalized semaphores in the
> host API rather than a simple mutex?
>

Currently waking up from idle after an IRQ event requires a semaphore.
I'll see if we can use a simple mutex for this.

>> +static unsigned long long time_ns(void)
>> +{
>> +     struct timeval tv;
>> +
>> +     gettimeofday(&tv, NULL);
>> +
>> +     return tv.tv_sec * 1000000000ULL + tv.tv_usec * 1000ULL;
>> +}
>
> clock_gettime() has been around since POSIX.1-2001 and provides the
> nanosecond resolution you use in the interface.
>

Good point, I will change it to clock_gettime.

Thanks for the review Arnd !
