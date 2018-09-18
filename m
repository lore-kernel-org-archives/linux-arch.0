Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43001 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeIRMsL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 08:48:11 -0400
Received: by mail-yb1-f194.google.com with SMTP id 13-v6so386412ybn.9
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 00:16:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-3-git-send-email-firoz.khan@linaro.org> <CAMuHMdVR+GKwT8WwjZy+=8j=ndWJ0s0sVnCGFGtsyvPAY9jnHQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 12:46:54 +0530
Message-ID: <CALxhOnheD75br1X_A7h5cNYWdjrDn4ciPc++mYd-_oZJApJyZg@mail.gmail.com>
Subject: Re: [PATCH 2/4] m68k: Replace NR_syscalls macro from asm/unistd.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180918071654.2ZMdpMZ_tCAyjJvclJXP_MTUPKmJxT466swbW0AGRyg@z>

On 9 August 2018 at 13:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Firoz,
>
> One first comment below...
>
> On Thu, Aug 9, 2018 at 7:16 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>> NR_syscalls macro holds the number of system call exist in m68k
>> architecture. This macro is currently the part of asm/unistd.h file.
>> We have to change the value of NR_syscalls, if we add or delete a
>> system call.
>>
>> One of patch in this patch series has a script which will generate
>> a uapi header based on syscall.tbl file. The syscall.tbl file
>> contains the number of system call information. So we have two
>> option to update NR_syscalls value.
>>
>> 1. Update NR_syscalls in asm/unistd.h manually by counting the
>>    no.of system calls. No need to update NR_syscalls untill
>>    we either add a new system call or delete an existing system
>>    call.
>>
>> 2. We can keep this feature it above mentioned script, that'll
>>    count the number of syscalls and keep it in a generated file.
>>    In this case we don't need to explicitly update NR_syscalls
>>    in asm/unistd.h file.
>>
>> The 2nd option will be the recommended one. For that, I moved the
>> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
>> name also changed form NR_syscalls to __NR_syscalls for making the
>> name convention same across all architecture. While __NR_syscalls
>> isn't strictly part of the uapi, having it as part of the generated
>> header to simplifies the implementation.
>
> It can indeed not be part of the UAPI, as UAPI definitions can never change,
> while new syscalls will be added in the future, increasing the number ;-)

Thanks for your reply :)
Sorry for the delayed response :(

I would like to keep __NR_syscalls macro to uapi header in order to simplify
the system call table generation script. Otherwise the __NR_syscalls
macro need to update manually. That become a problem.

Please check the below implementation in uapi file make sense?
It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
and enclose it in #ifdef __KERNEL__

...
...
#define __NR_pwritev2  378
#define __NR_statx      379

#ifdef __KERNEL__
#define __NR_syscalls   380
#endif
...
...

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
