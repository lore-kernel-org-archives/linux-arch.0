From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 02/13] mm: Revalidate anon_vma in page_lock_anon_vma()
Date: Thu, 08 Apr 2010 16:50:55 -0400
Message-ID: <4BBE41AF.5050807@redhat.com>
References: <20100408191737.296180458@chello.nl> <20100408192722.687144862@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933241Ab0DHUv7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Apr 2010 16:51:59 -0400
In-Reply-To: <20100408192722.687144862@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On 04/08/2010 03:17 PM, Peter Zijlstra wrote:
> There is nothing preventing the anon_vma from being detached while we
> are spinning to acquire the lock. Most (all?) current users end up
> calling something like vma_address(page, vma) on it, which has a
> fairly good chance of weeding out wonky vmas.
>
> However suppose the anon_vma got freed and re-used while we were
> waiting to acquire the lock, and the new anon_vma fits with the
> page->index (because that is the only thing vma_address() uses to
> determine if the page fits in a particular vma, we could end up
> traversing faulty anon_vma chains.
>
> Close this hole for good by re-validating that page->mapping still
> holds the very same anon_vma pointer after we acquire the lock, if not
> be utterly paranoid and retry the whole operation (which will very
> likely bail, because it's unlikely the page got attached to a different
> anon_vma in the meantime).
>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>
> Cc: Hugh Dickins<hugh.dickins@tiscali.co.uk>
> Cc: Linus Torvalds<torvalds@linux-foundation.org>

Reviewed-by: Rik van Riel <riel@redhat.com>
