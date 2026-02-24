Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8F3806B3;
	Tue, 24 Feb 2026 11:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934168; cv=none; b=WSZIJmSJus4jWH8BxlCXqWweaIh9HD+Cwi6kyrRtVRZV2X8nfZNazYFm+TFdZyT3gPInCy0/uSsWKVoB8vsNtwqh4PFl4BbhasGgPdeOd+fP2WF/4elBZ6TGP3b859wOb/heolXZlZyuYu0QlhkOGQhVHVg6krjgQqgpxXx2UJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934168; c=relaxed/simple;
	bh=UOhEwo0ch7/jii7Fl3PaEck1pC1HHpIGiJUF7mR5/w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puEtjXtW2aE4HRcptYL6ISGrFhOk7B2qLf817f2VWeLmqVjDSW+fCzCjDChQrw+DO+lsiirwBqv1+CTuKXjRmnVWQ8rYhlZdEq4BNJF4zdzHWwUwI1XkX7z6TKdPg7YfhQyskLSazHfsqubVLwlEzczXBYLntmAEC/ZgpzQrm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=frg9bYUz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="frg9bYUz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jZbApCE7aKfGQAJ5QYtHKFYfwUek4AYedGrEYuPbu4o=; b=frg9bYUzHcb76/JI/1FsMqNH4K
	pLRGr2stwD4MXQEu+8ZXB0ZgGRK7ykCXStgirFWMsUYzmhWv5PJw1WOkwyqHeWDcbY45mmOEei5TO
	LLHVst7OZ5GAC7fWSbYGK2UxhvrUNUleXThNDbd2EAfL326rPapEkBZhkUUhISa+8yUUN9XsOstey
	Z3cijP6YBgzO0gUHizujJx8+k7V3yfpzOhAunvqnRXjoBTi5wdJDzSbyJrgqG1oR3B1rLqZnpqOf/
	/Sr3B9GfELbkHD0O4NjJcWAVp5HR+6cvnHHcJOApF87C8PfhOYo+B29nTd6gnQbdjbsTnTpYafdUy
	ZkxuiH3Q==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vur1B-0000000GmLl-41uX;
	Tue, 24 Feb 2026 11:55:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 811F930095A; Tue, 24 Feb 2026 12:55:56 +0100 (CET)
Date: Tue, 24 Feb 2026 12:55:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
Message-ID: <20260224115556.GU1395416@noisy.programming.kicks-ass.net>
References: <20260224030700.35857-1-lance.yang@linux.dev>
 <20260224114152.GX1395266@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224114152.GX1395266@noisy.programming.kicks-ass.net>

On Tue, Feb 24, 2026 at 12:41:52PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 24, 2026 at 11:07:00AM +0800, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> > 
> > When freeing page tables, we try to batch them. If batch allocation fails
> > (GFP_NOWAIT), __tlb_remove_table_one() immediately frees the one without
> > batching.
> > 
> > On !CONFIG_PT_RECLAIM, the fallback sends an IPI to all CPUs via
> > tlb_remove_table_sync_one(). It disrupts all CPUs even when only a single
> > process is unmapping memory. IPI broadcast was reported to hurt RT
> > workloads[1].
> > 
> > tlb_remove_table_sync_one() synchronizes with lockless page-table walkers
> > (e.g. GUP-fast) that rely on IRQ disabling. These walkers use
> > local_irq_disable(), which is also an RCU read-side critical section.
> > 
> > This patch introduces tlb_remove_table_sync_rcu() which uses RCU grace
> > period (synchronize_rcu()) instead of IPI broadcast. This provides the
> > same guarantee as IPI but without disrupting all CPUs. Since batch
> > allocation already failed, we are in a way slow path where sleeping is
> > acceptable - we are in process context (unmap_region, exit_mmap) with only
> > mmap_lock held. might_sleep() will catch any invalid context.
> 
> So sending the IPIs also requires non-atomic context, so change there.

s/so/no/ -- typing hard
