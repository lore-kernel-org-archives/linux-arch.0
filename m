From: "Michael Kerrisk" <mtk.manpages-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] Add fast little-endian switch system call
Date: Mon, 28 Apr 2008 17:42:18 +0200
Message-ID: <cfd18e0f0804280842q14aa0cb1ref0c8a775e7db83d@mail.gmail.com>
References: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
	 <20080428144332.GA17109@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080428144332.GA17109-jcswGhMUV9g@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Apr 28, 2008 at 4:43 PM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> Please see Michael Kerrisk on userspace ABI updates.  A nice little
> manpage for this gimmick would be helpful, and maybe help other
> platforms that want one aswell to implement the same API.

Thanks Chrsitoph.  I'm not on any of these lists at the moment.

Paul -- is this syscall defintely going in?  Could you write a short
description for userland programmers?  I'll do the grotty *roff stuff.

> On Mon, Apr 28, 2008 at 01:52:31PM +1000, Paul Mackerras wrote:
> > This adds a system call on 64-bit platforms for switching between
> > little-endian and big-endian modes that is much faster than doing a
> > prctl call.  This system call is handled as a special case right at
> > the start of the system call entry code, and because it is a special
> > case, it uses a system call number which is out of the range of
> > normal system calls, namely 0x1ebe.
> >
> > Measurements with lmbench on a 4.2GHz POWER6 showed no measurable
> > change in the speed of normal system calls with this patch.
> >
> > Switching endianness with this new system call takes around 60ns on a
> > 4.2GHz POWER6, compared with around 300ns to switch endian mode with a
> > prctl.  This can provide a significant performance advantage for
> > emulators for little-endian architectures that want to switch between
> > big-endian and little-endian mode frequently, e.g. because they are
> > generating instructions sequences on the fly and they want to run
> > those sequences in little-endian mode.
> >
> > Signed-off-by: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
> > ---
> >
> > diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> > index 215973a..2eb49a7 100644
> > --- a/arch/powerpc/kernel/head_64.S
> > +++ b/arch/powerpc/kernel/head_64.S
> > @@ -239,6 +239,10 @@ instruction_access_slb_pSeries:
> >       .globl  system_call_pSeries
> >  system_call_pSeries:
> >       HMT_MEDIUM
> > +BEGIN_FTR_SECTION
> > +     cmpdi   r0,0x1ebe
> > +     beq-    1f
> > +END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
>
> Am I missing something here or does this add a branch for every normal
> syscall?
>
> >       mr      r9,r13
> >       mfmsr   r10
> >       mfspr   r13,SPRN_SPRG3
> > @@ -253,6 +257,13 @@ system_call_pSeries:
> >       rfid
> >       b       .       /* prevent speculative execution */
> >
> > +/* Fast LE/BE switch system call */
> > +1:   mfspr   r12,SPRN_SRR1
> > +     xori    r12,r12,MSR_LE
> > +     mtspr   SPRN_SRR1,r12
> > +     rfid            /* return to userspace */
> > +     b       .
> > +
> >       STD_EXCEPTION_PSERIES(0xd00, single_step)
> >       STD_EXCEPTION_PSERIES(0xe00, trap_0e)
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> ---end quoted text---
>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
