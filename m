From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 2/8] mm: Remove i_mmap_mutex lockbreak
Date: Fri, 18 Feb 2011 02:46:03 +0900
Message-ID: <20110218024603.2089221d.kamezawa.hiroyu@jp.fujitsu.com>
References: <20110217170520.229881980@chello.nl>
	<20110217170854.766930171@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:38260 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab1BQRwh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2011 12:52:37 -0500
In-Reply-To: <20110217170854.766930171@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>

On Thu, 17 Feb 2011 18:05:22 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Hugh says:
>  "The only significant loser, I think, would be page reclaim (when
>   concurrent with truncation): could spin for a long time waiting for
>   the i_mmap_mutex it expects would soon be dropped? "
> 
> Counter points:
>  - cpu contention makes the spin stop (need_resched())
>  - zap pages should be freeing pages at a higher rate than reclaim
>    ever can
>  - shouldn't hold up reclaim more than lock_page() would
> 
> I think the simplification of the truncate code is definately worth
> it.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Maybe I have to improve batched-uncharge in memcg, whose work depends
on ZAP_BLOCK_SIZE....but the zap routine seems cleaner.

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
