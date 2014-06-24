Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:49321 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbaFXTVW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jun 2014 15:21:22 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so2895lab.10
        for <linux-arch@vger.kernel.org>; Tue, 24 Jun 2014 12:21:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140624191815.GA3623@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-5-git-send-email-keescook@chromium.org> <20140624191815.GA3623@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 24 Jun 2014 12:20:59 -0700
Message-ID: <CALCETrVgpP=zOtiQafVgcic2T95TdEM5DTvHYXWTbcZ14xBqHQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@chromium.org>, David Drysdale <drysdale@google.com>, Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Message-ID: <20140624192059.j9SZvLyRU-CNebQtzkajlgnSX7If5_zz79Qqn7weitI@z>

On Tue, Jun 24, 2014 at 12:18 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/23, Kees Cook wrote:
>>
>> --- a/include/linux/seccomp.h
>> +++ b/include/linux/seccomp.h
>> @@ -3,6 +3,8 @@
>>
>>  #include <uapi/linux/seccomp.h>
>>
>> +#define SECCOMP_FLAG_NO_NEW_PRIVS    0       /* task may not gain privs */
>> +
>>  #ifdef CONFIG_SECCOMP
>>
>>  #include <linux/thread_info.h>
>> @@ -16,6 +18,7 @@ struct seccomp_filter;
>>   *         system calls available to a process.
>>   * @filter: must always point to a valid seccomp-filter or NULL as it is
>>   *          accessed without locking during system call entry.
>> + * @flags: flags under task->sighand->siglock lock
>>   *
>>   *          @filter must only be accessed from the context of current as there
>>   *          is no read locking.
>> @@ -23,6 +26,7 @@ struct seccomp_filter;
>>  struct seccomp {
>>       int mode;
>>       struct seccomp_filter *filter;
>> +     unsigned long flags;
>>  };
>>
>>  extern int __secure_computing(int);
>> @@ -51,7 +55,9 @@ static inline int seccomp_mode(struct seccomp *s)
>>
>>  #include <linux/errno.h>
>>
>> -struct seccomp { };
>> +struct seccomp {
>> +     unsigned long flags;
>> +};
>
> A bit messy ;)
>
> I am wondering if we can simply do
>
>         static inline bool current_no_new_privs(void)
>         {
>                 if (current->no_new_privs)
>                         return true;
>
>         #ifdef CONFIG_SECCOMP
>                 if (test_thread_flag(TIF_SECCOMP))
>                         return true;
>         #endif

Nope -- privileged users can enable seccomp w/o nnp.

--Andy
