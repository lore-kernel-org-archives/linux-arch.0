Return-Path: <torvalds@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:18139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262623AbUCWP0v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 10:26:51 -0500
Date: Tue, 23 Mar 2004 07:25:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040323124027.D25134@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0403230722120.1106@ppc970.osdl.org>
References: <20040322151533.C11212@flint.arm.linux.org.uk>
 <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston>
 <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com>
 <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com>
 <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com>
 <20040323123439.GJ22639@dualathlon.random> <20040323124027.D25134@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>



On Tue, 23 Mar 2004, Russell King wrote:
>
> On Tue, Mar 23, 2004 at 01:34:39PM +0100, Andrea Arcangeli wrote:
> > anyways Linus vetoed the lazy approch so we probably should give it up
> > (the one thing I like most is to avoid the branch in the fast path).
> 
> I don't think he did - he vetoed adding another special condition to
> the fast path, or returning non-RAM pages via ->nopage.

Indeed.

What I _don't_ want is top add a new VM op function pointer as a special 
case. I abhor special cases, since they never go away, and end up making 
the code really hard to follow.

> However, I do not believe he has vetoed an architecture implementing
> dma_coherent_mmap() in such a way that it uses the ->nopage method,
> _provided_ ->nopage returns valid struct pages.

Yes. For all I care, the "struct page" migth even be dynamically
allocated, or something else very special (eg in a zone of its own that
the rest of the VM never ever actually sees). As long as "page_to_pfn()" 
works and does the right thing wrt such pages, that would be fine by me 
(ie as long as the VM doesn't need to have any special case code).

		Linus
