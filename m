Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A35477E;
	Fri, 24 Apr 2026 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777007035; cv=none; b=Cy4/3zKqoC/CuSwl6gHNopQOutc8UUnNG9J96xmkcingjrsRRK8Vc8jR8uwCcu9fa+YAhMppELRbQ0YpAAD+jfZYqpduI5O87Mp4kn1wZ6h0ZSPq6OE5fd6ziXldExLnxnZcImkT4ijWrt9MJQnsFcDRVNo72Owm1OPBVJ8Hrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777007035; c=relaxed/simple;
	bh=awHC7Ghsok5G40mNYDQmGxMPSQCdBf9nVUvG1OcuYEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNDDiR1CJyb4GK+Dw/Sp55e6aMWallB5DRSA4H4bTqrE5OgJZsu6uxrOb3RLYyTuwrX+i2KjRhzXcHRKiYH+qAY/rlUavVaqIq5ks6wDP46CTaHAXam4o+zfGJ/yZapFWVkC3JwJxkEOkbOmX1K4ErG9yax3PqCP1365NCFh8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k6w7+Mgc; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k6w7+Mgc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777007031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF/14iOG/TKWQJ1iA5emqkLbN1JUZtyc7urLxXkKtYs=;
	b=k6w7+MgcqYIlU+lFz2OOnnJETtGqStoZm15MrlwZJlFr80pOyWH6gZ6d2zM2guk98Kx4hw
	tXCLb6gF/s7OF6Yz18Pc0TSuybZ8lAg9MR+ILu0Icc1wm4wkNrZjQ12wjGjJGxTsyLLXJc
	mGIvQmB9tRHJGZ2PRed7SjpDnA1qOfM=
From: Lance Yang <lance.yang@linux.dev>
To: dave.hansen@intel.com
Cc: lance.yang@linux.dev,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	david@kernel.org,
	dave.hansen@linux.intel.com,
	ypodemsk@redhat.com,
	hughd@google.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shy828301@gmail.com,
	riel@surriel.com,
	jannh@google.com,
	jgross@suse.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	boris.ostrovsky@oracle.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ioworker0@gmail.com
Subject: Re: [PATCH 7.2 v9 2/2] x86/tlb: skip redundant sync IPIs for native TLB flush
Date: Fri, 24 Apr 2026 13:03:29 +0800
Message-Id: <20260424050329.96623-1-lance.yang@linux.dev>
In-Reply-To: <f856051b-10c7-4d65-9dbe-6b1677af74bd@intel.com>
References: <f856051b-10c7-4d65-9dbe-6b1677af74bd@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Dave,

On Thu, Apr 23, 2026 at 10:56:03AM -0700, Dave Hansen wrote:
[...]
>On 4/19/26 20:08, Lance Yang wrote:
>> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
>> +	/*
>> +	 * Treat unshared_tables just like freed_tables, such that lazy-TLB
>> +	 * CPUs also receive IPIs during unsharing of page tables, allowing
>> +	 * us to safely implement tlb_table_flush_implies_ipi_broadcast().
>> +	 */
>> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
>> +			   tlb->freed_tables || tlb->unshared_tables);
>>  }
>
>I've been staring at this trying to make sense of it for too long.
>
>Right now, flush_tlb_mm_range() literally has an argument named
>"freed_tables" and "tlb->freed_tables" is passed there. That seems
>totally sane. It's 100% straightforward to follow.
>
>But it makes zero logical sense to me to now mix "tlb->unshared_tables"
>in there. Sure, what you _want_ is the freed_tables==1 behavior from
>tlb->unshared_tables==1, and this obviously hacks that in there, but
>it's not explained well enough and not maintainable like this. IOW, it's
>still just hack.
>
>I think what's happened here is that info->freed_tables is being
>modified from being strictly related to page table freeing, and moved
>over to a bit which tells TLB flushing implementations whether they can
>respect CPUs in lazy TLB mode.
>
>It's mentioned in the comment, but then ever reflected into the code.
>
>Shouldn't we be doing something like the attached patch? Look at how
>that maps over to the flushing side, like in the hyperv code:

Cool, thanks!

I was trying to keep the change small by passing unshared_tables through
the exsiting freed_tables argument, but that made the code a bit harder
to follow ...

>
>> -       bool do_lazy = !info->freed_tables;
>> +       bool do_lazy = !info->wake_lazy_cpus;
>>  
>>         trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>>  
>> @@ -198,7 +198,7 @@ static u64 hyperv_flush_tlb_others_ex(co
>>  
>>         flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>>         nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
>> -                       info->freed_tables ? NULL : cpu_is_lazy);
>> +                       info->wake_lazy_cpus ? NULL : cpu_is_lazy);
>
>That even makes the hyperv code easier to read over what was there
>before, IMNHO.
>
>Thoughts?
[...]

Yeah, renaming the flush_tlb_info bit to wake_lazy_cpus reads much
better. Will fold this into v10, Thanks for spelling it out!

Lance
