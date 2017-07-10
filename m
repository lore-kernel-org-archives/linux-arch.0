From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Mon, 10 Jul 2017 13:39:46 -0700 (PDT)
Message-ID: <mhng-c615d286-e127-43cd-8357-1d9e20f086b9@palmer-si-x1c4>
References: <20170707021425.sssqytbf3gmbklwe@tardis>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707021425.sssqytbf3gmbklwe@tardis>
Sender: linux-kernel-owner@vger.kernel.org
To: boqun.feng@gmail.com
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

On Thu, 06 Jul 2017 19:14:25 PDT (-0700), boqun.feng@gmail.com wrote:
> On Thu, Jul 06, 2017 at 06:04:13PM -0700, Palmer Dabbelt wrote:
> [...]
>> >> +#define __smp_load_acquire(p)						\
>> >> +do {									\
>> >> +	union { typeof(*p) __val; char __c[1]; } __u =			\
>> >> +		{ .__val = (__force typeof(*p)) (v) };			\
>> >> +	compiletime_assert_atomic_type(*p);				\
>> >> +	switch (sizeof(*p)) {						\
>> >> +	case 1:								\
>> >> +	case 2:								\
>> >> +		__u.__val = READ_ONCE(*p);				\
>> >> +		smb_mb();						\
>> >> +		break;							\
>> >> +	case 4:								\
>> >> +		__asm__ __volatile__ (					\
>> >> +			"amoor.w.aq %1, zero, %0"			\
>> >> +			: "+A" (*p)					\
>> >> +			: "=r" (__u.__val)				\
>> >> +			: "memory");					\
>> >> +		break;							\
>> >> +	case 8:								\
>> >> +		__asm__ __volatile__ (					\
>> >> +			"amoor.d.aq %1, zero, %0"			\
>> >> +			: "+A" (*p)					\
>> >> +			: "=r" (__u.__val)				\
>> >> +			: "memory");					\
>> >> +		break;							\
>> >> +	}								\
>> >> +	__u.__val;							\
>> >> +} while (0)
>> >
>> > 'creative' use of amoswap and amoor :-)
>> >
>> > You should really look at a normal load with ordering instruction
>> > though, that amoor.aq is a rmw and will promote the cacheline to
>> > exclusive (and dirty it).
>>
>> The thought here was that implementations could elide the MW by pattern
>> matching the "zero" (x0, the architectural zero register) forms of AMOs where
>> it's interesting.  I talked to one of our microarchitecture guys, and while he
>> agrees that's easy he points out that eliding half the AMO may wreak havoc on
>> the consistency model.  Since we're not sure what the memory model is actually
>> going to look like, we thought it'd be best to just write the simplest code
>> here
>>
>>   /*
>>    * TODO_RISCV_MEMORY_MODEL: While we could emit AMOs for the W and D sized
>>    * accesses here, it's questionable if that actually helps or not: the lack of
>>    * offsets in the AMOs means they're usually preceded by an addi, so they
>>    * probably won't save code space.  For now we'll just emit the fence.
>>    */
>>   #define __smp_store_release(p, v)                                       \
>>   ({                                                                      \
>>           compiletime_assert_atomic_type(*p);                             \
>>           smp_mb();                                                       \
>>           WRITE_ONCE(*p, v);                                              \
>>   })
>>
>>   #define __smp_load_acquire(p)                                           \
>>   ({                                                                      \
>>           union{typeof(*p) __p; long __l;} __u;                           \
>
> AFAICT, there seems to be an endian issue if you do this. No?
>
> Let us assume typeof(*p) is char and *p == 1, and on a big endian 32bit
> platform:
>
>>           compiletime_assert_atomic_type(*p);                             \
>>           __u.__l = READ_ONCE(*p);                                        \
>
> 	READ_ONCE(*p) is 1 so
> 	__u.__l is 0x00 00 00 01 now
>
>>           smp_mb();                                                       \
>>           __u.__p;                                                        \
>
> 	__u.__p is then 0x00.
>
> Am I missing something here?

We're little endian (though I might have still screwed it up).  I didn't really
bother looking because...

> Even so why not use the simple definition as in include/asm-generic/barrier.h?

...that's much better -- I forgot there were generic versions, as we used to
have a much more complicated one.

  https://github.com/riscv/riscv-linux/commit/910d2bf4c3c349b670a1d839462e32e122ac70a5

Thanks!
