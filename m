From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
Date: Sun, 27 Apr 2008 11:57:42 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804271150050.3119@woody.linux-foundation.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
 <20080427174714.GB2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271053300.2896@woody.linux-foundation.org> <20080427184106.GD2252@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080427184106.GD2252-Aar9JVdAhcRoA3hw4S0G5QR5/fbUUdgG@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>



On Sun, 27 Apr 2008, Adrian Bunk wrote:

> On Sun, Apr 27, 2008 at 11:11:27AM -0700, Linus Torvalds wrote:
> > 
> > For example, what's wrong with having "inline" on functions in .c files if 
> > the author thinks they are small enough? He's likely right. Considering 
> > past behaviour, he's quite often more right than the compiler.
> >...
> 
> Ingo's commit in your tree just broke this assumption.

Note that our problem is too much inlining, not too little.

I'm actually happier with gcc not deciding to inline (despite having an 
"inline") than I am with gcc deciding to inline (in violation of _not_ 
having an "inline").

So I don't disagree with Ingo's commit per se.

The only problem with not inlining is a historical one: exactly because 
gcc _used_ to always do what people asked for, Linux has historically 
treated "inline" as a "force_inline". And I was very unhappy when gcc 
changed that, just because it broke historically good code.

In many ways, it might have been better if we had a "__may_inline" thing 
to tell the compiler "you can inline this if you think it's worth it"). 
Both gcc (long ago) and Ingo (now) decided to just make plain "inline" 
mean that, but with a pretty strong bias. It was wrong for gcc to do so, 
imho, and it may have been wrong for this OPTIMIZE_INLINE thing too.

			Linus
