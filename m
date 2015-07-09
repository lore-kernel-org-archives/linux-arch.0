From: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 17/24] sparc: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 11:05:53 -0700 (PDT)
Message-ID: <20150709.110553.2161087619432531159.davem@davemloft.net>
References: <20150709172855.564686637@infradead.org>
	<20150709175309.588450000@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44458 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbbGISFz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 14:05:55 -0400
In-Reply-To: <20150709175309.588450000@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, mingo@kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 09 Jul 2015 19:29:12 +0200

> Implement atomic logic ops -- atomic_{or,xor,and}.
> 
> These will replace the atomic_{set,clear}_mask functions that are
> available on some archs.
> 
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
