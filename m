From: Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH 11/31] nds32: Atomic operations
Date: Wed, 22 Nov 2017 11:02:03 +0800
Message-ID: <CAJsyPhz6=HmSaJ-9t8Zwa3sRuL5bHvHgzMS2EA7pqCDfK_1gqA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <b13577a068afb71e87e21598f59733f127814f37.1510118606.git.green.hu@gmail.com>
 <20171120142925.GC32488@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120142925.GC32488@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, Vincent Chen <vincentc@andestech.com>, peterz@infradead.org, paulmck@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

2017-11-20 22:29 GMT+08:00 Will Deacon <will.deacon@arm.com>:
> Hi Greentime,
>
> On Wed, Nov 08, 2017 at 01:54:59PM +0800, Greentime Hu wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>> ---
>>  arch/nds32/include/asm/futex.h    |  116 ++++++++++++++++++++++++
>>  arch/nds32/include/asm/spinlock.h |  178 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 294 insertions(+)
>>  create mode 100644 arch/nds32/include/asm/futex.h
>>  create mode 100644 arch/nds32/include/asm/spinlock.h
>
> [...]
>
>> +static inline int
>> +futex_atomic_cmpxchg_inatomic(u32 * uval, u32 __user * uaddr,
>> +                           u32 oldval, u32 newval)
>> +{
>> +     int ret = 0;
>> +     u32 val, tmp, flags;
>> +
>> +     if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
>> +             return -EFAULT;
>> +
>> +     smp_mb();
>> +     asm volatile ("       movi    $ta, #0\n"
>> +                   "1:     llw     %1, [%6 + $ta]\n"
>> +                   "       sub     %3, %1, %4\n"
>> +                   "       cmovz   %2, %5, %3\n"
>> +                   "       cmovn   %2, %1, %3\n"
>> +                   "2:     scw     %2, [%6 + $ta]\n"
>> +                   "       beqz    %2, 1b\n"
>> +                   "3:\n                   " __futex_atomic_ex_table("%7")
>> +                   :"+&r"(ret), "=&r"(val), "=&r"(tmp), "=&r"(flags)
>> +                   :"r"(oldval), "r"(newval), "r"(uaddr), "i"(-EFAULT)
>> +                   :"$ta", "memory");
>> +     smp_mb();
>> +
>> +     *uval = val;
>> +     return ret;
>> +}
>
> I see you rely on asm-generic/barrier.h for your barrier definitions, which
> suggests that you only need to prevent reordering by the compiler because
> you're not SMP. Is that right? If so, using smp_mb() is a little weird.
>

Thanks.
So, Is it better to replace smp_mb() with mb() for us?


> What about DMA transactions? I imagine you might need some extra
> instructions for the mandatory barriers there.
>

I don't get it. Do you mean before DMA transations?

Data are moved from memory to device, we will writeback data cache
before DMA transactions.

Data are moved from device to memory, we will invalidate data cache
after DMA transactions.



> Also:
>
>> +static inline void arch_spin_lock(arch_spinlock_t * lock)
>> +{
>> +     unsigned long tmp;
>> +
>> +     __asm__ __volatile__("1:\n"
>> +                          "\tllw\t%0, [%1]\n"
>> +                          "\tbnez\t%0, 1b\n"
>> +                          "\tmovi\t%0, #0x1\n"
>> +                          "\tscw\t%0, [%1]\n"
>> +                          "\tbeqz\t%0, 1b\n"
>> +                          :"=&r"(tmp)
>> +                          :"r"(&lock->lock)
>> +                          :"memory");
>> +}
>
> Here it looks like you're eliding an explicit barrier here because you
> already have a "memory" clobber. Can't you do the same for the futex code
> above?
>
Thanks.
OK. I will modify it in the next version patch.

> Will


Best regards
Vincent
