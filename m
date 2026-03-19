Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320F3CEB9D;
	Thu, 19 Mar 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922950; cv=none; b=UJRqkV430dLGYUNivGXwukZAuB7FlBLht5TJtaIrcH4p5exziDNyaGCb/T3UisOzhW6F65mykeW2C7THR5UurM/25Nd7ruCq0sU03Qwnq/4ftCBbtiFSt/by3It7VUi17NUdCspcuUGZ1/uCNG+y+Qla6Ki9X8hsLEFhRFGMc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922950; c=relaxed/simple;
	bh=ZFh/S3eQGA2GH4H+znW5KFOdXcZcl/q+CzpCIZxZ8/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pbuUc6U5L6f8HdfK/+oZQwbxDgSaFukl1i41lxJEg8CCb9ofhPDfRXt29u8TpYID2FjF1PI6Sg0EvCnVBdSVJhJtJV1EUP5cBxu033FXeWjouQ5pbOzRL1e5IpPBKFaJYRqtZvt94Wt8N8nfRtlAK/H9GF+jbRiCYG/nG6EJyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 513311A25;
	Thu, 19 Mar 2026 05:22:20 -0700 (PDT)
Received: from [10.57.85.34] (unknown [10.57.85.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6B7C3F778;
	Thu, 19 Mar 2026 05:22:21 -0700 (PDT)
Message-ID: <0d963ff9-9222-4e0f-8e57-ff22088ce978@arm.com>
Date: Thu, 19 Mar 2026 12:22:19 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vmalloc: add __GFP_SKIP_KASAN support
Content-Language: en-GB
To: Muhammad Usama Anjum <usama.anjum@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 david.hildenbrand@arm.com
References: <20260319114952.3241359-1-usama.anjum@arm.com>
 <20260319114952.3241359-2-usama.anjum@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260319114952.3241359-2-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/03/2026 11:49, Muhammad Usama Anjum wrote:
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
>  mm/vmalloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c607307c657a6..1baa602a0b9bb 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4041,7 +4041,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  	 * kasan_unpoison_vmalloc().
>  	 */
>  	if (pgprot_val(prot) == pgprot_val(PAGE_KERNEL)) {
> -		if (kasan_hw_tags_enabled()) {
> +		bool skip_kasan = kasan_hw_tags_enabled() &&
> +				  (gfp_mask & __GFP_SKIP_KASAN);
> +
> +		if (kasan_hw_tags_enabled() && !skip_kasan) {

It's unfortunate that kasan_hw_tags_enabled() is involved twice in this expression.

>  			/*
>  			 * Modify protection bits to allow tagging.
>  			 * This must be done before mapping.
> @@ -4057,7 +4060,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		}
>  
>  		/* Take note that the mapping is PAGE_KERNEL. */
> -		kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;
> +		if (!skip_kasan)
> +			kasan_flags |= KASAN_VMALLOC_PROT_NORMAL;

I wonder if it would be clearer to just not call kasan_unpoison_vmalloc() below
if the user passed in __GFP_SKIP_KASAN? It's really just an implementation
detail that kasan_unpoison_vmalloc() skips unpoisoning if
KASAN_VMALLOC_PROT_NORMAL is not provided.

Thanks,
Ryan


>  	}
>  
>  	/* Allocate physical pages and map them into vmalloc space. */

