Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40323 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756223AbXEPSgb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 May 2007 14:36:31 -0400
Date: Wed, 16 May 2007 11:33:14 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Explicitly mark global functions with vmlinux with
 __global
In-Reply-To: <1179333273.2859.282.camel@shinybook.infradead.org>
Message-ID: <alpine.LFD.0.98.0705161119110.3890@woody.linux-foundation.org>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@linux-foundation.org, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Thu, 17 May 2007, David Woodhouse wrote:
>
> A while ago, I played with using '-fwhole-program --combine' for
> building kernel objects -- http://lwn.net/Articles/197097/

I'm worried about three things:

 - compiler stability. Quite frankly, I don't get the warm and fuzzies 
   about features like this that I suspect have had almost zero testing in 
   real life projects. 

 - memory use. I've seen some projects try to use various vendors 
   aggressive optimizations (including things like whole-program: others 
   have supported it for much longer than gcc has), and memory use tends 
   to skyrocket. Which in turn means that most users wouldn't necessarily 
   use it, just because it makes things so slow to compile.

   (Related to that - if you used to just recompile a single file, you now 
   end up recompiling a whole group, so you often have a double whammy: 
   the compile itself is much slower, and you do a lot more of it!)

 - how much of a win is this on a sane and relevant architecture?

   In particular, the -fwhole-program thing tends to matter a lot more on 
   broken and/or uninteresting archtectures. Architectures like ia64, 
   where you can do real additional optimizations that matter. While these 
   things tend to make much less of an impact on some modern x86, which 
   doesn't have a lot of callee-saved registers anyway, and where function 
   calls aren't really all *that* expensive..

IOW, I'd like to see numbers from something like a 64-bit Core 2 build, 
and both for performance and size and compile time. I think that's more 
interesting than some other architectures (ia64, alpha, ppc) that have 
specific issues that make function boundaries artificially more painful 
than they should be.

That said, I don't think adding "__global" annotations is wrong per se. So 
I don't object to the patches - I think they can be a real advantage in 
the long run, and that it can even be interesting to see which functions 
are "internal" to a subsystem and which ones aren't, even if the compiler 
doesn't use the information. 

But I'm just not very excited about plunging into using experimental gcc 
features unless there is some major advantage for major architectures, and 
the disadvantages are known..

		Linus
