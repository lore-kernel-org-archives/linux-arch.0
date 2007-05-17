Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:54702 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbXEQCx1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 May 2007 22:53:27 -0400
Subject: Re: [RFC] Explicitly mark global functions with vmlinux with
	__global
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <alpine.LFD.0.98.0705161119110.3890@woody.linux-foundation.org>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
	 <alpine.LFD.0.98.0705161119110.3890@woody.linux-foundation.org>
Content-Type: text/plain
Date: Thu, 17 May 2007 10:53:22 +0800
Message-Id: <1179370402.2859.390.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-05-16 at 11:33 -0700, Linus Torvalds wrote:
> I'm worried about three things:
> 
>  - compiler stability. Quite frankly, I don't get the warm and fuzzies 
>    about features like this that I suspect have had almost zero testing in 
>    real life projects. 

(WARNING: I am about to speak of compiler internals; of which I know
little and _want_ to know less than that. Take with a pinch of salt).

Yeah -- warm and fuzzy doesn't really describe my feelings when I filed
all those PRs either -- but none of them were _painful_ bugs. The
--combine thing is all front-end stuff; just hacking the parser to make
it look like you'd just done one big C file which #includes all the
others. And then 'noticing' that certain objects which are declared
twice are in fact the _same_ object, to work around all the compile
failures you'd normally see if you _actually_ did '#include "*.c"'.

IIRC the majority of the PRs I filed were just cases where we failed to
'notice' that objects should be merged. I don't recall a single
'wrong-code' bug, because it just isn't that kind of feature.

There were one or two 'bad optimisation' bugs, caused by stuff like
over-aggressive inlining, but that's not so much of a pain -- it's the
kind of thing that affects us now anyway, and we'd never have noticed it
unless CONFIG_COMBINED_COMPILE had actually caused one or two objects to
_grow_ instead of shrinking, causing me to investigate.

So on the whole, I'm not _too_ worried about the compiler stability.
Either it'll work, or it'll fall over. It won't hurt.

>  - memory use. I've seen some projects try to use various vendors 
>    aggressive optimizations (including things like whole-program: others 
>    have supported it for much longer than gcc has), and memory use tends 
>    to skyrocket. Which in turn means that most users wouldn't necessarily 
>    use it, just because it makes things so slow to compile.

Well, the -fwhole-program _option_ really just means "Assume everything
is static unless told otherwise". It doesn't affect memory usage at all.
What hurts is actually compiling the whole program all at once, which
you don't _really_ need to do if you keep the inter-module linkage
aroundwith judicious used of __attribute__((externally_visible,used)) :)

As I said, it's a trade-off -- we certainly wouldn't actually want to
build the _whole_ kernel all in one compiler invocation. I believe the
biggest wins from --combine come from combining files from within the
same directory (with the probable exceptions I noted), so I see little
benefit in going that far -- I was doing one directory at a time. I
think that's likely to be about the sweet spot.

Even if(^W when) every compiler would work with it, the memory usage is
one reason we'd still want it to be optional, I think.

>    (Related to that - if you used to just recompile a single file, you now 
>    end up recompiling a whole group, so you often have a double whammy: 
>    the compile itself is much slower, and you do a lot more of it!)

True. In the debugging 'compile once, run once, swear, edit' loop I'd be
inclined to build without the CONFIG_COMBINED_COMPILE option -- it's
more fun in the 'compile once, run many times' kind of situation where
the compile time isn't really in the fast path. That's one of the
reasons I wanted to keep it optional -- so that this works:

  make modules CONFIG_COMBINED_COMPILE= SUBDIRS=what/i/broke/today

>  - how much of a win is this on a sane and relevant architecture?

Well, I'm not sure I'd call x86_64 'sane and relevant' in this
particular context -- I was trying to save memory on
resource-constrained systems. But there's probably some potential for
x86_64 to gain from the improved opportunities for optimisation too.

>    In particular, the -fwhole-program thing tends to matter a lot more on 
>    broken and/or uninteresting archtectures. Architectures like ia64, 
>    where you can do real additional optimizations that matter. While these 
>    things tend to make much less of an impact on some modern x86, which 
>    doesn't have a lot of callee-saved registers anyway, and where function 
>    calls aren't really all *that* expensive..
> 
> IOW, I'd like to see numbers from something like a 64-bit Core 2 build, 
> and both for performance and size and compile time. I think that's more 
> interesting than some other architectures (ia64, alpha, ppc) that have 
> specific issues that make function boundaries artificially more painful 
> than they should be.

OK, I'll try. Size and compile time shouldn't be hard to do even for
x86_64 -- for runtime stuff I'll need to find some suitable hardware or
a volunteer. Any _particular_ runtime stuff you want tested, or shall I
attempt to contrive a benchmark of my own devising? :)

Left to my own devices, I'd probably do something based on mounting,
reading and writing a large JFFS2 filesystem on a fake ram-backed
device. That exercises lots of cpu-intensive code I know well, and it's
"real world" stuff for me, if not for you.

Me and my laptop are about to be locked in various tin cans for a total
period of 24 hours or so, and can compile for ppc, ppc64 and i386 -- so
I'll see if I can get that lot building again by the beginning of next
week.

> That said, I don't think adding "__global" annotations is wrong per se. So 
> I don't object to the patches - I think they can be a real advantage in 
> the long run, and that it can even be interesting to see which functions 
> are "internal" to a subsystem and which ones aren't, even if the compiler 
> doesn't use the information. 

OK.

> But I'm just not very excited about plunging into using experimental gcc 
> features unless there is some major advantage for major architectures, and 
> the disadvantages are known..

The architectures I see as 'major' in this particular context are the
ones that can sanely be used in 'embedded' systems -- so I'd normally be
looking at i386, ppc32 and ARM to start with. And I'd probably do FR-V
too just for fun. My original tests did show a worthwhile win on at
least the first two of those, which I think is enough in itself to
justify taking it further.

It does have other benefits for those who aren't using it, as well as
highlighting cases where the compiler is overaggressive about inlining
-- it found a few bugs with mismatching prototypes, such as the fact
that ipxrtr_route_packet() actually takes a 'len' argument of type
'size_t', but is declared and called in af_ipx.c as if that argument is
'int'. (Oops, I thought I'd chased all of combine-diff-1-fixes.patch
upstream already).

-- 
dwmw2

