Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8F726B2AD
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047570; cv=none; b=VVklyg/bPo8A56lq17LU2P1IxV0mLUlfPKgC8U+6eRRrSQtDt2FxeYZksX9ONrPDk2l+4E29Fuw8vuN51kcsJY9QLtKdHWJSh+1GJYzcuWJkwD/xG3Ntcnz2djmorIgMSWb1I1kiu8r4cMcKHKt6GDs3tHrQq8jlpdqWl7cVrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047570; c=relaxed/simple;
	bh=+2Jc+VhLkXt3QqoavVsTTpgtI4ILB8bGtNf8GUb/dGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKl5+RX47P2UAZ1IigTr0/vPSb5hLsJS5qy8ClJgX8gUmlVH2g1gr77O88WMt2nSBK9qKXebVsdOj6TYnJHLWDB7sW6Unz6v8O0xyGGRC9ov8MVj+ZKWiSCQMB2Bp5e2+jVJEIENGYlf8gU94wCXpbG5PmExBPsJzAKzitseDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LHO+UJ4a; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LHO+UJ4a"
Message-ID: <d6944cd8-d3b7-4b16-ab52-a61e7dc2221c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770047565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PduxyDODlH9YHL0rneveZmMdter31WXHAeGzrsiCre4=;
	b=LHO+UJ4aR+t9zhuFaEeNktv85tisbUgqgGP+452qgxwu8pe3VAbJyWwRwIMkIkhrW3CiiU
	amX509lg1rXTP7Wtltg3TnQsfApgqjp0Blp35vsPn2YE5n3hsGAPY5Q6ckZZXKljWJkLo7
	a+vSwZ8/xCaiyucTyGL4QbFRUgmLY+s=
Date: Mon, 2 Feb 2026 23:52:31 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, david@kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, arnd@arndb.de, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, boris.ostrovsky@oracle.com, bp@alien8.de,
 dave.hansen@intel.com, dave.hansen@linux.intel.com, dev.jain@arm.com,
 hpa@zytor.com, hughd@google.com, ioworker0@gmail.com, jannh@google.com,
 jgross@suse.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mingo@redhat.com, npache@redhat.com,
 npiggin@gmail.com, pbonzini@redhat.com, riel@surriel.com,
 ryan.roberts@arm.com, seanjc@google.com, shy828301@gmail.com,
 tglx@linutronix.de, virtualization@lists.linux.dev, will@kernel.org,
 x86@kernel.org, ypodemsk@redhat.com, ziy@nvidia.com
References: <20260202095414.GE2995752@noisy.programming.kicks-ass.net>
 <20260202110329.74397-1-lance.yang@linux.dev>
 <20260202125030.GB1395266@noisy.programming.kicks-ass.net>
 <c6fda7c2-ad54-416a-a869-1499c97c7bd7@linux.dev>
 <4700e7ba-8456-4a93-9e28-7e5a3ca2a1be@linux.dev>
 <20260202133713.GF1395266@noisy.programming.kicks-ass.net>
 <540adec9-c483-460a-a682-f2076cf015c2@linux.dev>
 <20260202150957.GD1282955@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260202150957.GD1282955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/2 23:09, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 10:37:39PM +0800, Lance Yang wrote:
>>
>>
>> On 2026/2/2 21:37, Peter Zijlstra wrote:
>>> On Mon, Feb 02, 2026 at 09:07:10PM +0800, Lance Yang wrote:
>>>
>>>>>> Right, but if we can use full RCU for PT_RECLAIM, why can't we do so
>>>>>> unconditionally and not add overhead?
>>>>>
>>>>> The sync (IPI) is mainly needed for unshare (e.g. hugetlb) and collapse
>>>>> (khugepaged) paths, regardless of whether table free uses RCU, IIUC.
>>>>
>>>> In addition: We need the sync when we modify page tables (e.g. unshare,
>>>> collapse), not only when we free them. RCU can defer freeing but does
>>>> not prevent lockless walkers from seeing concurrent in-place
>>>> modifications, so we need the IPI to synchronize with those walkers
>>>> first.
>>>
>>> Currently PT_RECLAIM=y has no IPI; are you saying that is broken? If
>>> not, then why do we need this at all?
>>
>> PT_RECLAIM=y does have IPI for unshare/collapse — those paths call
>> tlb_flush_unshared_tables() (for hugetlb unshare) and collapse_huge_page()
>> (in khugepaged collapse), which already send IPIs today (broadcast to all
>> CPUs via tlb_remove_table_sync_one()).
>>
>> What PT_RECLAIM=y doesn't need IPI for is table freeing (
>> __tlb_remove_table_one() uses call_rcu() instead). But table modification
>> (unshare, collapse) still needs IPI to synchronize with lockless walkers,
>> regardless of PT_RECLAIM.
>>
>> So PT_RECLAIM=y is not broken; it already has IPI where needed. This series
>> just makes those IPIs targeted instead of broadcast. Does that clarify?
> 
> Oh bah, reading is hard. I had missed they had more table_sync_one() calls,
> rather than remove_table_one().
> 
> So you *can* replace table_sync_one() with rcu_sync(), that will provide
> the same guarantees. Its just a 'little' bit slower on the update side,
> but does not incur the read side cost.

Yep, we could replace the IPI with synchronize_rcu() on the sync side:

- Currently: TLB flush → send IPI → wait for walkers to finish
- With synchronize_rcu(): TLB flush → synchronize_rcu() -> waits for 
grace period

Lockless walkers (e.g. GUP-fast) use local_irq_disable(); 
synchronize_rcu() also
waits for regions with preemption/interrupts disabled, so it should 
work, IIUC.

And then, the trade-off would be:
- Read side: zero cost (no per-CPU tracking)
- Write side: wait for RCU grace period (potentially slower)

For collapse/unshare, that write-side latency might be acceptable :)

@David, what do you think?

> 
> I really think anything here needs to better explain the various
> requirements. Because now everybody gets to pay the price for hugetlb
> shared crud, while 'nobody' will actually use that.

Right. If we go with synchronize_rcu(), the read-side cost goes away ...

Thanks,
Lance
