Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268355AbUHLCS1@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:54723 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268353AbUHLCS1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 22:18:27 -0400
Date: Wed, 11 Aug 2004 19:18:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clear_user_highpage()
In-Reply-To: <20040812004654.GX11200@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
References: <20040811161537.5e24c2b6.davem@redhat.com>
 <Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org> <20040812004654.GX11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Wed, 11 Aug 2004, William Lee Irwin III wrote:
> 
> Results from prototype prezeroing patches (ca. 2001) showed that
> dedicating a cpu on a 16x machine to prezeroing userspace pages (doing
> no other work on that cpu) improved kernel compile (insert sound of
> projectile vomiting here) "benchmarks". This suggests cache pollution
> and scheduling latency can be circumvented under some circumstances.

Heh.

And at what point does it become a problem? Caches are growing, at some 
point it is going to be a loss to zero memory on another CPU..

I really do believe (but can't back it up with any real numbers) that we 
want to try to keep pages in cache as long as possible. That means keeping 
the pages close to the last CPU that used them, btw.

It would be interesting to see if we could make the buddy allocator more
"per-cpu" friendly, for example - I suspect that would make much _more_ of
a difference than pre-zeroing pages. 

As it is, the pages we allocate have _no_ CPU affinity (unlike 
kmalloc/slab), and as a result they aren't even very likely to be in the 
cache even if you have tons of cache on the CPU. 

And my whole argument against pre-zeroing really falls totally flat if the 
pages aren't in the cache. 

So I'd personally be a whole lot more interested in seeing whether we 
could have per-CPU pages than in pre-zeroing. 

Fragmentation of memory is the _big_ problem, of course. It comes up
almost for _any_ page allocation issue. But it might be interesting to see 
if we could have a special per-cpu "page pool" for some usage. Sized 
fairly small - on the order of a few times the CPU cache size - and used 
for anonymous pages that we think might be short-lived.

		Linus
