From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/28] rename anon_vma_lock to vma_lock_anon_vma
Date: Mon, 07 Jun 2010 17:01:45 +0200
Message-ID: <1275922905.1645.569.camel@laptop>
References: <20100607110654.606530953@chello.nl>
	 <20100607111406.662536918@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:44895 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab0FGPBz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2010 11:01:55 -0400
Received: from f199130.upc-f.chello.nl ([80.56.199.130] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1OLdpq-0004gD-8T
	for linux-arch@vger.kernel.org; Mon, 07 Jun 2010 15:01:54 +0000
In-Reply-To: <20100607111406.662536918@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

On Mon, 2010-06-07 at 13:06 +0200, Peter Zijlstra wrote:

> From: Rik van Riel <riel@redhat.com>
> 
> Rename anon_vma_lock to vma_lock_anon_vma.  This matches the
> naming style used in page_lock_anon_vma and will come in really
> handy further down in this patch series.
> 
> Signed-off-by: Rik van Riel <riel@redhat.com>
> Acked-by: Mel Gorman <mel@csn.ul.ie>
> Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> LKML-Reference: <20100526153853.55b72183@annuminas.surriel.com>
> ---

Missed a refresh... the below bit also wants in.

---
Index: linux-2.6/mm/mmap.c
===================================================================
--- linux-2.6.orig/mm/mmap.c
+++ linux-2.6/mm/mmap.c
@@ -1783,7 +1783,7 @@ static int expand_downwards(struct vm_ar
 			vma->vm_pgoff -= grow;
 		}
 	}
-	anon_vma_unlock(vma);
+	vma_unlock_anon_vma(vma);
 	return error;
 }
 
