Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41046 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfFCOy1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jun 2019 10:54:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so10765635pfq.8
        for <linux-arch@vger.kernel.org>; Mon, 03 Jun 2019 07:54:27 -0700 (PDT)
Subject: Re: [PATCH v6 17/19] mips: Add support for generic vDSO
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-18-vincenzo.frascino@arm.com>
 <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <200c39f5-3bff-cacb-57c9-e11c57df70f5@android.com>
Date: Mon, 3 Jun 2019 07:54:24 -0700
MIME-Version: 1.0
In-Reply-To: <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190603145424.MW47QgAcg_czIP8h0ktxWwM93VZh_W6zSUx0U6eNX0c@z>

On 05/31/2019 01:34 AM, Arnd Bergmann wrote:
> On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>
>> --- a/arch/mips/vdso/vdso.lds.S
>> +++ b/arch/mips/vdso/vdso.lds.S
>> @@ -99,6 +99,10 @@ VERSION
>>          global:
>>                  __vdso_clock_gettime;
>>                  __vdso_gettimeofday;
>> +               __vdso_clock_getres;
>> +#if _MIPS_SIM != _MIPS_SIM_ABI64
>> +               __vdso_clock_gettime64;
>> +#endif
>>   #endif
>>          local: *;
>>          };
> Same comment as for the corresponding arm change: I'd leave the ABI
> changes to a separate patch, and probably not add __vdso_clock_getres
> at all.

Removing this would break ABI (would it really, it just replaces the 
syscall ... so it is more of a user space expectation)? already present 
in arm64 before this series.

-- Mark
