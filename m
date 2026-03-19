Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5C3CE4B3;
	Thu, 19 Mar 2026 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922183; cv=none; b=RF81nwqdGBUaA8EzbTSJOuLXtoF2oTWyJNBjKeAIlRHLTDCQS+WmUh0piWfz2VaScuc5Mj7Cec40kEXlofYIbs2aBGFzCXer7IR72KyJxpZEbZLqSG6ubHtHjufIKg6sveiU9yDPz7fK6GaJGWXA30qD2B6VF8pQ6iYXi7pPQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922183; c=relaxed/simple;
	bh=k2dB5HIm5ItXNSr9gTL1HS7FFDQBtj2HEtz4zT5K73E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y/6FmF7BM2NV9uunud7H+hmheGCTDhfYoT0Ke8JsIJTkpgnpUOnSyR0PivJhLvbJoBI/2CSxHosZYeaL4Xa/Z1wBoUQi/4ctjo7qbBcMg585zcdLzZueyJdNyZ1RgcQ8GekkTar/zh3hLwfEoDRCdIi7+sGFY/tGeM9PHKXQieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 431231BD0;
	Thu, 19 Mar 2026 05:09:34 -0700 (PDT)
Received: from [10.57.85.34] (unknown [10.57.85.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 648373F778;
	Thu, 19 Mar 2026 05:09:36 -0700 (PDT)
Message-ID: <75705c3d-2654-47cf-8fd3-8343136715fa@arm.com>
Date: Thu, 19 Mar 2026 12:09:34 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: SKIP KASAN for page table allocations
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
 <20260319114952.3241359-4-usama.anjum@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260319114952.3241359-4-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2026 11:49, Muhammad Usama Anjum wrote:
> Page tables are always accessed via __va(phys) / phys_to_virt(phys).
> With a match-all tag in the pointer, MTE never checks memory tags on
> access. Therefore: KASAN HW tags are set during page table allocation
> but never checked during use. KASAN poisoning on free provides no
> value for these pages as well. Its pure overhead - both at allocation
> time and free time. Hence, skip the tag setting for all page tables.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/asm-generic/pgalloc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 57137d3ac1592..051aa1331051c 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -4,7 +4,7 @@
>  
>  #ifdef CONFIG_MMU
>  
> -#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
> +#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
>  
>  /**

