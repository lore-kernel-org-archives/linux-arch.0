From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] mm: Fix the TLB range flushed when __tlb_remove_page()
 runs out of slots
Date: Mon, 29 Jul 2013 16:41:06 -0700 (PDT)
Message-ID: <20130729.164106.943996066712571180.davem@davemloft.net>
References: <1369832173-15088-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:54845 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3G2XlK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2013 19:41:10 -0400
In-Reply-To: <1369832173-15088-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mgorman@suse.de, hughd@google.com, riel@redhat.com, rientjes@google.com, peterz@infradead.org, linux-arch@vger.kernel.org, catalin.marinas@arm.com, jcmvbkbc@gmail.com

From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Wed, 29 May 2013 18:26:13 +0530

> zap_pte_range loops from @addr to @end. In the middle, if it runs out of
> batching slots, TLB entries needs to be flushed for @start to @interim,
> NOT @interim to @end.
> 
> Since ARC port doesn't use page free batching I can't test it myself but
> this seems like the right thing to do.
> Observed this when working on a fix for the issue at thread:
> 	http://www.spinics.net/lists/linux-arch/msg21736.html
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

As this bug can cause pretty serious memory corruption, I'd like to
see this submitted to -stable.

Thanks!
