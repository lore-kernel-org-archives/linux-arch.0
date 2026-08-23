Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CE19D89E;
	Sun, 23 Aug 2026 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787467859; cv=none; b=Vw2MmAmjWUij4oSEn8oBV0jrUVP8Uy/q2BCcJ5rFVOO8SzRXNbC8/dXIL7bMgYA7G1Xg9pNfZsFApebfj/DGPRXMPiTVi8fna/3mxEl7cdUh/do5tp2G7F5h6AwlSFAjBjr5VWVadyFM/i4fHcHiBnIV38T3qiGgd+lzy8iY08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787467859; c=relaxed/simple;
	bh=TslVbMW9jZ5tKD3X6iairoSmpKRQdDNsCo9hQG9SNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqoEGX9/0Hk9IYidRvUPlaWDtqDxvEanVD4esSe1Jm9C5VYeP9eBd3pqFuy5kkZNotH1/PjHAvKCsVtrDS0tGZW0L216nRpxx8DZ99g7X/DS/Rhcn7xDkFNL5u+vykI/iluVv23Z/X0rnVeE1QQl9X5i/YqoGNkRRSxrmvj/t/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPSFldhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPSFldhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E531F000E9;
	Sun, 23 Aug 2026 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787467857;
	bh=PxHus4vSfS5CQqnKuDATVr2Sh5vCyrMBO6sWrbzlMGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lPSFldhZWKsCQ8AGQqYAuquWRS9TzZqMwiUcVMs+0BySD3vagvlLEkEJCg93UdPyW
	 N+ICTFk+RFOsP4Dhox9+lwUmTkWOQe/wtA6WvXU4nyW0SvEXOUih7VIQfhIHmVmuc2
	 LSfNxqY7WQXEWTzVkOPVXMbgwruz/9uGE0axKAqNWgvEv4GphVR4bN9Z8bkea0Zu9x
	 GcsHbfF7d08egVV10MRPheMou2fqf0ILLKn8JL5dmWNvN8J38/2rgZE+XskopkA3Pu
	 SVFWVACMBBmB3CwY0NMt/L23BDtqm89EMJ/WgTHH+4bqcDFKvhrJ0kY75HIN6u4q2t
	 An1hwJnQWYPwg==
Date: Sun, 23 Aug 2026 09:50:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Drop pxd_ERROR()
Message-ID: <aoqYS9eFTPqtgFMn@kernel.org>
References: <20260806080639.1916749-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806080639.1916749-1-anshuman.khandual@arm.com>

On Thu, Aug 06, 2026 at 01:36:39PM +0530, Anshuman Khandual wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
> 
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.
> 
> Although some platforms still use those macros internally as well. In which
> case just move these macros inside the platform for now.
> 
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v7.2-rc6 but after the following patch
> 
> https://lore.kernel.org/all/20260709044334.1741263-1-anshuman.khandual@arm.com/
> 
> Would it also make sense to just drop __FILE__ and __LINE__ from the output
> in pxd_clear_bad() helpers as they always print the same details regardless
> the error path and does not add much value.

Maybe replace them with the caller address?
 
> Build tested for various architectures.
> 
>  arch/alpha/include/asm/pgtable.h              |  7 ----
>  arch/arc/include/asm/pgtable-levels.h         | 11 -----
>  arch/arm/include/asm/pgtable.h                |  7 ----
>  arch/arm/kernel/traps.c                       | 17 --------
>  arch/arm64/include/asm/pgtable.h              | 15 -------
>  arch/csky/include/asm/pgtable.h               |  4 --
>  arch/hexagon/include/asm/pgtable.h            |  3 --
>  arch/loongarch/include/asm/pgtable.h          | 10 -----
>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
>  arch/microblaze/include/asm/pgtable.h         |  7 ----
>  arch/mips/include/asm/pgtable-32.h            | 10 -----
>  arch/mips/include/asm/pgtable-64.h            | 13 ------
>  arch/nios2/include/asm/pgtable.h              |  7 ----
>  arch/openrisc/include/asm/pgtable.h           |  7 ----
>  arch/parisc/include/asm/pgtable.h             |  3 +-
>  arch/powerpc/include/asm/book3s/32/pgtable.h  |  2 -
>  arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 ----
>  arch/powerpc/include/asm/nohash/32/pgtable.h  |  2 -
>  .../include/asm/nohash/64/pgtable-4k.h        |  3 --
>  arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 ---
>  arch/riscv/include/asm/pgtable-64.h           |  9 ----
>  arch/riscv/include/asm/pgtable.h              |  4 --
>  arch/s390/include/asm/pgtable.h               | 11 -----
>  arch/sh/include/asm/pgtable-3level.h          |  6 +++
>  arch/sparc/include/asm/pgtable_32.h           |  3 --
>  arch/sparc/include/asm/pgtable_64.h           | 10 -----
>  arch/um/include/asm/pgtable-2level.h          |  7 ----
>  arch/um/include/asm/pgtable-4level.h          | 13 ------
>  arch/x86/include/asm/pgtable-2level.h         |  5 ---
>  arch/x86/include/asm/pgtable-3level.h         | 11 -----
>  arch/x86/include/asm/pgtable_64.h             | 18 --------
>  arch/xtensa/include/asm/pgtable.h             |  4 --
>  include/asm-generic/pgtable-nop4d.h           |  1 -
>  include/asm-generic/pgtable-nopmd.h           |  1 -
>  include/asm-generic/pgtable-nopud.h           |  1 -
>  include/linux/mm_types.h                      | 40 ++++++++++++++++++
>  mm/memory.c                                   | 41 +------------------
>  mm/pgtable-generic.c                          | 21 ++++++++--
>  40 files changed, 65 insertions(+), 302 deletions(-)

This is nice :)
 
> diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> index 467b8547ac8b..cca30bf11b4c 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -75,12 +75,11 @@ extern void __update_cache(pte_t pte);
>  
>  #endif /* !__ASSEMBLER__ */
>  
> -#define pte_ERROR(e) \
> -	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
>  #if CONFIG_PGTABLE_LEVELS == 3
>  #define pmd_ERROR(e) \
>  	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, (unsigned long)pmd_val(e))
>  #endif
> +

Stray whitespace change?

>  #define pgd_ERROR(e) \
>  	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, (unsigned long)pgd_val(e))
>  
> diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
> index d1ce73f3bd85..3cfbec15de2f 100644
> --- a/arch/sh/include/asm/pgtable-3level.h
> +++ b/arch/sh/include/asm/pgtable-3level.h
> @@ -28,6 +28,12 @@
>  #define pmd_ERROR(e) \
>  	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
>  
> +#define pud_ERROR(e) \
> +	printk("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
> +
> +#define p4d_ERROR(e) \
> +	printk("%s:%d: bad p4d %016llx.\n", __FILE__, __LINE__, p4d_val(e))
> +

I'd expect that all arch changes would only remove code. Why sh needs
those?

>  typedef union {
>  	struct {
>  		unsigned long pmd_low;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..1025b9140c0b 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2001,4 +2001,44 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
> +static inline void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)

include/linux/pgtable.h seems more natural home for this

> +{
> +	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
> +		snprintf(buf, buf_size, "overflow");
> +		return;
> +	}

-- 
Sincerely yours,
Mike.
