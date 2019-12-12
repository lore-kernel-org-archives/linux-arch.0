From: Will Deacon <will@kernel.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Thu, 12 Dec 2019 10:07:56 +0000
Message-ID: <20191212100756.GA11317@willie-the-truck>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191212080105.GV2844@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 12, 2019 at 09:01:05AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 12, 2019 at 04:42:13PM +1100, Michael Ellerman wrote:
> > Peter Zijlstra <peterz@infradead.org> writes:
> > > On Fri, Dec 06, 2019 at 11:46:11PM +1100, Michael Ellerman wrote:
> > Some of the generic versions don't generate good code compared to our
> > versions, but that's because READ_ONCE() is triggering stack protector
> > to be enabled.
> 
> Bah, there's never anything simple, is there :/
> 
> > For example, comparing an out-of-line copy of the generic and ppc
> > versions of test_and_set_bit_lock():
> > 
> >    1 <generic_test_and_set_bit_lock>:           1 <ppc_test_and_set_bit_lock>:
> >    2         addis   r2,r12,361
> >    3         addi    r2,r2,-4240
> >    4         stdu    r1,-48(r1)
> >    5         rlwinm  r8,r3,29,3,28
> >    6         clrlwi  r10,r3,26                   2         rldicl  r10,r3,58,6
> >    7         ld      r9,3320(r13)
> >    8         std     r9,40(r1)
> >    9         li      r9,0
> >   10         li      r9,1                        3         li      r9,1
> >                                                  4         clrlwi  r3,r3,26
> >                                                  5         rldicr  r10,r10,3,60
> >   11         sld     r9,r9,r10                   6         sld     r3,r9,r3
> >   12         add     r10,r4,r8                   7         add     r4,r4,r10
> >   13         ldx     r8,r4,r8
> >   14         and.    r8,r9,r8
> >   15         bne     34f
> >   16         ldarx   r7,0,r10                    8         ldarx   r9,0,r4,1
> >   17         or      r8,r9,r7                    9         or      r10,r9,r3
> >   18         stdcx.  r8,0,r10                   10         stdcx.  r10,0,r4
> >   19         bne-    16b                        11         bne-    8b
> >   20         isync                              12         isync
> >   21         and     r9,r7,r9                   13         and     r3,r3,r9
> >   22         addic   r7,r9,-1                   14         addic   r9,r3,-1
> >   23         subfe   r7,r7,r9                   15         subfe   r3,r9,r3
> >   24         ld      r9,40(r1)
> >   25         ld      r10,3320(r13)
> >   26         xor.    r9,r9,r10
> >   27         li      r10,0
> >   28         mr      r3,r7
> >   29         bne     36f
> >   30         addi    r1,r1,48
> >   31         blr                                16         blr
> >   32         nop
> >   33         nop
> >   34         li      r7,1
> >   35         b       24b
> >   36         mflr    r0
> >   37         std     r0,64(r1)
> >   38         bl      <__stack_chk_fail+0x8>
> > 
> > 
> > If you squint, the generated code for the actual logic is pretty similar, but
> > the stack protector gunk makes a big mess. It's particularly bad here
> > because the ppc version doesn't even need a stack frame.
> > 
> > I've also confirmed that even when test_and_set_bit_lock() is inlined
> > into an actual call site the stack protector logic still triggers.
> 
> > If I change the READ_ONCE() in test_and_set_bit_lock():
> > 
> > 	if (READ_ONCE(*p) & mask)
> > 		return 1;
> > 
> > to a regular pointer access:
> > 
> > 	if (*p & mask)
> > 		return 1;
> > 
> > Then the generated code looks more or less the same, except for the extra early
> > return in the generic version of test_and_set_bit_lock(), and different handling
> > of the return code by the compiler.
> 
> So given that the function signature is:
> 
> static inline int test_and_set_bit_lock(unsigned int nr,
> 					volatile unsigned long *p)
> 
> @p already carries the required volatile qualifier, so READ_ONCE() does
> not add anything here (except for easier to read code and poor code
> generation).
> 
> So your proposed change _should_ be fine. Will, I'm assuming you never
> saw this on your ARGH64 builds when you did this code ?

I did see it, but (a) looking at the code out-of-line makes it look a lot
worse than it actually is (so the ext4 example is really helpful -- thanks
Michael!) and (b) I chalked it up to a crappy compiler.

However, see this comment from Arnd on my READ_ONCE series from the other
day:

https://lore.kernel.org/lkml/CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com

In which case, I'm thinking that we should be doing better in READ_ONCE()
for non-buggy compilers which would also keep the KCSAN folks happy for this
code (and would help with [1] too).

Will

[1] https://lkml.org/lkml/2019/11/12/898
