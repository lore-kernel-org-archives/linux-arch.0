Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39885 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935236AbdLSCKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 21:10:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Yas3rWdx_qYx48PECundOzRSKOsqkJnUTzGW86OjJVg@mail.gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com> <9663cb7c21011cdb4f278c1fad081d1df296daa8.1513577007.git.green.hu@gmail.com>
 <CAK8P3a2Yas3rWdx_qYx48PECundOzRSKOsqkJnUTzGW86OjJVg@mail.gmail.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Tue, 19 Dec 2017 10:10:09 +0800
Message-ID: <CAJsyPhwtFz14agh05OHpSnGDTZmBZr22=tOgV9vsZ2nSuaZ4fQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/36] nds32: System calls handling
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, ren_guo@c-sky.com, Philippe Ombredanne <pombredanne@nexb.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171219021009.B42iSBUEvxY3nFfaYrSTmyzFrwwOKB0tNRPht8I7J90@z>

2017-12-18 19:19 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Dec 18, 2017 at 7:46 AM, Greentime Hu <green.hu@gmail.com> wrote:
>
>
>> new file mode 100644
>> index 0000000..90da745
>> --- /dev/null
>> +++ b/arch/nds32/include/uapi/asm/unistd.h
>> @@ -0,0 +1,12 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (C) 2005-2017 Andes Technology Corporation
>> +
>> +#define __ARCH_WANT_SYNC_FILE_RANGE2
>> +
>> +/* Use the standard ABI for syscalls */
>> +#include <asm-generic/unistd.h>
>> +
>> +/* Additional NDS32 specific syscalls. */
>> +#define __NR_cacheflush                (__NR_arch_specific_syscall)
>> +#define __NR__llseek             __NR_llseek
>> +__SYSCALL(__NR_cacheflush, sys_cacheflush)
>
> I'm still confused by __NR__llseek here, why do you need that one?
>

Dear Arnd:
We hoped to solve  ABI register alignment problem for llseek in glibc
by __NR__llseek.
After checking glibc again, I find glibc has same __NR__llseek macro
and It's better to solve this problem.
So, I will remove this definition in the next version patch.


>> +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
>> +              unsigned long, prot, unsigned long, flags,
>> +              unsigned long, fd, unsigned long, pgoff)
>> +{
>> +       if (pgoff & (~PAGE_MASK >> 12))
>> +               return -EINVAL;
>> +
>> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
>> +                             pgoff >> (PAGE_SHIFT - 12));
>> +}
>> +
>> +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>> +              unsigned long, prot, unsigned long, flags,
>> +              unsigned long, fd, unsigned long, pgoff)
>> +{
>> +       if (unlikely(pgoff & ~PAGE_MASK))
>> +               return -EINVAL;
>> +
>> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
>> +                             pgoff >> PAGE_SHIFT);
>> +}
>
> And I don't see why you define sys_mmap() in addition to sys_mmap2().
>
This is my mistake. I will remove it in the next version patch.

> The rest of the syscall handling looks good now.
>
>          Arnd


Thanks
Vincent
