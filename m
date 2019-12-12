From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Thu, 12 Dec 2019 21:21:57 +0100
Message-ID: <20191212202157.GD11457@worktop.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191212193401.GB19020@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 12, 2019 at 07:34:01PM +0000, Will Deacon wrote:
> void ool_store_release(volatile unsigned long *ptr, unsigned long val)
> {
> 	smp_store_release(ptr, val);
> }
> 
> 0000000000000000 <ool_store_release>:
>    0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
>    4:   90000002        adrp    x2, 0 <__stack_chk_guard>
>    8:   91000042        add     x2, x2, #0x0
>    c:   910003fd        mov     x29, sp
>   10:   f9400043        ldr     x3, [x2]
>   14:   f9000fa3        str     x3, [x29, #24]
>   18:   d2800003        mov     x3, #0x0                        // #0
>   1c:   c89ffc01        stlr    x1, [x0]
>   20:   f9400fa1        ldr     x1, [x29, #24]
>   24:   f9400040        ldr     x0, [x2]
>   28:   ca000020        eor     x0, x1, x0
>   2c:   b5000060        cbnz    x0, 38 <ool_store_release+0x38>
>   30:   a8c27bfd        ldp     x29, x30, [sp], #32
>   34:   d65f03c0        ret
>   38:   94000000        bl      0 <__stack_chk_fail>
> 
> It's a mess, and fixing READ_ONCE() doesn't help this case, which is why
> I was looking at getting rid of volatile where it's not strictly needed.
> I'm certainly open to other suggestions, I just haven't managed to think
> of anything else.

We could move the kernel to C++ and write:

	std::remove_volatile<typeof(p)>::type __p = (p);

/me runs like hell...
