From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 17/28] ARC: add compiler barrier to LLSC based cmpxchg
Date: Tue, 9 Jun 2015 14:23:27 +0200
Message-ID: <20150609122327.GW3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-18-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45925 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbbFIMXe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:23:34 -0400
Content-Disposition: inline
In-Reply-To: <1433850508-26317-18-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, arc-linux-dev@synopsys.com

On Tue, Jun 09, 2015 at 05:18:17PM +0530, Vineet Gupta wrote:
> When auditing cmpxchg call sites, Chuck noted that gcc was optimizing
> away some of the desired LDs.
> 
> |	do {
> |		new = old = *ipi_data_ptr;
> |		new |= 1U << msg;
> |	} while (cmpxchg(ipi_data_ptr, old, new) != old);
> 
> was generating to below
> 
> | 8015cef8:	ld         r2,[r4,0]  <-- First LD
> | 8015cefc:	bset       r1,r2,r1
> |
> | 8015cf00:	llock      r3,[r4]  <-- atomic op
> | 8015cf04:	brne       r3,r2,8015cf10
> | 8015cf08:	scond      r1,[r4]
> | 8015cf0c:	bnz        8015cf00
> |
> | 8015cf10:	brne       r3,r2,8015cf00  <-- Branch doesn't go to orig LD
> 
> Although this was fixed by adding a ACCESS_ONCE in this call site, it
> seems safer (for now at least) to add compiler barrier to LLSC based
> cmpxchg

This is required even. cmpxchg() should include a full memory barrier
_before_ and _after_ the op. Both imply a compiler barrier.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
