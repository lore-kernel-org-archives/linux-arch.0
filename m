Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBA36C5B9
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2026 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043096; cv=none; b=NJcNDvqHVYb690tagKi389QtE4Vtod1D6cAMGI5EybVSdhuJl/E4FsCIrpyWMOcdC5rH2cPRxrCykQPmRIoJ5GM2IzYDvxYq9z3IMe7zrt+QV6aEZXYja9f1KFe1VUFdyXIslHWlUyg+odXnKVfAZfo/YIjpQcngHYODFhGVoIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043096; c=relaxed/simple;
	bh=EP4rPh+OJOsPFBs2ZsaC+NH+c7KI9VBuz89x+6oRA3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr/ELOYT1K2JcIpkXxA4nK+jNi7hOJ9Bs54QGxapmBz+2UUeS/pImM5zArvBwWjw0bKDB1BlLT1/uRXlyoeKWWafeAx7bhVgZUyP7KKyA04pfC0+A44UE2gXMvWi57cHett65aiBSmAEFVM4yFnrk/6+pN3sXxWLdmu1mWpZDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UgCRKXtO; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UgCRKXtO"
Message-ID: <540adec9-c483-460a-a682-f2076cf015c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770043082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YuikHIpXYtVLQeTjpDEpyPPM+rwsAsIsRE/N+8+UvM=;
	b=UgCRKXtOZlfN+/7cORPTlSVzR8UJHh7JqxgK0CfCBKekoSTHFgghh9HracXNSrSC3awjkU
	H+AQz66kUh63gKnKZVfMkiJJ+X9mVe1TcLsZJJK3NjU7aPXYAA3puXscll30N4PFjBYfdj
	QKaUx6BxL4dSPBiJMateUtbngiHNtnw=
Date: Mon, 2 Feb 2026 22:37:39 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, arnd@arndb.de, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, boris.ostrovsky@oracle.com, bp@alien8.de,
 dave.hansen@intel.com, dave.hansen@linux.intel.com, david@kernel.org,
 dev.jain@arm.com, hpa@zytor.com, hughd@google.com, ioworker0@gmail.com,
 jannh@google.com, jgross@suse.com, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mingo@redhat.com,
 npache@redhat.com, npiggin@gmail.com, pbonzini@redhat.com, riel@surriel.com,
 ryan.roberts@arm.com, seanjc@google.com, shy828301@gmail.com,
 tglx@linutronix.de, virtualization@lists.linux.dev, will@kernel.org,
 x86@kernel.org, ypodemsk@redhat.com, ziy@nvidia.com
References: <20260202095414.GE2995752@noisy.programming.kicks-ass.net>
 <20260202110329.74397-1-lance.yang@linux.dev>
 <20260202125030.GB1395266@noisy.programming.kicks-ass.net>
 <c6fda7c2-ad54-416a-a869-1499c97c7bd7@linux.dev>
 <4700e7ba-8456-4a93-9e28-7e5a3ca2a1be@linux.dev>
 <20260202133713.GF1395266@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260202133713.GF1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/2 21:37, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 09:07:10PM +0800, Lance Yang wrote:
> 
>>>> Right, but if we can use full RCU for PT_RECLAIM, why can't we do so
>>>> unconditionally and not add overhead?
>>>
>>> The sync (IPI) is mainly needed for unshare (e.g. hugetlb) and collapse
>>> (khugepaged) paths, regardless of whether table free uses RCU, IIUC.
>>
>> In addition: We need the sync when we modify page tables (e.g. unshare,
>> collapse), not only when we free them. RCU can defer freeing but does
>> not prevent lockless walkers from seeing concurrent in-place
>> modifications, so we need the IPI to synchronize with those walkers
>> first.
> 
> Currently PT_RECLAIM=y has no IPI; are you saying that is broken? If
> not, then why do we need this at all?

PT_RECLAIM=y does have IPI for unshare/collapse — those paths call
tlb_flush_unshared_tables() (for hugetlb unshare) and collapse_huge_page()
(in khugepaged collapse), which already send IPIs today (broadcast to all
CPUs via tlb_remove_table_sync_one()).

What PT_RECLAIM=y doesn't need IPI for is table freeing (
__tlb_remove_table_one() uses call_rcu() instead). But table modification
(unshare, collapse) still needs IPI to synchronize with lockless walkers,
regardless of PT_RECLAIM.

So PT_RECLAIM=y is not broken; it already has IPI where needed. This series
just makes those IPIs targeted instead of broadcast. Does that clarify?


Thanks,
Lance
