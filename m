Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF73DEACF;
	Fri, 10 Apr 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845951; cv=none; b=ZrHikoVmfhHc/eiyl43aU1SF+p5Aum2fjzPuiv1QxrAy2lhmidWV+sFZsmvhrHqseGvymfehhrIftUn+abyjTetwd5Jt8yYfz9yNC1gg3q3mu+mmbGL1MXDTRlrsKNUBPXtPDr9ANkJCoCe41JrCzIMJ2/ZuFIoEP4USK6JdfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845951; c=relaxed/simple;
	bh=XTlqRNuX63T/Wl+K3E/fotcVmu5Bv4KRS6GdSpRLcpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCOzAMWZlV7/jq3IGTOMXbyYcTT9kFn4Gg2KmRWk70qqBXldqGfAfL8bLPwiQEKq//m8TlrHQW9w3S/oTpPpmy2G+bkxAaccY1mVeFYCoWQGe8NatfrdEXBQhAZnhfaxQeJeVuBgyQN4TQldrTaDdQQ2v2afiSZ6GS0o1bXm6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Eg0PP0U/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Eg0PP0U/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B34947E0;
	Fri, 10 Apr 2026 11:32:23 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A333F632;
	Fri, 10 Apr 2026 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775845949; bh=XTlqRNuX63T/Wl+K3E/fotcVmu5Bv4KRS6GdSpRLcpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eg0PP0U/d9YZzUK9BfPwvahjOXD1+EK5WUggR92hUZdL20gBVsKbHtaG4wjFG0NmP
	 2NaF2YR653D//8Qagy8FKHHXyNGGknziylIor62RdmVP9YhZyaxbX+DOqPJ1cICiks
	 GC4s4+mRhC+CKMQ1wvL8yBksP3ezBBYxG396UHVc=
Date: Fri, 10 Apr 2026 19:32:23 +0100
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
Subject: Re: [PATCH v2 2/3] kasan: skip HW tagging for all kernel thread
 stacks
Message-ID: <adlCN9sUcQdWbf_i@arm.com>
References: <20260324132631.482520-1-usama.anjum@arm.com>
 <20260324132631.482520-3-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324132631.482520-3-usama.anjum@arm.com>

On Tue, Mar 24, 2026 at 01:26:28PM +0000, Muhammad Usama Anjum wrote:
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 051e429026904..307b8390fc670 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -92,7 +92,7 @@ static inline long set_restart_fn(struct restart_block *restart,
>  #define THREAD_ALIGN	THREAD_SIZE
>  #endif
>  
> -#define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO)
> +#define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_SKIP_KASAN)
>  
>  /*
>   * flag set/clear/test wrappers
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bb0c2613a5604..4bc7a03662109 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -207,7 +207,7 @@ static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
>   * accounting is performed by the code assigning/releasing stacks to tasks.
>   * We need a zeroed memory without __GFP_ACCOUNT.
>   */
> -#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO)
> +#define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
>  
>  struct vm_stack {
>  	struct rcu_head rcu;
> @@ -345,7 +345,8 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		}
>  
>  		/* Reset stack metadata. */
> -		kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
> +		if (!kasan_hw_tags_enabled())
> +			kasan_unpoison_range(vm_area->addr, THREAD_SIZE);
>  
>  		stack = kasan_reset_tag(vm_area->addr);

I wonder, since with kasan_reset_tag() returns a match-all pointer even
with KASAN_SW_TAGS, is it worth unpoisoning the range (unless it somehow
interferes with vfree() but I couldn't see how).

What the original approach might help with is use-after-realloc in case
we had a tagged pointer in a past life of a page and it still works now.
Oh well, that's I guess for other types of hardening to address like
delayed reallocation.

-- 
Catalin
