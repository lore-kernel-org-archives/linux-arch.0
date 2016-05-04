From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: kmap_atomic and preemption
Date: Wed, 4 May 2016 20:17:55 +0100
Message-ID: <20160504191755.GV19428@n2100.arm.linux.org.uk>
References: <5729D0F4.9090907@synopsys.com>
 <20160504134729.GP3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:41960 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbcEDTUe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 15:20:34 -0400
Content-Disposition: inline
In-Reply-To: <20160504134729.GP3430@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wed, May 04, 2016 at 03:47:29PM +0200, Peter Zijlstra wrote:
> Traditionally kmap_atomic() disables preemption; and the reason is that
> the returned pointer must stay valid. This had a side effect in that it
> also disabled pagefaults.

A lowmem page should never change its page_address(), so that much is
safe.  I think the question is whether there is any driver code which
assumes that preemption is unconditionally disabled between a
kmap_atomic() has been called.

That wouldn't be an unreasonable assumption given the name of the
function, so I'd suggest caution with making kmap_atomic() have these
kinds of differing behaviours depending on whether we're asking to
kmap a high or lowmem page.

If we are going to allow this, I think it at least needs to be well
documented.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
