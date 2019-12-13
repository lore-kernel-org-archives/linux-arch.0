From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Sat, 14 Dec 2019 08:06:49 +1100
Message-ID: <87mubwndee.fsf@mpe.ellerman.id.au>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net> <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net> <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net> <87pngso2ck.fsf@mpe.ellerman.id.au> <20191213135353.GN3152@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191213135353.GN3152@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Fri, Dec 13, 2019 at 11:07:55PM +1100, Michael Ellerman wrote:
>> I tried this:
>> 
>> > @@ -295,6 +296,23 @@ void __write_once_size(volatile void *p, void *res, int size)
>> >   */
>> >  #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
>> >  
>> > +#else /* GCC_VERSION < 40800 */
>> > +
>> > +#define READ_ONCE_NOCHECK(x)						\
>> > +({									\
>> > +	typeof(x) __x = *(volatile typeof(x))&(x);			\
>> 
>> Didn't compile, needed:
>> 
>> 	typeof(x) __x = *(volatile typeof(&x))&(x);			\
>> 
>> 
>> > +	smp_read_barrier_depends();					\
>> > +	__x;
>> > +})
>> 
>> 
>> And that works for me. No extra stack check stuff.
>> 
>> I guess the question is does that version of READ_ONCE() implement the
>> read once semantics. Do we have a good way to test that?
>> 
>> The only differences are because of the early return in the generic
>> test_and_set_bit_lock():
>
> No, there is another difference:
>
>>   30         ld      r10,560(r9)
>>   31         std     r10,104(r1)
>>   32         ld      r10,104(r1)
>>   33         andi.   r10,r10,1
>>   34         bne     <ext4_resize_begin_generic+0xd0>       29         bne     <ext4_resize_begin_ppc+0xd0>
>
> The stack var is volatile, so it is read back immediately after writing
> it, here.  This is a bad idea for performance, in general.

Argh, yuck. Thanks, I shouldn't try to read asm listings at 11pm.

So that just confirms what Will was saying further up the thread about
the volatile pointer, rather than READ_ONCE() per se.

cheers
