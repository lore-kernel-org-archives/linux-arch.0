Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36273 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933668AbbEMOJx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 10:09:53 -0400
Date: Wed, 13 May 2015 16:09:45 +0200
From: Michele Curti <michele.curti@gmail.com>
Subject: Re: [RFC PATCH v5] Documentation/arch: Add Documentation/arch-TODO
Message-ID: <20150513140945.GA8376@dellaz>
References: <20150511192918.GA11361@jtriplet-mobl1>
 <20150512142250.dcb053da81855ae1b5861173@linux-foundation.org>
 <20150512213843.GV21418@twins.programming.kicks-ass.net>
 <20150512144910.0b49c9a7a13336773449db33@linux-foundation.org>
 <20150513083441.GA17336@gmail.com>
 <20150513085636.GA11030@gmail.com>
 <20150513092421.GB11030@gmail.com>
 <20150513094622.GC11030@gmail.com>
 <20150513094756.GD11030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150513094756.GD11030@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Josh Triplett <josh@joshtriplett.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Message-ID: <20150513140945.DBEvT3b0Oh_AOZ5VOQIuO791VvoU6UnDL9JptK-FIWI@z>

On Wed, May 13, 2015 at 11:47:56AM +0200, Ingo Molnar wrote:
> 
> (fixed the subject.)
> 
> So this is the final version for now:
> 
>  - add a fourth table
> 
>  - fix errors in earlier tables, in particular I missed some PowerPC 
>    Kconfigs
> 
>  - introduce the '..' denotion (in the final table) to show features 
>    that cannot be supported by an architecture due to hardware 
>    dependencies:
> 
> 		   gcov-profile-all:---------------.
> 				THP:--------.      |
> 		      irq-time-acct:-.      |      |
> 				     |      |      |
> 		----------------------------------------
> 		  alpha           | TODO | TODO | TODO |
> 		  arc             | TODO |  ..  | TODO |
> 		  arm             |  ok  |  ok  |  ok  |
> 		  arm64           | TODO |  ok  |  ok  |
> 		  avr32           | TODO |  ..  | TODO |
> 		  blackfin        | TODO |  ..  | TODO |
> 		  c6x             | TODO |  ..  | TODO |
> 
>    so in the 'THP' column, if an architecture could in theory support 
>    THP, it's listed as 'TODO', if it cannot, it's listed as '..'.
> 
> Please let me know about errors in these tables, and I can also add 
> more features/facilities as well if I missed any.
> 
> Thanks,
>

Tried to transpose rows with columns, to avoid architecture name duplication
and to get only one table while keeping 80 char width, but result seems less
readable :p


                                                m                              
                                                i                         u    
                              b                 c       o                 n    
                              l       h         r   m   p   p             i    
                              a       e         o   n   e p o             c   x
                    a     a a c       x       m b   1 n n a w   s   s     o   t
                    l     r v k   c   a i m m e l m 0 i r r e s c   p t   r   e
                    p a a m r f c r f g a 3 6 t a i 3 o i i r 3 o   a i   e x n
                    h r r 6 3 i 6 i r o 6 2 8 a z p 0 s s s p 9 r s r l u 3 8 s
                    a c m 4 2 n x s v n 4 r k g e s 0 2 c c c 0 e h c e m 2 6 a
-------------------------------------------------------------------------------
            lockdep T K K K K K T T T K T T T K K K T T T T K K K K K K K K K K
     stackprotector T T K K T T T T T T T T T T T K T T T T T T T K T T T T K T
        jump-labels T T K K T T T T T T T T T T T K T T T T K K T T K T T T K T
     seccomp-filter T T K K T T T T T T T T T T T K T T T T T K T T T T T T K T
   context-tracking T T K K T T T T T T T T T T T K T T T T K T T T K K T T K T
               kgdb T K K K T K T T T K T T T T K K K K T T K T T K K K T T K T
 modern-timekeeping K K T K K T K T K K K T T K K K K K K K K K K K K K K K K K
        clockevents K K K K K K K K T K T T K K K K K K K T K K K K K K K K K K
           ELF-ASLR T T K K T T T T T T T T T T T K T T T T K K T T T T T T K T
arch-tick-broadcast T T K K T T T T T T T T T T T K T T T T K T T T T T T T T T
            kprobes T K K T K T T T T T K T T T T K T T T T K K T K K K T T K T
          optprobes T T K T T T T T T T T T T T T T T T T T T T T T T K T T K T
  kprobes-on-ftrace T T T T T T T T T T T T T T T T T T T T T T T T T T T T K T
            uprobes T T K T T T T T T T T T T T T T T T T T K K T T T T T T K T
         kretprobes T K K T T T T T T T K T T T T K T T T T K K T K K K T T K T
  user-ret-profiler T T T T T T T T T T T T T T T T T T T T T T T T T K T T K T
     ioremap_prot() T K T T T T T T T T T T T T T T T T T T K T T K T K T T K T
          tracehook T K K K T K K T K K K T T K T K K K K T K K T K K K T T K T
generic-idle-thread K K K K T K T T T K K T T K T K T T T K K K T K K T T T K K
  dma_*map*_attrs() K T K K T T T T T K K T T T K K T T K T K K T K K K T K K T
     dma-contiguous T T K K T T T T T T T T T T T K T T T T T T T T T T T T K T
      kprobes-event T T K T T T T T T K T T T T T T T T T T K K T K T K T T K T
      dma-api-debug T T K K T T K T T T K T T T K K T T T T K K T K K K T T K T
          perf-regs T T K K T T T T T T T T T T T T T T T T T T T T T T T T K T
     perf-stackdump T T K K T T T T T T T T T T T T T T T T T T T T T T T T K T
      cmpxchg-local T T T T T T T T T T T T T T T T T T T T T K T T T T T T K T
       virt-cpuacct K T K K T T T T T T K T T T T K T T T K K K T T K K T T K T
      irq-time-acct T T K T T T T T T T T T T T T K T T T T T T T T T T T T K K
                THP T - K K - - - - - - T - - - - K - - - T K K - - K T - - K -
   gcov-profile-all T T K K T T T T T T T T T T K T T T T T K K T K T T T T K T

Legend:
    K = ok
    T = TODO
    - = cannot

Michele
