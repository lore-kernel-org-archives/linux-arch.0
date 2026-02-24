Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54B39A7E9;
	Tue, 24 Feb 2026 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936550; cv=none; b=FRL8zzet8RVVRv7aERNLYwWNeVtD+70aYN5RsbugBJfFcLZLZYx+85iEDw7sPsBOifyB+8IRRsSjLd+gzYOlqDk6WiJmj7i40dw6kUATsW+h/MmfYkxYN+lABRRz1LMNLR365SbbUaT49z9f2qMEVGfSIjhEdyi4o6Wv4A1mYZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936550; c=relaxed/simple;
	bh=lAQHMqJMqxvKFWnZMONOUGqsYIRDRmdvn21slxsCB2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6IgKQWlgQQLgbvUMZrt23qS8R11ZXaE3WJmKjbFiRKV3lMWh1ZON6LIS37wtfw/CYjE4bk+bIciOzRfNIPtaAXYz6voIRPZzj56IMB+r1zer151tEcA2hmSNubKChZMul3NJlaYoCxdhrz4GELw6EqsbhyTLnrJU7OxlCPeraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mb1Y/bzC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mb1Y/bzC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NmoZ7yGJ/UNmDeoZv4NVg492ij4hS7di67j0tIjaI44=; b=Mb1Y/bzCW8J3tp0nmMGZqbjymr
	5EX5/+a+CBFyQdjkfeY0I9l1y7F/QqiAxPTkIcX0JRls+skfPSD3p05DpDataRXPFzz1ayrY3Q0vl
	TDNDXUHKzKSIA5m/fAfzZTSyIi6zA1cLvKC7OkL4alEbpG2bBz6QgAdhusVTxHL25/fCmoclIduXk
	zTIlExN02ALquUMvlrmTX7zdOszPzuie/d413jqURBzfo2JC37LPixPwAo3Zqh+I9bZ0EknT4HevW
	Ncy5VAeL7zTMmC95PJNeT0ONdIO8tbbj/Fl/lEwp+gYgTsdNssWNZoklmqPJHKJJlUQFmQUXNQY4g
	zlLOVZoA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vurdg-0000000761b-0wfK;
	Tue, 24 Feb 2026 12:35:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E54830095A; Tue, 24 Feb 2026 13:35:38 +0100 (CET)
Date: Tue, 24 Feb 2026 13:35:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
Message-ID: <20260224123538.GW1282955@noisy.programming.kicks-ass.net>
References: <20260224030700.35857-1-lance.yang@linux.dev>
 <20260224114152.GX1395266@noisy.programming.kicks-ass.net>
 <5cc90e7a-ae32-4352-8e0b-2eee5a5ee122@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc90e7a-ae32-4352-8e0b-2eee5a5ee122@linux.dev>

On Tue, Feb 24, 2026 at 08:18:46PM +0800, Lance Yang wrote:
> 
> 
> On 2026/2/24 19:41, Peter Zijlstra wrote:
> > On Tue, Feb 24, 2026 at 11:07:00AM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > > 
> > > When freeing page tables, we try to batch them. If batch allocation fails
> > > (GFP_NOWAIT), __tlb_remove_table_one() immediately frees the one without
> > > batching.
> > > 
> > > On !CONFIG_PT_RECLAIM, the fallback sends an IPI to all CPUs via
> > > tlb_remove_table_sync_one(). It disrupts all CPUs even when only a single
> > > process is unmapping memory. IPI broadcast was reported to hurt RT
> > > workloads[1].
> > > 
> > > tlb_remove_table_sync_one() synchronizes with lockless page-table walkers
> > > (e.g. GUP-fast) that rely on IRQ disabling. These walkers use
> > > local_irq_disable(), which is also an RCU read-side critical section.
> > > 
> > > This patch introduces tlb_remove_table_sync_rcu() which uses RCU grace
> > > period (synchronize_rcu()) instead of IPI broadcast. This provides the
> > > same guarantee as IPI but without disrupting all CPUs. Since batch
> > > allocation already failed, we are in a way slow path where sleeping is
> > > acceptable - we are in process context (unmap_region, exit_mmap) with only
> > > mmap_lock held. might_sleep() will catch any invalid context.
> > 
> > So sending the IPIs also requires non-atomic context, so change there.
> 
> Yeah, you're right!
> 
> > What isn't explained, and very much not clear to me, is why
> > tlb_remove_table_sync_one() is retained?
> 
> Good point. tlb_remove_table_sync_one() is still needed in:
> 
> 1) khugepaged (mm/khugepaged.c) - after pmdp_collapse_flush()
> 2) tlb_finish_mmu() (tlb.h) - when tlb->fully_unshared_tables
> 3) ...
> 
> These are not slow paths like batch allocation failure. This patch only
> converts this obvious slow path first.
> 
> I'm working on converting the remaining callers as well, but not with
> RCU, looking at other options (e.g. targeted IPI).

OK, so with that addition to the Changelog,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
