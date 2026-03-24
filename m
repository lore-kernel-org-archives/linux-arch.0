Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F143AC0C9
	for <linux-arch@vger.kernel.org>; Tue, 24 Mar 2026 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774332882; cv=none; b=aoV5VZJBssucbFOPQexE3QRFthRENqsYQ2Lhg9cHtYdIZGyyDwLPV1pUkXRzs0KkVc7XZziYc5Vz0EF96wPY6NP/cvzJQAJBSUVnWZzJzOeysAKJ/9XHP33Uq6oL5PcZ0GGK+lwxcv7OmvZI6XRqquFzhKhBCNrhdvQHxKDq8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774332882; c=relaxed/simple;
	bh=skR628SMCx9KTemD4Cg3GA18jPV5b9gBdn2QAV+ZaTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcAWgtplrf1X/aK+1WOlTYNDOnRPdnNv7sqGIMjYsMJDzf1uWv5QQKL7qdT2FfkvUU9ANH6cC/b/lP2aIg362PBM+FchcFF1u2NRUVmHewdftA6a3hEp3ShwAAAVByrlnhgUAXvA83dYNoWcsEqtgO1qmqtJ+VVO7aqXjmpwck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hnT6R2oX; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hnT6R2oX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774332868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICRwvZNxMVB+eDUAUeHAtU147HuuApF1zRxwwY2qVB4=;
	b=hnT6R2oXEZmInaXSy3cUMJ/hU2EBTkHqrDBMOTe86YmiKmkBh4ZMxGwIf3PT6Bbodw5rsH
	zp6vfO4HhkUvXVnkryl6PMVzOGOSTIkhVAQ45c8jFi4YMTXWmFXvOOAep/e0TNDHsvvvoc
	0XvhJ3OfAPbCQDqd1ZxdNUPU56+eQf8=
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: lance.yang@linux.dev,
	peterz@infradead.org,
	david@kernel.org,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	ypodemsk@redhat.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	jgross@suse.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ioworker0@gmail.com
Subject: Re: [PATCH v7 0/2] skip redundant sync IPIs when TLB flush sent them
Date: Tue, 24 Mar 2026 14:14:19 +0800
Message-Id: <20260324061419.48613-1-lance.yang@linux.dev>
In-Reply-To: <20260323135317.0b702a575eeef93332ba2519@linux-foundation.org>
References: <20260323135317.0b702a575eeef93332ba2519@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Mar 23, 2026 at 01:53:17PM -0700, Andrew Morton wrote:
>On Mon,  9 Mar 2026 10:07:09 +0800 Lance Yang <lance.yang@linux.dev> wrote:
>
>> Hi all,
>> 
>> When page table operations require synchronization with software/lockless
>> walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
>> TLB (tlb->freed_tables or tlb->unshared_tables).
>> 
>> On architectures where the TLB flush already sends IPIs to all target CPUs,
>> the subsequent sync IPI broadcast is redundant. This is not only costly on
>> large systems where it disrupts all CPUs even for single-process page table
>> operations, but has also been reported to hurt RT workloads[1].
>> 
>> This series introduces tlb_table_flush_implies_ipi_broadcast() to check if
>> the prior TLB flush already provided the necessary synchronization. When
>> true, the sync calls can early-return.
>> 
>> A few cases rely on this synchronization:
>> 
>> 1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
>>    of the PMD table for other purposes in the last remaining user after
>>    unsharing.
>> 
>> 2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
>>    and (possibly) freeing the page table / re-depositing it.
>> 
>> Two-step plan as David suggested[4]:
>> 
>> Step 1 (this series): Skip redundant sync when we're 100% certain the TLB
>> flush sent IPIs. INVLPGB is excluded because when supported, we cannot
>> guarantee IPIs were sent, keeping it clean and simple.
>> 
>> Step 2 (future work): Send targeted IPIs only to CPUs actually doing
>> software/lockless page table walks, benefiting all architectures.
>> 
>> Regarding Step 2, it obviously only applies to setups where Step 1 does not
>> apply: like x86 with INVLPGB or arm64. Step 2 work is ongoing; early
>> attempts showed ~3% GUP-fast overhead. Reducing the overhead requires more
>> work and tuning; it will be submitted separately once ready.
>> 
>> ...
>> 
>>  arch/x86/include/asm/tlb.h      | 17 ++++++++++++++++-
>>  arch/x86/include/asm/tlbflush.h |  2 ++
>>  arch/x86/kernel/smpboot.c       |  1 +
>>  arch/x86/mm/tlb.c               | 15 +++++++++++++++
>>  include/asm-generic/tlb.h       | 17 +++++++++++++++++
>>  mm/mmu_gather.c                 | 15 +++++++++++++++
>>  6 files changed, 66 insertions(+), 1 deletion(-)
>
>Kinda straddles both MM and x86.
>
>I expect a v8 based on David's comments.

Yes, a v8 is on the way.

>One merge path is for the x86 people to take this, noting David's acks.
>
>The other merge path is via mm.git, if the x86 people can please
>perform review.
>
>And...  mm.git is basically full (overflowing) for this cycle and
>review/test has some catching up to do.  So I'd prefer to only take the
>important things.  This patchset is a performance improvement but
>contains no measurements to demonstrate the benefit, so I'm not able to
>determine its importance!

That's a fair point. I should have included numbers from the start.

On a 64-core Intel x86 server, the CAL interrupt count in
/proc/interrupts dropped from 646,316 to 785 when collapsing a 20 GiB
range with this series applied.

The larger the system, the more costly redundant broadcast IPIs become.

Thanks,
Lance
