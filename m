From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v3 0/2] qspinlock: Introducing a 4-byte queue spinlock
Date: Thu, 30 Jan 2014 10:38:32 -0500
Message-ID: <52EA71F8.7070308@hp.com>
References: <1390933151-1797-1-git-send-email-Waiman.Long@hp.com> <52EA139C.8040106@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52EA139C.8040106@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
List-Id: linux-arch.vger.kernel.org

On 01/30/2014 03:55 AM, Raghavendra K T wrote:
> On 01/28/2014 11:49 PM, Waiman Long wrote:
>> v2->v3:
>>   - Simplify the code by using numerous mode only without an unfair=20
>> option.
>>   - Use the latest smp_load_acquire()/smp_store_release() barriers.
>>   - Move the queue spinlock code to kernel/locking.
>>   - Make the use of queue spinlock the default for x86-64 without us=
er
>>     configuration.
>>   - Additional performance tuning.
>>
>
> Could you please point me to any dependency patches I am missing?
> I am getting the compilation error (latest linus tree with=20
> 9b0cd304f26b9fca140de15deeac2bf357d1f388)
>
> Got something like below
>
> make[1]: Nothing to be done for `all'.
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[1]: Nothing to be done for `relocs'.
>   CC      kernel/bounds.s
> In file included from include/asm-generic/getorder.h:7:0,
>                  from /test/master/arch/x86/include/asm/page.h:71,
>                  from /test/master/arch/x86/include/asm/processor.h:1=
7,
>                  from /test/master/arch/x86/include/asm/atomic.h:6,
>                  from include/linux/atomic.h:4,
>                  from include/asm-generic/qspinlock.h:22,
>                  from=20
> /test/master/arch/x86/include/asm/spinlock_types.h:15,
>                  from=20
> /test/master/arch/x86/include/asm/paravirt_types.h:331,
>                  from /test/master/arch/x86/include/asm/ptrace.h:65,
>                  from /test/master/arch/x86/include/asm/alternative.h=
:8,
>                  from /test/master/arch/x86/include/asm/bitops.h:16,
>                  from include/linux/bitops.h:33,
>                  from include/linux/kernel.h:10,
>                  from include/asm-generic/bug.h:13,
>                  from /test/master/arch/x86/include/asm/bug.h:38,
>                  from include/linux/bug.h:4,
>                  from include/linux/page-flags.h:9,
>                  from kernel/bounds.c:9:
> include/linux/log2.h: In function =91__ilog2_u32=92:
> include/linux/log2.h:34:2: error: implicit declaration of function=20
> =91fls=92 [-Werror=3Dimplicit-function-declaration]
> include/linux/log2.h: In function =91__ilog2_u64=92:
> include/linux/log2.h:42:2: error: implicit declaration of function=20
> =91fls64=92 [-Werror=3Dimplicit-function-declaration]
> include/linux/log2.h: In function =91__roundup_pow_of_two=92:
> .
> .
> [trimmed]
>

The code will need to be compiled in either the latest linux tree as th=
e=20
patches have dependency on some new memory barrier that are in 3.14.=20
Alternatively, you can compile with the latest tip tree.

If you have already done that, please send me your config file so that =
I=20
can reproduce the compilation error in my build environment.

Thanks,
Longman
