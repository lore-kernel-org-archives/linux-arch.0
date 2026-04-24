Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37743DBD60;
	Fri, 24 Apr 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040135; cv=none; b=QvzhzvyrqvrQDh/fQ4agG2vBFK76CZDdI0UevYMvoBd0P7LW5hyHb1JnVRi7OJWacmnAHX/S77x0jC0yzTYL4oqKVPhGl7lW786tTbMHS1qK1FdXuR+Z1mNLGvgybo6kH/lOZ9ctqHqSitxOjXwuyf/TbNa2gufJOkctiVLV8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040135; c=relaxed/simple;
	bh=L08wbD9RP1yIjusIkp7uHpvtDFAssJesg0vXbY3SOlo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QgRQFy1Ym88G6e65XNXbV/tBRO/8GO6H8rJqUTGEchkvPSpknxR49tmUB0DqqzT3DfKpfRXmZCIXnbUKAdpFHyDxvBmnY4OWN7K/ZyLK2DiyEyQ6uDhN41E5dkKVgKk66R0y2yKaNcmsjmIPq8f9XIuMMvIH0bupXr1Yg05gdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uQNXKqM+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uQNXKqM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450B1C19425;
	Fri, 24 Apr 2026 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777040135;
	bh=L08wbD9RP1yIjusIkp7uHpvtDFAssJesg0vXbY3SOlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQNXKqM+5mUhzXG3wrgwsljDXLTKkGCn8k++R/99g0dgBzwKo29qei3pipqEpVoSp
	 HuV9V9S/Im3ZA6Vaz92WxkLH2DorTEPO8R4P/gHUl8PtrDg1axezxhJHT7OiIMHGd9
	 KAwmmNczlPPrkQAfSbFnDc8IB/UfpxrsFV/tN4G0=
Date: Fri, 24 Apr 2026 07:15:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Lance Yang <lance.yang@linux.dev>, peterz@infradead.org,
 david@kernel.org, dave.hansen@intel.com, dave.hansen@linux.intel.com,
 ypodemsk@redhat.com, hughd@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush
 sent them
Message-Id: <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
In-Reply-To: <aetw4aoABYj3keMh@plex>
References: <20260424062528.71951-1-lance.yang@linux.dev>
	<20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
	<aetw4aoABYj3keMh@plex>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 13:37:04 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> On 04-24 06:30, Andrew Morton wrote:
> > On Fri, 24 Apr 2026 14:25:26 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> > 
> > > When page table operations require synchronization with software/lockless
> > > walkers, they call tlb_remove_table_sync_{one,rcu}() after flushing the
> > > TLB (tlb->freed_tables or tlb->unshared_tables).
> > > 
> > > On architectures where the TLB flush already sends IPIs to all target CPUs,
> > > the subsequent sync IPI broadcast is redundant. This is not only costly on
> > > large systems where it disrupts all CPUs even for single-process page table
> > > operations, but has also been reported to hurt RT workloads[1].
> > > 
> > > This series introduces tlb_table_flush_implies_ipi_broadcast() to check if
> > > the prior TLB flush already provided the necessary synchronization. When
> > > true, the sync calls can early-return.
> > > 
> > > A few cases rely on this synchronization:
> > > 
> > > 1) hugetlb PMD unshare[2]: The problem is not the freeing but the reuse
> > >    of the PMD table for other purposes in the last remaining user after
> > >    unsharing.
> > > 
> > > 2) khugepaged collapse[3]: Ensure no concurrent GUP-fast before collapsing
> > >    and (possibly) freeing the page table / re-depositing it.
> > 
> > Sashiko questions:
> > 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> > 
> > (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> > said the same stuff about v9 and it's all wrong.  But better safe than
> > sorry!)
> 
> These emails are helpful; but, I do not believe you should have to 
> manually follow up with a link to every new patch series.
> 
> Perhaps  Sashiko could automatically send a summary email in response to 
> the cover letter, or provide a link once the reviews are complete. For 
> the kexec ML, we opted-in with Roman to receive automated emails from 
> sashiko.

Yep.  I'd be OK with an automatic reply-to-all.  Maybe some won't like
that.

An alternative I've discussed with Roman is an automated
reply-to-author with a cc to a dedicated list (we could use mm-commits
for now).

Preferences?

(I'd suggest automated-reply-to-all, see who complains, then figure out
why they can't figure out mail filtering ;))

