Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9742EEDD
	for <linux-arch@vger.kernel.org>; Thu,  5 Feb 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309073; cv=none; b=Af+A8qrjJvIkAv/0b5I+Q2sRVtvLz7QHM+wDSX2RjzMf4gNTFaNd9Y3bhlgbI2+SzMBThlB62IKBDmQ5zwppb/QmbSDB0Dygl733kWcQlmIGq7az9II1RfUB0TqEiyVvQBXS+ZMgIbCEAMGBitn4nFQBpT1cJZVLu+aNmLP0iME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309073; c=relaxed/simple;
	bh=RgYjy/FS3gKarTqUKXeh64DjCJJ1+NOM6TVLekmHaUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSoGBiz7e41dnh44vSkooqMNEu07jKnVGTy25ttentFgyXng4Nld1rssXfyIS2M1V0hGmrwSxvUsxv7/zqbyMldDL46fmbPxu+NUXNvYw0AcUX92bew3oAqqDyeqArSMSU5MtEXB9WkIHvz9jW1nmzUNzkeCPmmpV+Wz/3pvBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l1TzN3rS; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l1TzN3rS"
Message-ID: <99237729-f2b0-4a7a-8213-65a2f1c57744@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770309071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbZHvzzZjCNHqfw2Za1VcDxMPMr4DhRUSdKJcr9E8gk=;
	b=l1TzN3rSqTHJAvlDtvSYCjaDB4zHST0ryzOd0kL2Ys4/vjxmH2+LAUikMM571gueD62OzJ
	VhGD/7n8hlqhrRpZlPJIyvs0jsS8km8JF9zNNTaZ41HqkE2adsSo3LB7bY52C6Du4BCLNi
	4YVw83ojYxp2S5dWu1dipTU3aJVgcIU=
Date: Fri, 6 Feb 2026 00:30:56 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
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
 <64f3a75a-30ff-4bee-833c-be5dba05f72b@intel.com>
 <c985a8ed-37ad-415e-b7b4-18a66b4da3fe@linux.dev>
 <647cbe2e-a034-4a75-9492-21ea1708eccc@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <647cbe2e-a034-4a75-9492-21ea1708eccc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/5 23:41, Dave Hansen wrote:
> On 2/5/26 07:31, Lance Yang wrote:
>> On 2026/2/5 23:09, Dave Hansen wrote:
>>> On 2/5/26 07:01, Lance Yang wrote:
>>>> So for now, neither approach looks good: tracking on the read side adss
>>>> cost to GUP-fast, and syncing on the write side e.g. synchronize_rcu()
>>>> is too slow on large systems.
>>>
>>> Which of the writers truly *need* synchronize_rcu()?
>>>
>>> What are they doing with the memory that they can't move forward unless
>>> it's quiescent *now*?
>>
>> Without IPIs or synchronize_rcu(), IIUC, we have no way to know if there
>> are ongoing concurrent lockless page-table walks — the walkers just disable
>> IRQs and walk.
> 
> Yeah, but one aim of RCU is ensuring that readers see valid data but not
> necessarily the most up to date data.
> 
> Are there cases where ongoing concurrent lockless page-table walks need
> to see the writes and they can't tolerate seeing valid but slightly
> stale data?

The issue is we're about to free the page table (e.g. 
pmdp_collapse_flush()).

We have to ensure no walker is still doing a lockless page-table walk
when the page directories are freed, otherwise we get use-after-free.

> Don't forget that we also have pesky concurrent lockless page-table
> walkers called CPUs. They're extra pesky in that they don't even stop
> for IPIs. ;)

I assume those walkers that don't disable IRQs only read the PMD and
don't walk into the table; otherwise the current sync wouldn't work
for them.

Thanks,
Lance
