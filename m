From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 23/24] atomic: Collapse all atomic_{set,clear}_mask
 definitions
Date: Fri, 10 Jul 2015 18:27:39 +0200
Message-ID: <20150710162739.GN19282@twins.programming.kicks-ass.net>
References: <20150709172855.564686637@infradead.org>
 <20150709175310.229218215@infradead.org>
 <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com>
 <20150710103945.GH19282@twins.programming.kicks-ass.net>
 <559FC9CC.6000400@ezchip.com>
 <20150710134256.GS7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41464 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbbGJQ1o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2015 12:27:44 -0400
Content-Disposition: inline
In-Reply-To: <20150710134256.GS7557@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will.deacon@arm.com>, =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>

On Fri, Jul 10, 2015 at 02:42:56PM +0100, Russell King - ARM Linux wrote:
> The obvious question though is whether we have an established name for this
> operation elsewhere in the kernel, and whether we should have consistency.

Consistency is good.

> In include/linux, we already have (grepping for 'and_*not'):
> 
> include/linux/nodemask.h:#define nodes_andnot(dst, src1, src2) \
> include/linux/bitmap.h:extern int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
> include/linux/cpumask.h:static inline int cpumask_andnot(struct cpumask *dstp,
> 
> We also have:
> 
> include/linux/signal.h:#define _sig_andn(x,y)       ((x) & ~(y))
> 
> which seems to be the only instance of "andn" in include/.

How about I rename the _sig_andn one to _sig_andnot, and go with
atomic_andnot, to match the *mask functions.
