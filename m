Return-Path: <andrea@suse.de>
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6341
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262527AbUCWMds (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 07:33:48 -0500
Date: Tue, 23 Mar 2004 13:34:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040323123439.GJ22639@dualathlon.random>
References: <1079967870.1759.12.camel@mulgrave> <20040322151533.C11212@flint.arm.linux.org.uk> <1079969221.1759.25.camel@mulgrave> <1079992229.22190.29.camel@gaston> <405F6636.2090609@pobox.com> <20040322223509.GO2045@holomorphy.com> <1079999839.23205.40.camel@gaston> <20040323020756.GS2045@holomorphy.com> <20040323113534.GD22639@dualathlon.random> <20040323114452.GE2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323114452.GE2045@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, James Bottomley <James.Bottomley@steeleye.com>, Russell King <rmk@arm.linux.org.uk>, Linux Arch list <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Mar 23, 2004 at 03:44:52AM -0800, William Lee Irwin III wrote:
> mlock actually loops through the fault path, so in a sense it still
> requires fault handling on the part of the driver, though AFAICT it can

it requires fault handling of course, but that's just the API with the
driver, on the performance side (and it was the performance/latency side
of the page faults to be complained) no page faults are generated, so
it's not going to be a lot different from the map_sg stuff at runtime.

anyways Linus vetoed the lazy approch so we probably should give it up
(the one thing I like most is to avoid the branch in the fast path).
