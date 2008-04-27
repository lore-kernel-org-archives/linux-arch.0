From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] prepare kconfig inline optimization for all
 architectures
Date: Sun, 27 Apr 2008 11:11:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804271053300.2896@woody.linux-foundation.org>
References: <20080427105100.GA14795@uranus.ravnborg.org> <20080427113158.GY2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271002360.2896@woody.linux-foundation.org> <20080427172235.GA2252@cs181133002.pp.htv.fi> <alpine.LFD.1.10.0804271029130.2896@woody.linux-foundation.org>
 <20080427174714.GB2252@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080427174714.GB2252-Aar9JVdAhcRoA3hw4S0G5QR5/fbUUdgG@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, linux arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>



On Sun, 27 Apr 2008, Adrian Bunk wrote:
>
> What I want instead:
> - we continue to force the compiler to always inline with "inline"
> - we remove the inline's in .c files and make too big functions in 
>   headers out-of-line

Sure, I can agree with that as a mostly good goal, but you're still 
ignoring the fact that nobody should really expect the compiler to always 
do a good job at deciding high-level issues.

For example, what's wrong with having "inline" on functions in .c files if 
the author thinks they are small enough? He's likely right. Considering 
past behaviour, he's quite often more right than the compiler.

Just as an example of this: gcc will often inline even big functions, if 
they are called from only one call-site. In fact, ask a compiler guy, and 
he'll likely say that that is obviously a good thing.

But ask somebody who debugs the resulting oops reports, and he may well 
disagree violently.

In other words, inlining is about much more than pure optimization. 

Sometimes it's about forcing it (or not forcing it) for simple correctness 
issues when the compiler doesn't understand that the code in question has 
specific rules (for example, we sometimes want to *force* certain 
functions to be in specific segments).

And sometimes it's about debugging. For the kernel, backtraces posted by 
random users are one of the main debug facilities, and unlike many other 
projects, it's not reasonable to ask people to recompile with "-O0 -g" to 
get better backtraces. The bulk of all reports will come from people who 
use precompiled images from a distribution.

And that means that inlining has a *huge* impact on debuggability.

I have vey often cursed gcc inlining some biggish function - who the f*ck 
cares if a thousand-instruction function can shave a couple of 
instructions of call overhead, when it then causes the call trace to be 
really hard to read?

So quite frankly, my preferred optimization would be:

 - Heavily discourage gcc from inlining functions that aren't marked 
   "inline". I suspect it hurts kernel debugging more than many other 
   projects (because other projects aren't as dependent on the traces)

 - I do agree 100% with you that header file functions should be small 
   (unless they use __builtin_constant_p() or other tricks to guarantee a 
   much smaller static footprint than dynamic one)

 - I also suspect we should have some way for developers to ask fo *hints* 
   from the compiler, ie instead of having gcc inline on its own by 
   default, have the people who care about it ask the compiler to warn 
   about cases where inlining would be a big win.

 - Make "inline" mean "you may want to inline this", and "forced_inline" 
   mean "you *have* to inline this". Ie the "inline" is where the compiler 
   can make a subtle choice (and we need that, because sometimes 
   architecture or config options means that the programmer should not 
   make the choice statically!)

In short, in general I actually wish we'd inline much much less than we 
do. And yes, part of that is that we have way too much code in our header 
files.

		Linus
