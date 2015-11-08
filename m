From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 08/28] lkl: system call interface and application API
Date: Sun, 8 Nov 2015 05:49:00 +0200
Message-ID: <CAE1zotJhGqHnj=+SHDv=ButnqpB3j5V7jqYbBDTPpqSuB4jZfg@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<1446582059-17355-9-git-send-email-octavian.purdila@intel.com>
	<4119283.3hnNZZdIi2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37079 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbKHDtC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 22:49:02 -0500
Received: by wmww144 with SMTP id w144so7727227wmw.0
        for <linux-arch@vger.kernel.org>; Sat, 07 Nov 2015 19:49:00 -0800 (PST)
In-Reply-To: <4119283.3hnNZZdIi2@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>

On Sun, Nov 8, 2015 at 1:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 November 2015 22:20:39 Octavian Purdila wrote:
>> +
>> +/*
>> + * Unsupported system calls due to lack of support in LKL (e.g. related to
>> + * virtual memory, signal, user processes). We also only support 64bit version
>> + * of system calls where we have two version to keep the same APi across 32 and
>> + * 64 bit hosts.
>> + */
>> +#define __NR_restart_syscall 0
>> +#define __NR_exit 0
>> +#define __NR_fork 0
>> +#define __NR_execve 0
>> +#define __NR_ptrace 0
>> +#define __NR_alarm 0
>> +#define __NR_pause 0
>
> Why are these not #undef?
>
>> diff --git a/arch/lkl/include/uapi/asm/unistd.h b/arch/lkl/include/uapi/asm/unistd.h
>> new file mode 100644
>> index 0000000..68b5423
>> --- /dev/null
>> +++ b/arch/lkl/include/uapi/asm/unistd.h
>> @@ -0,0 +1,256 @@
>> +#ifndef _ASM_UAPI_LKL_UNISTD_H
>> +#define _ASM_UAPI_LKL_UNISTD_H
>> +
>> +#ifdef __KERNEL__
>> +#define __NR_ni_syscall              0
>> +#define __NR_reboot          1
>> +#endif
>> +#define __NR_getpid          2
>> +#define __NR_write           3
>> +#define __NR_close           4
>> +#define __NR_unlink          5
>> +#define __NR_open            6
>> +#define __NR_poll            7
>
> Could you use the standard numbers from include/uapi/asm-generic/unistd.h?
> Maybe include that header and then #undef the ones you don't support?
> That would avoid having to assign a new number of each future syscall
> that gets added.

It would be nice to do that but if we undef them warnings will be
generated during the build (e.g. "warning: #warning syscall pause not
implemented"). Is there a way to disable those warnings?
