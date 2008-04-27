From: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
	architectures
Date: Sun, 27 Apr 2008 21:41:06 +0300
Message-ID: <20080427184106.GD2252@cs181133002.pp.htv.fi>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org> <20080427174714.GB2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271053300.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804271053300.2896-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Sun, Apr 27, 2008 at 11:11:27AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 27 Apr 2008, Adrian Bunk wrote:
> >
> > What I want instead:
> > - we continue to force the compiler to always inline with "inline"
> > - we remove the inline's in .c files and make too big functions in 
> >   headers out-of-line
> 
> Sure, I can agree with that as a mostly good goal, but you're still 
> ignoring the fact that nobody should really expect the compiler to always 
> do a good job at deciding high-level issues.
> 
> For example, what's wrong with having "inline" on functions in .c files if 
> the author thinks they are small enough? He's likely right. Considering 
> past behaviour, he's quite often more right than the compiler.
>...

Ingo's commit in your tree just broke this assumption.

And he justified breaking it with a 2.3% size decrease.

And after
- grep'ing for "inline" through drivers/
- remembering how driver authors use likely/unlikely
- remembering the practically non-existing quality criteria you set
  for new drivers [1]
"He's likely right." is likely not right for the average driver author.

You might be smarter than gcc, but most kernel developers (including me) 
are not.

> 		Linus

cu
Adrian

[1] you said you really wanted this driver merged in this state in 2.6.25:

      grep -C4 volatile drivers/infiniband/hw/nes/nes_nic.c


-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
