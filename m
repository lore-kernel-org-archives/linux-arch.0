Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38881 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRMn4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 08:43:56 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so390161ybb.5
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 00:12:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-4-git-send-email-firoz.khan@linaro.org> <27544098-abc8-db2e-5625-179d13fa63df@xilinx.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 12:42:39 +0530
Message-ID: <CALxhOngGqB2hY1MaEpTZvpgKTP9rwqbnMpgRKT9NQuZ4CXOcew@mail.gmail.com>
Subject: Re: [PATCH 3/3] microblaze: uapi header and system call table file generation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180918071239.a9qzd2Pbp2AXCrBS0-54ZyAMBqihG6JtcIajD1RqSCg@z>

On 9 August 2018 at 12:42, Michal Simek <michal.simek@xilinx.com> wrote:
> On 9.8.2018 07:27, Firoz Khan wrote:
>> System call table generation script must be run to generate
>> unistd_32.h and syscall_table.h files. This patch will have
>> changes which will invokes the script.
>>
>> This patch will generate unistd_32.h and syscall_table.h
>> files by the syscall table generation script invoked by
>> arch/microblaze/Makefile and the generated files against the
>> removed files will be identical.
>>
>> The generated uapi header file will be included in
>> uapi/asm/unistd.h and generated system call table support
>> file will be included by microblaze/kernel/syscall.S file.
>>
>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>> ---
>>  arch/microblaze/Makefile                  |   3 +
>>  arch/microblaze/include/asm/Kbuild        |   2 +
>>  arch/microblaze/include/uapi/asm/Kbuild   |   2 +
>>  arch/microblaze/include/uapi/asm/unistd.h | 409 +-----------------------------
>>  arch/microblaze/kernel/syscall_table.S    | 406 +----------------------------
>>  5 files changed, 12 insertions(+), 810 deletions(-)
>>
>> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
>> index d269dd4b..6121a2b 100644
>> --- a/arch/microblaze/Makefile
>> +++ b/arch/microblaze/Makefile
>> @@ -81,6 +81,9 @@ all: linux.bin
>>  archclean:
>>       $(Q)$(MAKE) $(clean)=$(boot)
>>
>> +archheaders:
>> +     $(Q)$(MAKE) $(build)=arch/microblaze/kernel/syscalls all
>> +
>>  linux.bin linux.bin.gz linux.bin.ub: vmlinux
>>       $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>>
>> diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
>> index fe6a6c6..99225ab 100644
>> --- a/arch/microblaze/include/asm/Kbuild
>> +++ b/arch/microblaze/include/asm/Kbuild
>> @@ -30,3 +30,5 @@ generic-y += trace_clock.h
>>  generic-y += vga.h
>>  generic-y += word-at-a-time.h
>>  generic-y += xor.h
>> +
>> +generated-y += syscall_table.h
>> \ No newline at end of file
>
> This doesn't look right.

You mean I have to keep something like this?
 generic-y += xor.h
-
-generated-y += syscall_table.h
\ No newline at end of file
+generic-y += syscall_table.h
\ No newline at end of file

>
>
>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
>> index 2c6a6bf..8fe26a3 100644
>> --- a/arch/microblaze/include/uapi/asm/Kbuild
>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
>> @@ -28,3 +28,5 @@ generic-y += termbits.h
>>  generic-y += termios.h
>>  generic-y += types.h
>>  generic-y += ucontext.h
>> +
>> +generated-y += unistd_32.h
>> \ No newline at end of file
>
> ditto.

and like this?

 generic-y += ucontext.h
-
-generated-y += unistd_32.h
\ No newline at end of file
+generic-y += unistd_32.h
\ No newline at end of file

- Firoz
