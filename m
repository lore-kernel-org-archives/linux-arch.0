Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2C3E3D9E;
	Fri, 10 Apr 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844632; cv=none; b=C6iQpJDSEO8+wwFfZR3haThmJAsg44W9UqnyGMwDC6GWEyb05Uq2A/DzY+axEjrefbFfO29kGkc8NP1/JP2mja9op8G4DXyBl+EpAMwEsLOPvnPDR9QJcgwbFPj0C/ywOEcrk59NUB7r0/cfhtuWyRxkpkurofdWeHPv/ngjgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844632; c=relaxed/simple;
	bh=+Xbj23Mi6qAaExaiR0u97sstQzaeHen25NLGeWwaLoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZIld+DmdUzeFtOGH9o3CE8YRp1/Y/tw+XSYchkAkOctVYKfHlpOEBco3tEaF5zmRHJGE2psWHT/bPZoSykhYOpEHFFn3+Y4Cw/AbXrT8y4nGAf4/OOQ1FjX19csGMlC6Ql/ynPYbE7Ii6Lv9qGw4MfxJCOQKOlnZuxSNUSjohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nuw8MoyM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nuw8MoyM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06FC347E0;
	Fri, 10 Apr 2026 11:10:23 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F203F632;
	Fri, 10 Apr 2026 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775844628; bh=+Xbj23Mi6qAaExaiR0u97sstQzaeHen25NLGeWwaLoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuw8MoyM8SAW6vRkNF6p3aAK211yehk3V3tPN2NP5D36DfkVdOl+OZT5ogkGLDIQE
	 USK4yLGGYX428oeGpi2j7Bh/lvd5jFP3A9ZKj1kIcfkWqjjfLFwpXmyrXZORrwBp4n
	 Ax9kj27V5KCovEAIVO5YSw09ax1F9edXQrUs1OcA=
Date: Fri, 10 Apr 2026 19:10:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Peter Collingbourne <pcc@google.com>, Will Deacon <will@kernel.org>,
	Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH v2 1/3] vmalloc: add __GFP_SKIP_KASAN support
Message-ID: <adk9DjVvKDDAH2Pt@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-2-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324132631.482520-2-usama.anjum@arm.com>

On Tue, Mar 24, 2026 at 01:26:27PM +0000, Muhammad Usama Anjum wrote:
> For allocations that will be accessed only with match-all pointers
> (e.g., kernel stacks), setting tags is wasted work. If the caller
> already set __GFP_SKIP_KASAN, don’t skip zeroing the pages and
> don’t set KASAN_VMALLOC_PROT_NORMAL so kasan_unpoison_vmalloc()
> returns early without tagging.
> 
> Before this patch, __GFP_SKIP_KASAN wasn't being used with vmalloc
> APIs. So it wasn't being checked. Now its being checked and acted
> upon. Other KASAN modes are unchanged because __GFP_SKIP_KASAN isn't
> defined there.
> 
> This is a preparatory patch for optimizing kernel stack allocations.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since v1:
> - Simplify skip conditions based on the fact that __GFP_SKIP_KASAN
>   is zero in non-hw-tags mode.
> - Add __GFP_SKIP_KASAN to GFP_VMALLOC_SUPPORTED list of flags
> ---
>  mm/vmalloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c607307c657a6..69ae205effb46 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3939,7 +3939,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				__GFP_NOFAIL | __GFP_ZERO |\
>  				__GFP_NORETRY | __GFP_RETRY_MAYFAIL |\
>  				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
> -				GFP_USER | __GFP_NOLOCKDEP)
> +				GFP_USER | __GFP_NOLOCKDEP | __GFP_SKIP_KASAN)
>  
>  static gfp_t vmalloc_fix_flags(gfp_t flags)
>  {
> @@ -3980,6 +3980,8 @@ static gfp_t vmalloc_fix_flags(gfp_t flags)
>   *
>   * %__GFP_NOWARN can be used to suppress failure messages.
>   *
> + * %__GFP_SKIP_KASAN can be used to skip poisoning
> + *
>   * Can not be called from interrupt nor NMI contexts.
>   * Return: the address of the area or %NULL on failure
>   */
> @@ -4041,7 +4043,9 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	 * kasan_unpoison_vmalloc().
>  	 */
>  	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
> -		if (kasan_hw_tags_enabled()) {
> +		bool skip_kasan = gfp_mask & __GFP_SKIP_KASAN;
> +
> +		if (kasan_hw_tags_enabled() && !skip_kasan) {
>  			/*
>  			 * Modify protection bits to allow tagging.
>  			 * This must be done before mapping.
> @@ -4057,7 +4061,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		}
>  
>  		/* Take note that the mapping is PAGE_KERNEL. */
> -		kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
> +		if (!skip_kasan)
> +			kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
>  	}

In the cover letter, you said that __GFP_SKIP_KASAN is only meant for
KASAN_HW_TAGS. IIUC, here you skip passing KASAN_VMALLOC_PROT_NORMAL
even for KASAN_SW_TAGS. The flag is used in mm/kasan/shadow.c.

-- 
Catalin
