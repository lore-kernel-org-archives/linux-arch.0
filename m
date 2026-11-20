Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193340;
	b=vgOg8qQl2O/4X02OwwvutOpb7hQVaWR7pLhcAdjYZc+3cP5HDDvuWKAKq7RPRsJoTSq4
	 A7VKLLPM1KSI7gsydNVipJ7WmAlYiPRhqZxaVY/FlIErqlgiBk+GI8NOh1mPOCN7P57+Q
	 bh0j01D83Qom4x7gPvWEd1E1OnRJh4J/iVDn18+FmSFVLzKB1BR/VXANh1Fm5Mc0F8MJB
	 VwYgksCfUczbeLawWU4QKdg0USWcumbw78zet/ztAwgReCIBFWegODvi48zkgjE6ExJwq
	 YirgKPnLAHRNGhrOm57WvaG4FlzufeymW14mxap8Q5b3j89FKzdkMXL+sSHwV9hiE7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193340;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=dWlboDYBd5BGl+p3WRU/hoNuEIs3lMzUvVPPx0RwBac=;
	b=sPpctbyNIw4jhoQRQRZU0/uUcYkrST7d3TTIbUxeVbLpVomfxVNEGHF+bBgwQ1gbGbVK
	 f4H8XaZmuLFpJN4cEPcRxKLfD+P+EBk5WwhOFhvt5Zm+JkNo8aHQiEfBxRvPxRl7CVTFP
	 TpyI9VCNyu20zLre6xorESpr55e6w/Q9peo6TEIy4HKUidnpLfd9XnlCcEeOKmaOFhW73
	 uhPJWx3w6URCY6P6ODxMEcQnS5tGV9i0/hB8rnwLAUqF4de+d2u/rxluKkmyNkdhdF6JU
	 OIhH05sc9Sn2BOihem6jieL40VBEb1REejwKEumiMabUyOAjesLCNydQEWE1TuGbKeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BLUp4lYO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D2606A330;
	Fri, 20 Nov 2026 16:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA9D2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BLUp4lYO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EEFB1575;
	Fri, 20 Nov 2026 08:48:50 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D22FB3F882;
	Fri, 20 Nov 2026 08:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795193333; bh=wE0tnPT5bhRkJ3p9KFR14+0FV3MqcU0Hq6gMMmUBPHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLUp4lYO5xM+mHKj+9mRsDBnlTM0X4YPScwuiUjDcgvaqV4OlDJQUIgd7+5xtyTJI
	 kdqcMXaofKElkdLmL/c1hVIMwzg1cBTo3LXReHLkjUqYuKleU5s9QQE62owlL6LQfk
	 hWmvZ4XkibssNAhaQIYwIkWoBhGc+yd7AYV1OuRY=
Date: Fri, 20 Nov 2026 16:48:44 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] mm: distinguish HW PTE pointers from SW PTE value
 pointers
Message-ID: <awB57BlYzicAJzqr@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <avtAQCkvRr1xkxMF@arm.com>
 <959a843d-f579-4aa7-8299-c6e9c5d03812@arm.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <959a843d-f579-4aa7-8299-c6e9c5d03812@arm.com>

On Wed, Nov 18, 2026 at 09:41:41PM +0000, Muhammad Usama Anjum wrote:
> On 16/11/2026 5:41 pm, Catalin Marinas wrote:
> > On Tue, Sep 22, 2026 at 06:12:28PM +0100, Muhammad Usama Anjum wrote:
> >> PMD, PUD, P4D and PGD storage are deliberately out of scope. They can be
> >> converted in later series after the PTE boundary is agreed, avoiding the
> >> PMD-specific cases that made an all-level conversion difficult to
> >> review.

[...]

> > First, I'd like to see all such on-stack p*d pointers addressed as a
> > prerequisite (e.g. fix pmd_populate() in __split_huge_zero_page_pmd()).
> > If for some reason we deem pmd not fixable, I don't like half (or
> > quarter) baked solutions just addressing the pte.
> 
> Only pmd pointers conversions may require careful review and some discussion.
> Other remaining p*d would be straight forward again. I think if I convert
> everything, we'll have 30-35 patches for generic side only. It would a little
> time consuming to rebase that again and again.
> 
> I think, a simpler plan can be to post the pmd pointer conversion series
> as well  in the open to get better acceptance of this overall effort.

I didn't ask for the full pmdp conversion but only to see if we can
remove the on-stack uses first. At a quick grep, there are only a few:
pmd_populate() on a local pmd_t in __split_huge_zero_page_pmd(),
__split_huge_pmd_locked() and vmemmap_split_pmd().

> > Second, we could add a run-time page table check, at least for pmd/pte.
> > Something like below, gated by CONFIG_PAGE_TABLE_CHECK or
> > CONFIG_DEBUG_VM (untested and not entirely sure about using
> > PageTable()):
> > 
> > static inline void pgtable_ptr_check(struct mm_struct *mm, const void *p)
> > {
> > 	if (object_is_on_stack(p)) {
> > 		WARN_ON_ONCE(1);
> > 		return;
> > 	}
> > 	if (mm != &init_mm && virt_addr_valid(p))
> > 		WARN_ON_ONCE(!PageTable(virt_to_page(p)));
> > }
> 
> s390 already has CONFIG_STRICT_MM_TYPECHECKS, but that only provides type
> checking for page-table values. It cannot distinguish a pointer to
> page-table storage from a pointer to a copied value. Consequently, direct
> dereferences still appear in generic code and can bypass s390’s
> architecture-specific handling. They have been trying to fix [1] differently.
> 
> RISC-V has independently encountered the same problem. Some RISC-V
> platforms must transform page-table entries whenever they are read from
> or written to hardware page tables, so generic code must consistently
> use the architecture accessors. They were trying to fix it [2].

I thought these were about direct dereference of the pointer to pte. We
could use some sparse annotations like __ptent (already proposed). The
run-time check is about valid pointer accesses but when the PTE is on
stack.

> > You already have some coccinelle patches to make the conversion. Could
> > we turn them into a coccicheck to detect new uses? With LLM reviews like
> > Sashiko, we can probably catch new uses violating the requirement (we
> > need to document it).
> 
> Coccinelle can identify common syntax, but cannot reliably distinguish the     
> meaning of two pointers when both are pte_t *.

No, that's what we'd use a runtime check for. The incomplete types probably
help, though you can't fully prevent explicit casting.

> > LLMs and coccicheck won't catch all abuses nor does this series prevent
> > one from declaring hw_pte_t on the stack.
> 
> By using Coccinelle and LLMs we can still get regressions which arch-es
> have been doing over the year.
> 
> hw_pte_t * makes accidental violations compilation errors in every build.
> Deliberately declaring hw_pte_t on the stack remains possible, but is explicit
> and reviewable. (RFC of this series has info on why we aren't using opaque
> objects.)

I'm not sure what the conclusion was on opaque hw_pte_t. IIRC Lorenzo
also proposed a non-opaque type that Ryan agreed to some time ago. IIUC,
if we take that route, we'd need to go again through all type changes in
this series. On arm64, some of the functions proposed like hw_pte_val(),
__pte_from_hw() would need converting again.

IOW, I'm trying to understand the road to get there, like ptep_advance()
instead of ptep++ and so on. Once we are clear, maybe without a full
patchset, we can go ahead in steps but at the moment it's not clear to
me you won't post another conversion like this soon after.

Anyway, that's not my code, so if the mm folk are happy, please go ahead
with the generic series. I may wait enabling it on arm64 until the
opaque pte type discussion is settled.

> > Once the above are in place, I'd look again at these patches and see
> > whether they improve code clarity and are worth the churn.
> > 
> > Maybe an argument in favour of these patchsets is future dynamic support
> > for FEAT_D128, we'd need to separate the software representation of a
> > pte from the hardware one but we've done this before (arm32 non-LPAE has
> > different representations).
> 
> Yes, that's also the big motivation of this work. We don't want to depend on
> the config options to turn on/off features. Arch should be able to turn on/off
> code based on the cpu features.

It's a lot more work than the pte size here. PTRS_PER_* have different
values, ptep_advance() would be more dynamic. It's doable but it's a lot
more involved and I think the types are the least of our problems. I'm
also waiting to see how many CPUs implement D128 before committing to
supporting it upstream (it doesn't buy us much anyway).

Thanks.

-- 
Catalin
