Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632C3E559F;
	Tue, 24 Mar 2026 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377821; cv=none; b=Cz3Os8QrKgIlZcc2qNMcHh8urjzesDotLpbxUr4gHlrke9b2lcYTh2sx2WvpwoSULYOV/a23OK4QqTjD7ZDuYCDGx+zfT7ZPV9RvSI+7dh+A9dW3iOQGgBAC5ZHcl4/yq4nfpmLHRmMcme04SSF0HbWlMGkOxc+8CvxBAjk7F/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377821; c=relaxed/simple;
	bh=S0aEBB6Hs3Vms/fOltqD3iMe7jfXUYvj08ux34yihS4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WpaSzRZx9K2e8GXzvEiLtHDbuF/kDz8875/BmYkxGheZcMZZljNI24dDLoRUDuhE0zuxT/fGu92zFv08ZJ75UgvaWufLzrGo2JBU0lXhxMPHuMyV9B53boGj4cpkuuPeLznpm+8cj/Ndr37+FhyUzYekb6T5X1uoNBbQlOnDQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qp9yLI2s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qp9yLI2s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F1DC19424;
	Tue, 24 Mar 2026 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774377821;
	bh=S0aEBB6Hs3Vms/fOltqD3iMe7jfXUYvj08ux34yihS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qp9yLI2ss3h+ai6f5OaGy67x+J1yw4C6X8kNtrj8ChIAW3GFIuh4oHiazxaH/uVur
	 yJ9fhv/K/ztsKhc6ijGjpJ9KA6vwyYau0Csg17eOA76SSxNLe3kU/O7HdupLv8J7s7
	 CRAcsYSiMUGkwcoPHzEElyf73w16pjlh5DXe9Cb4=
Date: Tue, 24 Mar 2026 11:43:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: peterz@infradead.org, david@kernel.org, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
Subject: Re: [PATCH v8 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-Id: <20260324114339.2c0777f7b2c5483281a15667@linux-foundation.org>
In-Reply-To: <20260324085238.44477-1-lance.yang@linux.dev>
References: <20260324085238.44477-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 16:52:36 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> Hi all,
> 
> When page table operations require synchronization with software/lockless
> walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
> TLB (tlb->freed_tables or tlb->unshared_tables).
> 
> On architectures where the TLB flush already sends IPIs to all target CPUs,
> the subsequent sync IPI broadcast is redundant. This is not only costly on
> large systems where it disrupts all CPUs even for single-process page table
> operations, but has also been reported to hurt RT workloads[1].
> 
> This series introduces tlb_table_flush_implies_ipi_broadcast() to check if
> the prior TLB flush already provided the necessary synchronization. When
> true, the sync calls can early-return.
> 
> A few cases rely on this synchronization:
> 
> 1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
>    of the PMD table for other purposes in the last remaining user after
>    unsharing.
> 
> 2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
>    and (possibly) freeing the page table / re-depositing it.
> 
> Two-step plan as David suggested[4]:
> 
> Step 1 (this series): Skip redundant sync when we're 100% certain the TLB
> flush sent IPIs. INVLPGB is excluded because when supported, we cannot
> guarantee IPIs were sent, keeping it clean and simple.
> 
> Step 2 (future work): Send targeted IPIs only to CPUs actually doing
> software/lockless page table walks, benefiting all architectures.
> 
> Regarding Step 2, it obviously only applies to setups where Step 1 does not
> apply: like x86 with INVLPGB or arm64. Step 2 work is ongoing; early
> attempts showed ~3% GUP-fast overhead. Reducing the overhead requires more
> work and tuning; it will be submitted separately once ready.
> 
> On a 64-core Intel x86 server, the CAL interrupt count in
> /proc/interrupts dropped from 646,316 to 785 when collapsing a 20 GiB
> range with this series applied.

Well that's nice.

Which other architectures could utilize this?

> David Hildenbrand did the initial implementation. I built on his work and
> relied on off-list discussions to push it further - thanks a lot David!
>
> ...
>
>  arch/x86/include/asm/tlb.h      | 18 +++++++++++++++++-
>  arch/x86/include/asm/tlbflush.h |  2 ++
>  arch/x86/kernel/smpboot.c       |  1 +
>  arch/x86/mm/tlb.c               | 15 +++++++++++++++
>  include/asm-generic/tlb.h       | 17 +++++++++++++++++
>  mm/mmu_gather.c                 | 15 +++++++++++++++
>  6 files changed, 67 insertions(+), 1 deletion(-)

Can the x86 maintainers please review these changes?


