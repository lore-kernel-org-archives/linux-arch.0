From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tile: Provide atomic_{or,xor,and}
Date: Thu, 9 Jul 2015 22:49:56 +0200
Message-ID: <20150709204956.GF2859@worktop.programming.kicks-ass.net>
References: <20150709172855.564686637@infradead.org>
 <1436474297-32187-1-git-send-email-cmetcalf@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50045 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbGIUuT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 16:50:19 -0400
Content-Disposition: inline
In-Reply-To: <1436474297-32187-1-git-send-email-cmetcalf@ezchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, mingo@kernel.org

On Thu, Jul 09, 2015 at 04:38:17PM -0400, Chris Metcalf wrote:
> Implement atomic logic ops -- atomic_{or,xor,and}.
> 
> For tilegx, these are relatively straightforward; the architecture
> provides atomic "or" and "and", both 32-bit and 64-bit.  To support
> xor we provide a loop using "cmpexch".
> 
> For the older 32-bit tilepro architecture, we have to extend
> the set of low-level assembly routines to include 32-bit "and",
> as well as all three 64-bit routines.  Somewhat confusingly,
> some 32-bit versions are already used by the bitops inlines, with
> parameter types appropriate for bitops, so we have to do a bit of
> casting to match "int" to "unsigned long".
> 
> Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
> ---
> Peter, I'm guessing you should just take this into your series,
> rather than my pushing it through the tile tree.

Awesome, thanks! Yeah, I'll collect the lot.
