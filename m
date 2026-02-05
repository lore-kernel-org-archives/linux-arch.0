Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF9C31D725
	for <linux-arch@vger.kernel.org>; Thu,  5 Feb 2026 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305324; cv=none; b=hbu3dQh0G9pwfLqo/1fhjTNhuJfkfDaBLR4lrHBP8T4dr/ZR/soMNB5D4UQZaKgSPvTyPOxxa7RlP6X9Jc1rSagc+6zUIeR7IdVW6oxLwU9B62rKHghlHV9OD04Q1ELREXQc7At1AfIjXfBu2neXvk1nyUSU7ix8pfOXP58juK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305324; c=relaxed/simple;
	bh=lJ5wO2c6vKdGC7MPNXyr5jt8IpI5g1cswUmXgctwk64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYFTkcfqLJiCDHKFUkzFSh9DtCt/GA7T//CHwJfQ8VnTjDRhVFOVUeheD8epVkBeUPbLVndpilEJSWH94ynJbrkiLQmfWvTqjIuL3HBEyEEtSXN7vR/Tf9paknEMOaPyorK4tkx7cReGSkHPUuPYG0U3RsDBHhS+99JXh0LKjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IEGzDoIL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IEGzDoIL"
Message-ID: <8f5f7617-7a35-4cb2-97b2-0a73c6d9622c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770305311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SL5gP8QX8DLMYTu036KBvNCXId/b3s1citx/YK+obQ=;
	b=IEGzDoILmn6RaziZQkRjyJvvzWlaFO58iWze8rY0jh1kOJLRhJO6HZpFljbyPC+X0L84Av
	Cj3u8KxpQa88wJ2ZLpjRYTRBp6+7l5b63JFvgtpcdm+Vg8KJhKoywh+RxTy+/vns8wVrSm
	I/WRZ4sW+DSRbVjCNuvHzj//KzAkgjE=
Date: Thu, 5 Feb 2026 23:28:14 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, dave.hansen@intel.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, arnd@arndb.de, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, boris.ostrovsky@oracle.com, bp@alien8.de,
 dave.hansen@linux.intel.com, dev.jain@arm.com, hpa@zytor.com,
 hughd@google.com, ioworker0@gmail.com, jannh@google.com, jgross@suse.com,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org,
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
 <d6944cd8-d3b7-4b16-ab52-a61e7dc2221c@linux.dev>
 <06d48a52-e4ec-47cd-b3fb-0fccd4dc49f4@kernel.org>
 <3026ad8d-92ad-4683-8c3e-733d4070d033@linux.dev>
 <13205d28-7478-4578-8bf3-ead18b4dc6b0@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <13205d28-7478-4578-8bf3-ead18b4dc6b0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/5 23:05, David Hildenbrand (Arm) wrote:
> On 2/5/26 16:01, Lance Yang wrote:
>>
>>
>> On 2026/2/5 21:25, David Hildenbrand (Arm) wrote:
>>> On 2/2/26 16:52, Lance Yang wrote:
>>>>
>>>>
>>>>
>>>> Yep, we could replace the IPI with synchronize_rcu() on the sync side:
>>>>
>>>> - Currently: TLB flush → send IPI → wait for walkers to finish
>>>> - With synchronize_rcu(): TLB flush → synchronize_rcu() -> waits for 
>>>> grace period
>>>>
>>>> Lockless walkers (e.g. GUP-fast) use local_irq_disable(); 
>>>> synchronize_rcu() also
>>>> waits for regions with preemption/interrupts disabled, so it should 
>>>> work, IIUC.
>>>>
>>>> And then, the trade-off would be:
>>>> - Read side: zero cost (no per-CPU tracking)
>>>> - Write side: wait for RCU grace period (potentially slower)
>>>>
>>>> For collapse/unshare, that write-side latency might be acceptable :)
>>>>
>>>> @David, what do you think?
>>>
>>> Given that we just fixed the write-side latency from breaking 
>>> Oracle's databases completely, we have to be a bit careful here :)
>>
>> Yep, agreed.
>>
>>>
>>> The thing is: on many x86 configs we don't need *any* TLB flushed or 
>>> RCU syncs.
>>
>> Right. Looks like that is low-hanging fruit. I'll send that out 
>> separately :)
>>
>>>
>>> So "how much slower" are we talking about, especially on bigger/ 
>>> loaded systems?
>>
>> Unfortunately the numbers are pretry bad. On an x86-64 64-core system
>> under high load, each synchronize_rcu() is about *22.9* ms on average ...
>>
>> So for now, neither approach looks good: tracking on the read side adss
>> cost to GUP-fast, and syncing on the write side e.g. synchronize_rcu()
>> is too slow on large systems.
> 
> GUP-fast is 3%, right? Any way we can reduce that to 1% and call it 
> noise? :)

Yes, GUP-fast is ~3%. I'll keep trying to do that, but first getting
the low-hanging fruit done :)
