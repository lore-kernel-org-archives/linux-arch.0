From: Rik van Riel <riel@redhat.com>
Subject: Re: [RFT][PATCH] mm: Fix race in kunmap_atomic()
Date: Wed, 27 Oct 2010 13:46:47 -0400
Message-ID: <4CC86587.6010506@redhat.com>
References: <20101027125154.GA23679@infradead.org> <1288191261.15336.1953.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895Ab0J0RrL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Oct 2010 13:47:11 -0400
In-Reply-To: <1288191261.15336.1953.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>

On 10/27/2010 10:54 AM, Peter Zijlstra wrote:

> Christoph reported a nice splat which illustrated a race in the new
> stack based kmap_atomic implementation.
>
> The problem is that we pop our stack slot before we're completely done
> resetting its state -- in particular clearing the PTE (sometimes that's
> CONFIG_DEBUG_HIGHMEM). If an interrupt happens before we actually clear
> the PTE used for the last slot, that interrupt can reuse the slot in a
> dirty state, which triggers a BUG in kmap_atomic().
>
> Fix this by introducing kmap_atomic_idx() which reports the current slot
> index without actually releasing it and use that to find the PTE and
> delay the _pop() until after we're completely done.
>
> Reported-by: Christoph Hellwig<hch@infradead.org>
> Signed-off-by: Peter Zijlstra<a.p.zijlstra@chello.nl>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All rights reversed
