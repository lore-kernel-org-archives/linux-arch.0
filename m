Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCD286425
	for <linux-arch@vger.kernel.org>; Wed, 25 Mar 2026 02:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406646; cv=none; b=JFDyd9mYCSMqR0caT2xNF4bRSTCEK042pVBuDIppuaigc64vX8PjynnyJJIbyg2vdG8qN2sX/i7vqWvwD8vDZz7Hmvc+V2/dUNnZ/vqeD+BTv+nKHOmFWtZy9HxPJ5dtfJqbGS6LwApcHQYnDCaBLHy+YWWgqROfo9rlPI0ISLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406646; c=relaxed/simple;
	bh=c742JusgdRYlQGvW1a+5YwuppXgvwBk000930nYQ2To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zk3e/EF9lFDQ+JLlsN0dvjE9iDMdEoIZdUoOJoWwCa+LyEnd3LhPGEgmkDxBIUar2D+B6i1EfkWS56qM6Oi1snOEiH0BKstN7fKbpsu4Vtsdad7wq3NIN5niwT6vUv2QnsUIvoHm1VexAxSwGHzJsiK3DUlcBGtTyYNPDhNyv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JqJYxCEq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JqJYxCEq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774406632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ei/9l0yY7Rn5LSa4qZLzjXvD8FXeXbiuykIdzrEGGI8=;
	b=JqJYxCEq+lrhrLpLxEyPYrKajW5e8CXwMDWT8tH66YKkSs1lIqcLLBSimJDzH2ilNjg2fr
	XqMyL9OU6mgfjoBf8JGd1h7NnAf5wUyg9Sl9kJtncCi0D3BfYneybyTawTqCbvGyi29LLu
	TyhR/3ijGiBXv1xiv7Di0IYSdgxmA4Y=
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	peterz@infradead.org,
	dave.hansen@intel.com,
	david@kernel.org
Cc: dave.hansen@linux.intel.com,
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
	ioworker0@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v8 0/2] skip redundant sync IPIs when TLB flush sent them
Date: Wed, 25 Mar 2026 10:43:37 +0800
Message-Id: <20260325024337.56681-1-lance.yang@linux.dev>
In-Reply-To: <20260324114339.2c0777f7b2c5483281a15667@linux-foundation.org>
References: <20260324114339.2c0777f7b2c5483281a15667@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Tue, Mar 24, 2026 at 11:43:39AM -0700, Andrew Morton wrote:
>On Tue, 24 Mar 2026 16:52:36 +0800 Lance Yang <lance.yang@linux.dev> wrote:
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
>> On a 64-core Intel x86 server, the CAL interrupt count in
>> /proc/interrupts dropped from 646,316 to 785 when collapsing a 20 GiB
>> range with this series applied.
>
>Well that's nice.
>
>Which other architectures could utilize this?

Thanks! RISC-V looks like a candidate, and if I get some time I'll dive
into it.

>
>> David Hildenbrand did the initial implementation. I built on his work and
>> relied on off-list discussions to push it further - thanks a lot David!
>>
>> ...
>>
>>  arch/x86/include/asm/tlb.h      | 18 +++++++++++++++++-
>>  arch/x86/include/asm/tlbflush.h |  2 ++
>>  arch/x86/kernel/smpboot.c       |  1 +
>>  arch/x86/mm/tlb.c               | 15 +++++++++++++++
>>  include/asm-generic/tlb.h       | 17 +++++++++++++++++
>>  mm/mmu_gather.c                 | 15 +++++++++++++++
>>  6 files changed, 67 insertions(+), 1 deletion(-)
>
>Can the x86 maintainers please review these changes?

Yes, an x86 review would be much appreciated, please!

After commit a37259732a7d ("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE
unconditional"), tlb_remove_table_sync_one() is no longer a NOP, even on
native x86 without INVLPGB, so it ends up issuing a redundant IPI
broadcast.

Thanks,
Lance
