Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:45432 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdK1EYr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 23:24:47 -0500
MIME-Version: 1.0
In-Reply-To: <20171127135724.yy2jjjuby3xu74mm@lakrids.cambridge.arm.com>
References: <cover.1511785528.git.green.hu@gmail.com> <56a24fae3cec68f80c41eebd98fcceb9b137ac64.1511785528.git.green.hu@gmail.com>
 <20171127135724.yy2jjjuby3xu74mm@lakrids.cambridge.arm.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Tue, 28 Nov 2017 12:24:46 +0800
Message-ID: <CAJsyPhzMa3BJ=nocYYhsxzfqkd0j_gqtfn+Ctzpg=_HigHM07g@mail.gmail.com>
Subject: Re: [PATCH v2 10/35] nds32: Atomic operations
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171128042446.D_64vIWio4cTqzK2xkKOycD3NDP5Es44VV6o5QYCBRg@z>

2017-11-27 21:57 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> Hi,
>
> On Mon, Nov 27, 2017 at 08:27:57PM +0800, Greentime Hu wrote:
>> +static inline void arch_spin_unlock(arch_spinlock_t * lock)
>> +{
>> +     asm volatile(
>> +             "xor    $r15,  $r15, $r15\n"
>> +             "swi    $r15, [%0]\n"
>> +             :
>> +             :"r"(&lock->lock)
>> +             :"memory");
>> +}
>
> This looks suspicious. There's no clobber for $r15, so isn't this
> corrupting a GPR behind the back of the compiler?
>

Thanks.
$r15 is reserved for assembler.
For safety, compiler always put $r15 in clobber register list by default.


> Shouldn't there be a tmp variable for the register allocation rather
> than hard-coding $r15?
>
>> +static inline void arch_write_unlock(arch_rwlock_t * rw)
>> +{
>> +     asm volatile(
>> +             "xor    $r15, $r15, $r15\n"
>> +             "swi    $r15, [%0]\n"
>> +             :
>> +             :"r"(&rw->lock)
>> +             :"memory","$r15");
>> +}
>
> This time you have a clobber, but it's still not clear to me why you
> don't use a tmp variable and leave the register allocation to the
> compiler.
>

Thanks.
When I recheck the code, I found spinlock.h is not needed due that we
do not support SMP.
So, We decide to remove spinlock.h in the next version patch.

Vincent
> Thanks,
> Mark.
