Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268464AbUJTPks@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:3798 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268315AbUJTPhG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 11:37:06 -0400
Date: Wed, 20 Oct 2004 17:29:23 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: 4level page tables architecture porting
Message-ID: <20041020152923.GC32257@wotan.suse.de>
References: <20041020131340.GA5282@mschwid3.boeblingen.de.ibm.com> <20041020143949.GB32257@wotan.suse.de> <200410201706.00435.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410201706.00435.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Oct 20, 2004 at 05:05:56PM +0200, Arnd Bergmann wrote:
> On Middeweken 20 Oktober 2004 16:39, Andi Kleen  wrote:
> > BTW
> > The motivation for really large address space spaces is actually not really
> > to use that much memory, but just to be able to mmap extremly large
> > files. The original reason I started this was because some users wanted
> > to mmap 300GB files and it didn't work because the shared
> > libraries were in the way. So if you consider that it may be worth
> > enlarging it at some point anyways.
> 
> Doesn't that mean spending another page for each running process? I would

Yes.

But I see you're using order 1 pages on s390x, in case your hardware
supports 4levels with order 0 pages it may be cheaper to use that.

> rather like to see a way to use a dynamic page table layout, where 32 bit
> tasks always use only two level page tables, while 64 bit tasks start
> with two or three levels and then go to four or five levels when users
> map files that don't fit in.

I don't see how that would work. The stack is always at the top
and .text is near the beginning, so you need the maximum range of 
address space, which means all possible levels.

> 
> Which architectures are actually capable of doing this? It's probably
> not worth spending much work on that if it's an s390 only thing.

I suppose all architectures with software refilled TLB would be able 
to do it in theory. x86-64/i386 isn't one of them.

-Andi
