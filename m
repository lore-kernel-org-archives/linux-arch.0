Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268132AbUIGOl4@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:29112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268131AbUIGOlN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2004 10:41:13 -0400
Date: Tue, 7 Sep 2004 07:40:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
In-Reply-To: <20040906141142.663941fb.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0409070736100.2299@ppc970.osdl.org>
References: <20040831183655.58d784a3.pj@sgi.com> <20040904133701.GE33964@muc.de>
 <20040904171417.67649169.pj@sgi.com> <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
 <20040904180548.2dcdd488.pj@sgi.com> <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
 <20040904204850.48b7cfbd.pj@sgi.com> <Pine.LNX.4.58.0409042055460.2331@ppc970.osdl.org>
 <20040904211749.3f713a8a.pj@sgi.com> <20040904215205.0a067ab8.pj@sgi.com>
 <20040906182330.GA79122@muc.de> <Pine.LNX.4.58.0409061147220.28608@ppc970.osdl.org>
 <20040906141142.663941fb.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Paul Jackson <pj@sgi.com>
Cc: ak@muc.de, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>


[ Linux-kernel replaced with linux-arch, to see if there's any commentary 
  from arch people involved.. ]

On Mon, 6 Sep 2004, Paul Jackson wrote:

> Linus wrote:
> > I hate the "byte at a time" interface.
> > 
> > That said, I think the "long at a time" interface we have now for bitmaps 
> > ends up being a compatibility problem, where the compat layer has to worry 
> > about big-endian 32-bit "long" lookign different from big-endian 64-bit 
> > "long".
> 
> My first preference would be to get all the binary bitmap interfaces
> (affinity, mbind and mempolicy) "right":
> 
>     I think that means an array of 'u32'.  This parallels what I did for
>     the ascii format, where there was less need to remain compatible
>     (except that ascii is naturally big-endian, while the u32 array has
>     the low order word first):
> 
>       $ cat /sys/devices/system/node/node0/cpumap
>       00000000,00000000,00000000,000000ff

I agree. 

>     No doubt Andi will veto this for mbind/mempolicy, because it breaks
>     libnuma's he has in the field - a reasonable concern. 

Now, it will _only_ break systems that are _both_ 64-bit _and_ big-endian. 
Little-endian or 32-bit boxes will never care.

There aren't that many of those machines. I've got one right here (ppc64), 
but that particular one is guaranteed not to break if only because it's 
running a 32-bit user space.

So it's ppc64, sparc64, s390x and sh64. I suspect the breakage is 
basically zero, since not only aren't there _that_ many machines out 
there, the percentage of them that use setaffinity or mbind is likely not 
that high either.

		Linus
