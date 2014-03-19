From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 26/31] arch,sparc: Convert smp_mb__*
Date: Wed, 19 Mar 2014 13:54:28 -0400 (EDT)
Message-ID: <20140319.135428.665886252770597921.davem@davemloft.net>
References: <20140319064729.660482086@infradead.org>
	<20140319065205.163413133@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:37047 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbaCSRya (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Mar 2014 13:54:30 -0400
In-Reply-To: <20140319065205.163413133@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com

From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 19 Mar 2014 07:47:55 +0100

> sparc32: fully relies on asm-generic/barrier.h and thus can use its
> 	 implementation.
> 
> sparc64: is strongly ordered and its atomic ops imply a full barrier,
> 	 implement the new primitives using barrier().
> 
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
