Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD693D6CC1;
	Fri, 24 Apr 2026 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037426; cv=none; b=imxPjRaa6szQrN2yRI6XwyfF1jdRML+/24oyNrNbNr4RTkdvWK8jh8EuTb6NAs6BQ4sPEKNRphrGmboxbcHUqoUH9q4GB+t/IJT1c5wcyp9ADvAre3y25txAYwDr4f5owRaMP5tfTiEPlK+05JL5Z1H13fw5kf2QBfO3TlLO2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037426; c=relaxed/simple;
	bh=yz00f7Kt6rr2yoI71kcabVrEC5OsHYNxJ4SpURtk3YU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HNgcvqplwzJd1sZ/5OPs3gQCi74ceJKqtypZTjB3Oqkx+Xyu9KOrgfcqgkZiQfPn/HTko7r7AE4UCTb+ViaCfaH7oz58hoKIUtvCMckDrNVRkAm683zG8paSsRQcPkxM19BE6ll02WXjgip9ADrbfVCxHuy2bRO0KE0UDrcES1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yM9qm7ug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yM9qm7ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C556CC2BCB2;
	Fri, 24 Apr 2026 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777037425;
	bh=yz00f7Kt6rr2yoI71kcabVrEC5OsHYNxJ4SpURtk3YU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yM9qm7ugRKpa1d+28Z1NjLNSW05C1mgX6m5igCaRKQc7iIRC5yOMCgi/to4dpT5xN
	 bFALWlmn8qT9kIH6Sm5MIHDDZLqnatqEcA4qWIahjKxwhX8TDamvMVHysNvFFVTzB5
	 CG/3tt9EDVRK0WRV9LGfwZR3fkNqcAhp0izUQZOs=
Date: Fri, 24 Apr 2026 06:30:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: peterz@infradead.org, david@kernel.org, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush
 sent them
Message-Id: <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
In-Reply-To: <20260424062528.71951-1-lance.yang@linux.dev>
References: <20260424062528.71951-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 14:25:26 +0800 Lance Yang <lance.yang@linux.dev> wrote:

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

Sashiko questions:
	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev

(I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
said the same stuff about v9 and it's all wrong.  But better safe than
sorry!)

