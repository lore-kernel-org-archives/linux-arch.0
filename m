From: Kees Cook <keescook@chromium.org>
Subject: Re: [kernel-hardening] [PATCH v4 3/8] param: convert some "on"/"off"
 users to strtobool
Date: Wed, 27 Jan 2016 13:19:19 -0800
Message-ID: <CAGXu5j+DLRoVE88a9++jVfEkN90HDiAaDAMnT2TrKqtMZ_yOww@mail.gmail.com>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
	<1453226922-16831-4-git-send-email-keescook@chromium.org>
	<20160127211105.GA41450@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33008 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967994AbcA0VTU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jan 2016 16:19:20 -0500
Received: by mail-ig0-f180.google.com with SMTP id z14so90636657igp.0
        for <linux-arch@vger.kernel.org>; Wed, 27 Jan 2016 13:19:19 -0800 (PST)
In-Reply-To: <20160127211105.GA41450@davidb.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Brown <david.brown@linaro.org>
Cc: "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Wed, Jan 27, 2016 at 1:11 PM, David Brown <david.brown@linaro.org> w=
rote:
> On Tue, Jan 19, 2016 at 10:08:37AM -0800, Kees Cook wrote:
>
>> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
>> index 9cc20af58c76..f5ea98490ffa 100644
>> --- a/kernel/time/tick-sched.c
>> +++ b/kernel/time/tick-sched.c
>> @@ -387,20 +388,14 @@ void __init tick_nohz_init(void)
>> /*
>>  * NO HZ enabled ?
>>  */
>> -static int tick_nohz_enabled __read_mostly  =3D 1;
>> +static bool tick_nohz_enabled __read_mostly  =3D true;
>> unsigned long tick_nohz_active  __read_mostly;
>> /*
>>  * Enable / Disable tickless mode
>>  */
>
>
> Just discovered this conflicts with a recent patch with
> CONFIG_NO_HZ_COMMON:
>
>         commit 46373a15f65fe862f31c19a484acdf551f2b442f
>         Author: Jean Delvare <jdelvare@suse.de>
>         Date:   Mon Jan 11 17:40:31 2016 +0100
>
>             time: nohz: Expose tick_nohz_enabled
>
> kernel/time/tick-sched.c:390:6: error: conflicting types for
> =E2=80=98tick_nohz_enabled=E2=80=99
>         bool tick_nohz_enabled __read_mostly =3D true;
>              ^
> In file included from kernel/time/tick-internal.h:5:0,
>                 from kernel/time/tick-sched.c:30:
> include/linux/tick.h:101:12: note: previous declaration of
> =E2=80=98tick_nohz_enabled=E2=80=99 was here
>         extern int tick_nohz_enabled;
>                    ^

Thanks! Yeah, I noticed this too when rebasing recently.

> Fixing the compilation error, it compiles and boots on arm64, however
> it isn't detecting the write (with the lkdtm test).  I'll continue
> looking into what's preventing this.

I'm going to hope it's something easy like CONFIG_DEBUG_RODATA not bein=
g set. :)

-Kees

--=20
Kees Cook
Chrome OS & Brillo Security
