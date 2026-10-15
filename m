Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7C47CA7C;
	Thu, 15 Oct 2026 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053217; cv=none; b=tPPCt7XmsXELkS+v7UapnEz3a7TNUS+XqGY88BK76fBN4Pvpe0SrlQ3ggzAkHYdCAJFQF7VYRwx45jqjZm4c702PInaKw8tXfnqvZemR1r/Q6iHvu0glM8+3c0h8DVMg7zldNbJxRSMA2E+5sMyjpOw6EBDzLYKcRYcp7gkg1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053217; c=relaxed/simple;
	bh=ji8b0TU9oVYNUhNlUuAHj/WAOvWYnf0gl0BElyTFqMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZffULj7kHaJVsJGRRmFGmv/Q548HEXfn8kBOzI1Y8b/cJ4Fsy6RVU+0zWYpQueEKW0yAofIsl87l6v6arYnM7ORmH6ZqmEPkmnbkmQIAlOSko5K698PnnLjmYG8sZ1/PG4khJAi6vIJZcoi7stcOJiSyOw43NEhr3nqFKA/dHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtjExpLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtjExpLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31CA1F000C5;
	Thu, 15 Oct 2026 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053215;
	bh=AOZJvgkf51bXSMCUGPR93r0N2Iu+EN4HtBMStIPgKjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtjExpLX+a8cuwlOqRz7cmtKMwlhGF6EnvQaF0p0x4Idxm7ijZzJ4N4aHzgnTwlwz
	 R8l5QkDwcjiwdCBHnSSRjTENCW08WR3l+IPSoc8tl1wAz2YK6UMjqe+xrJrJTVMzqJ
	 MF7tyXtn/OSw2I7X24p6aWSO9Oj/85pkVXRZJqnSDeQXfOMbOnbLe0GUhAOGM2sD2X
	 HekeupaPpNdH7XpRSKNDfJ7waPaTVh+8cokwHTARhRjZNQUO+kbrqC0b10qK3i0PHH
	 L89uERs+2aOpCbcvSSbRB28Xz57aSinboHKLUsW89VCRBBgh6LJp0SsTjzcNZ77czB
	 aZ5VuixK0k5AQ==
Date: Thu, 15 Oct 2026 11:33:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm: Generalize page table allocation helpers
Message-ID: <atCP1YszjrtrB30U@kernel.org>
References: <20261014035910.687847-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014035910.687847-1-songmuchun@bytedance.com>

On Wed, Oct 14, 2026 at 11:59:07AM +0800, Muchun Song wrote:
> A subsequent series will switch runtime vmemmap population to the
> generic page-table allocators. Since vmemmap tables belong to init_mm,
> the allocators must select GFP_PGTABLE_KERNEL and mark the ptdesc as a
> kernel page table.
> 
> Some architecture-specific allocators do not preserve both semantics.
> LoongArch and MIPS choose PMD/PUD GFP flags without checking the mm,
> which can charge kernel PMD tables to a memcg and leave user PUD tables
> unaccounted. The private PMD/PUD allocators also omit kernel ptdesc
> marking.
> 
> Rather than duplicate this handling in each architecture, extend the
> generic PTE, PMD and PUD allocators to support architecture
> initialization hooks and non-zero table orders. LoongArch, MIPS and
> parisc can then drop their private allocators and inherit the generic
> GFP selection and ptdesc handling.
> 
> This series only prepares the allocation interfaces; the runtime
> vmemmap conversion will be submitted separately.
> 
> Muchun Song (3):
>   mm: generalize kernel PTE table allocation
>   mm: generalize PMD page table allocation
>   mm: generalize PUD page table allocation

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  arch/loongarch/include/asm/pgalloc.h | 48 ----------------------------
>  arch/mips/include/asm/pgalloc.h      | 40 -----------------------
>  arch/parisc/include/asm/pgalloc.h    | 17 ----------
>  include/asm-generic/pgalloc.h        | 29 ++++++++++++++---
>  4 files changed, 24 insertions(+), 110 deletions(-)
> 
> 
> base-commit: ad9f2d463666c64e94b04be5263c9bf8f9f96fb7
> -- 
> 2.54.0
> 

-- 
Sincerely yours,
Mike.
