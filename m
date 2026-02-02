Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFF72DC333;
	Mon,  2 Feb 2026 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026081; cv=none; b=kvE6CJrNPniZ6sinogaHpGspf7SPLQQudX0EHtQ8kxY4aYldik/cO3KgRPoFrxa/9n7s7U0sjX1cOvJ3VxlADVnP42nHA2RqKoQNpM9BmYzzi30UugQfcus/sUEpvKPvSsam2UnwFmIDiqKMrXveo+X0PpYEeTLwRjFrhClc9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026081; c=relaxed/simple;
	bh=HHlut04wQGtpXbbVMqYEOMquVZyPWGleVrBmqPbUjKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBEuBZA0vV8dA/Xq/6n23r9sxjqTHppJfUN5U8cduGEC6+ug2EpFs0tK5KPOx7TKytG8pWtJt42/tjrhIH1pCfX5EFHtaSykBjMd2q5IUBvO7PziLVvw3wwmAnqEbn0GXXheFKdGoEgvxqZUPHCn58C7qVimJHfVsCC0bieiTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ByWUxsUO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ByWUxsUO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Pu0UsVCQG9vrf6r9L2k7y8BIrpfSaWQDN3W3VbUraQ=; b=ByWUxsUOcWxLMhnki3SEF9i7Qs
	1Ryp6PQfjEpUpjKlHGRbJdhwYJQ1FlbPczZF407bYKoaimf7VMzfJFOUdToV1R3510WBOYyhEhply
	sd4lBMP1V/EtAksGDPpBiBBxW2QMugzzCYO1KvCmt+tBzJ6kRJtJ33LkxFu6pZDJyVwhnYyXwDix0
	NljZJH3Ooooo1ciud410bnqC7x/V46U+m3cLexl4MdeHw5fWM/P0gc9bQvNCh+8r/KnoURwWIowPf
	W6DfQsbStxwg74gKRTmICCEYiB9rwcx9ZlBKnJNXqnMgb8PBPxBDpoKR47hqlm4FH9havUqjOXLJ+
	h2KvJ5Pw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmqdL-0000000GJ5I-0aps;
	Mon, 02 Feb 2026 09:54:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98BFF303031; Mon, 02 Feb 2026 10:54:14 +0100 (CET)
Date: Mon, 2 Feb 2026 10:54:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com,
	riel@surriel.com, jannh@google.com, jgross@suse.com,
	seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, ioworker0@gmail.com
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
 walkers
Message-ID: <20260202095414.GE2995752@noisy.programming.kicks-ass.net>
References: <20260202074557.16544-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202074557.16544-1-lance.yang@linux.dev>

On Mon, Feb 02, 2026 at 03:45:54PM +0800, Lance Yang wrote:
> When freeing or unsharing page tables we send an IPI to synchronize with
> concurrent lockless page table walkers (e.g. GUP-fast). Today we broadcast
> that IPI to all CPUs, which is costly on large machines and hurts RT
> workloads[1].
> 
> This series makes those IPIs targeted. We track which CPUs are currently
> doing a lockless page table walk for a given mm (per-CPU
> active_lockless_pt_walk_mm). When we need to sync, we only IPI those CPUs.
> GUP-fast and perf_get_page_size() set/clear the tracker around their walk;
> tlb_remove_table_sync_mm() uses it and replaces the previous broadcast in
> the free/unshare paths.

I'm confused. This only happens when !PT_RECLAIM, because if PT_RECLAIM
__tlb_remove_table_one() actually uses RCU.

So why are you making things more expensive for no reason?
