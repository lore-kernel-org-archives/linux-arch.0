From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on 32-bit machines
Date: Tue, 24 Nov 2015 14:28:29 +0100
Message-ID: <7133744.P9YviJnnuV@wuerfel>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <4277009.MDAEAbRExl@wuerfel> <alpine.LFD.2.20.1511240007580.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1511240007580.22569@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 24 November 2015 00:37:17 Nicolas Pitre wrote:
> On Mon, 23 Nov 2015, Arnd Bergmann wrote:
> 
> > On Monday 23 November 2015 11:04:33 Nicolas Pitre wrote:
> > > 
> > > OK... I'm able to "fix" the build with:
> > > 
> > > diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
> > > index 163f77999e..d246c4c801 100644
> > > --- a/include/asm-generic/div64.h
> > > +++ b/include/asm-generic/div64.h
> > > @@ -206,7 +206,7 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> > >         uint32_t __rem;                                 \
> > >         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
> > >         if (__builtin_constant_p(__base) &&             \
> > > -           is_power_of_2(__base)) {                    \
> > > +           is_power_of_2(__base) && __base != 0) {     \
> > >                 __rem = (n) & (__base - 1);             \
> > >                 (n) >>= ilog2(__base);                  \
> > >         } else if (__div64_const32_is_OK &&             \
> > > 
> > > What doesn't make sense to me is the fact that is_power_of_2() is 
> > > defined as:
> > > 
> > > static inline __attribute__((const))
> > > bool is_power_of_2(unsigned long n)
> > > {
> > >         return (n != 0 && ((n & (n - 1)) == 0));
> > > }
> > > 
> > > So the test for zero is already in there.
> > > 
> > > And adding BUILD_BUG_ON(__builtin_constant_p(__base) && __base == 0) 
> > > before the if doesn't trig either.
> > 
> > I've seen similarly messed up situations with PROFILE_ALL_BRANCHES
> > before, I think it's got something to do with how __builtin_constant_p()
> > is used inside of the __trace_if() macro, and how gcc sometimes falls
> > back to treating variables as not-really-constant based on context.
> > 
> > To gcc, __builtin_constant_p is just best-effort, and they don't care
> > about returning false sometimes if they catch most cases in practice.
> 
> OK... I produced a minimal test case. I think gcc is screwed. And it is 
> not a question of __builtin_constant_p being best effort. The resulting 
> code is plain wrong where a variable is suddenly turned into a constant 
> of value 0. Any random modification to various part of the code just 
> makes it disappear but I didn't check the disassembly to see if it is 
> then correct.
> 
> And the good news(tm) is that the same bug is triggered with x86 gcc as 
> well.
> 
> Please try the attached test case.

I can confirm the behavior you see with gcc-4.9 and later (I only saw
it on 5.x or later with the kernel code). It seems to have been
introduced with

https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=206941


        PR tree-optimization/59597
        * tree-ssa-threadupdate.c (dump_jump_thread_path): Move to earlier
        in file.  Accept new argument REGISTERING and use it to modify
        dump output appropriately.
        (register_jump_thread): Corresponding changes.
        (mark_threaded_blocks): Reinstate code to cancel unprofitable
        thread paths involving joiner blocks.  Add code to dump cancelled
        jump threading paths.
    
        PR tree-optimization/59597
        * gcc.dg/tree-ssa/pr59597.c: New test.
    
    git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@206941 138bc75d-0d04-0410-961f-82ee72b054a4

 gcc/ChangeLog                           |  11 +++++
 gcc/testsuite/ChangeLog                 |   5 +++
 gcc/testsuite/gcc.dg/tree-ssa/pr59597.c |  55 +++++++++++++++++++++++++
 gcc/tree-ssa-threadupdate.c             | 125 +++++++++++++++++++++++++++++++++++++++------------------
 4 files changed, 157 insertions(+), 39 deletions(-)

however, in that version, the -DHIDE_THE_BUG variant also fails:

compilation that works:
gcc-cross -Wall -I /home/arnd/git/buildall/arm/gcc/gcc/include  -O2 -c -o /home/arnd/git/buildall/arm/gcc_testcase/src.o /home/arnd/git/buildall/arm/gcc_testcase/src.c -DHIDE_THE_BUG
/home/arnd/git/buildall/arm/gcc_testcase/src.c: In function 'il_send_rxon_timing':
/home/arnd/git/buildall/arm/gcc_testcase/src.c:39:30: error: call to '____ilog2_NaN' declared with attribute error: gcc is screwed

compilation that works (v2):
gcc-cross -Wall -I /home/arnd/git/buildall/arm/gcc/gcc/include  -O2 -c -o /home/arnd/git/buildall/arm/gcc_testcase/src.o /home/arnd/git/buildall/arm/gcc_testcase/src.c -DHIDE_THE_BUG_2
as: unrecognized option '-meabi=5'

compilation that fails:
gcc-cross -Wall -I /home/arnd/git/buildall/arm/gcc/gcc/include  -O2 -c -o /home/arnd/git/buildall/arm/gcc_testcase/src.o /home/arnd/git/buildall/arm/gcc_testcase/src.c
/home/arnd/git/buildall/arm/gcc_testcase/src.c: In function 'il_send_rxon_timing':
/home/arnd/git/buildall/arm/gcc_testcase/src.c:39:30: error: call to '____ilog2_NaN' declared with attribute error: gcc is screwed


This changed with

https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=220743

        PR tree-optimization/64823
        * tree-vrp.c (identify_jump_threads): Handle blocks with no real
        statements.
        * tree-ssa-threadedge.c (potentially_threadable_block): Allow
        threading through blocks with PHIs, but no statements.
        (thread_through_normal_block): Distinguish between blocks where
        we did not process all the statements and blocks with no statements.
    
        PR tree-optimization/64823
        * gcc.dg/uninit-20.c: New test.
    
    git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@220743 138bc75d-0d04-0410-961f-82ee72b054a4

 gcc/ChangeLog                    | 10 ++++++++++
 gcc/testsuite/ChangeLog          |  5 +++++
 gcc/testsuite/gcc.dg/uninit-20.c | 18 ++++++++++++++++++
 gcc/tree-ssa-threadedge.c        | 39 ++++++++++++++++++++++++++++++++-------
 gcc/tree-vrp.c                   | 13 ++++++++++---
 5 files changed, 75 insertions(+), 10 deletions(-)


after which only the third run fails but the -DHIDE_THE_BUG one succeeds.

	Arnd
