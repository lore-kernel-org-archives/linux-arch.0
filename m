Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45321 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262522AbUCWMkj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 07:40:39 -0500
Date: Tue, 23 Mar 2004 12:40:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323124027.D25134@flint.arm.linux.org.uk>
References: <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com> <20040323123439.GJ22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323123439.GJ22639@dualathlon.random>; from andrea@suse.de on Tue, Mar 23, 2004 at 01:34:39PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 23, 2004 at 01:34:39PM +0100, Andrea Arcangeli wrote:
> anyways Linus vetoed the lazy approch so we probably should give it up
> (the one thing I like most is to avoid the branch in the fast path).

I don't think he did - he vetoed adding another special condition to
the fast path, or returning non-RAM pages via ->nopage.

However, I do not believe he has vetoed an architecture implementing
dma_coherent_mmap() in such a way that it uses the ->nopage method,
_provided_ ->nopage returns valid struct pages.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
