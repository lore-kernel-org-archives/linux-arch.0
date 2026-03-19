Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30C3CE48A;
	Thu, 19 Mar 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922149; cv=none; b=euszN183nJOgnMzDrYmHv2kDdGq4c02Wy+n1pqjKbifA2HXZgZ/sqTQHg4s3S1BrQSuGYYLmTBptR2rYWXLPQTrg9PbUfmtXugvLS6atS5fQEXI2S+vMJOWw81nijJUkFCGFSkDvXY0OO79jvnbgQU7jektkH00MmsKOb07jDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922149; c=relaxed/simple;
	bh=TW5IgCCp8VHyytIuxKqF/1+2MrXUjyG2pTHEJSqB2Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KxU3bFtaHCh95EN9/+jRRdX8s4oSDdhqRW3m1KQ5hrw59ouSt+FqLwNJAeXMt2U4nhUM3GB/Sq/q67LH4xO+AXM7NkHEWPYCYkI+faZEPpLC6HhaTyQ2v9M01TBAAIjI7OnJrSGIR2Mj/VsPB6da54QEue5fOQVZhKgzgBTM77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA7B91A25;
	Thu, 19 Mar 2026 05:09:00 -0700 (PDT)
Received: from [10.57.85.34] (unknown [10.57.85.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185B93F778;
	Thu, 19 Mar 2026 05:09:02 -0700 (PDT)
Message-ID: <dc85cda7-cf66-4bfa-92ab-af23f550562a@arm.com>
Date: Thu, 19 Mar 2026 12:09:01 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fork: skip MTE tagging for kernel stacks
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
 <20260319114952.3241359-3-usama.anjum@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260319114952.3241359-3-usama.anjum@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2026 11:49, Muhammad Usama Anjum wrote:
> The stack pointer always uses the match-all tag, so MTE never checks
> tags on stack accesses. Tagging stack memory on every thread creation
> is pure overhead.
> 
> - Pass __GFP_SKIP_KASAN in gfp_mask for vmalloc-backed stacks so the
>   vmalloc path skips HW tag setup (see previous patch).
> - For the cached VMAP reuse path, skip kasan_unpoison_range() when HW
>   tags are enabled since the memory will only be accessed through the
>   match-all tagged SP.
> - For the normal page allocator path, pass __GFP_SKIP_KASAN directly
>   to the page allocator.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
>  kernel/fork.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bb0c2613a5604..2baf4db39b5a4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -345,7 +345,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		}
>  
>  		/* Reset stack metadata. */
> -		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
> +		if (!kasan_hw_tags_enabled())
> +			kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
>  
>  		stack = kasan_reset_tag(vm_area->addr);
>  
> @@ -358,7 +359,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>  	}
>  
>  	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
> -				     GFP_VMAP_STACK,
> +				     GFP_VMAP_STACK | __GFP_SKIP_KASAN,

Perhaps cleaner to include __GFP_SKIP_KASAN in GFP_VMAP_STACK ?

>  				     node, __builtin_return_address(0));
>  	if (!stack)
>  		return -ENOMEM;
> @@ -410,7 +411,8 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
>  
>  static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>  {
> -	struct page *page = alloc_pages_node(node, THREADINFO_GFP,
> +	struct page *page = alloc_pages_node(node,
> +					     THREADINFO_GFP | __GFP_SKIP_KASAN,

I think there are some other places that could benefit from __GFP_SKIP_KASAN;
see arm64's arch_alloc_vmap_stack(), which allocates stacks for efi, irq and
sdei. I think these are allocated at boot, so not really performance sensitive,
but we might as well be consistent?

You've also missed the alloc_thread_stack_node() implementation for !VMAP when
PAGE_SIZE > STACK_SIZE.

All of these sites use THREADINFO_GFP so perhaps it is better to just define
THREADINFO_GFP to include __GFP_SKIP_KASAN ?

Thanks,
Ryan


>  					     THREAD_SIZE_ORDER);
>  
>  	if (likely(page)) {

