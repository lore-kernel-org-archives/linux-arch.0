Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F251E5201;
	Fri,  1 May 2026 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660249; cv=none; b=Ln23lNaBmwzc28RdQUyuDsa7bBvtNPsBWM4YeD8957GcEs8zUFC8GQdhtYPXdFqYlN7YYE9C97HT6BD7g4HoQ8tXIZKK3EkWSuIG4QLazCXtN+op8tBqXGhTLzPVEMBTnoAlHCuOddUP/2298i2QmRxSY6L2uUVERTeoDNoEFq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660249; c=relaxed/simple;
	bh=MvOC25XMd6Pzmb5m65jh3SGYYAXGbC6/swCh9j1k4nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMJzM3PmfRPvDwlOoYzi3naHUGVv5pwS+w4WQ8XzoSt8fdrLKHBnJh1M6rscE3VPxrpF8vAYUicBG0B/NBXa2bQPl/EaXUu1p8WwVIkw1yibFrco8Mtx47h2/DzuIAYfiKpjzJqUJUv9OSkxxLM8yH70XOtRMYUDf9o7+6JX/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN3HLiBC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN3HLiBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71587C2BCB4;
	Fri,  1 May 2026 18:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777660249;
	bh=MvOC25XMd6Pzmb5m65jh3SGYYAXGbC6/swCh9j1k4nY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hN3HLiBClFE8t5eZe5W59y6m21vYvdp+0Y6p59AluP72u+jL30K+Q8Q1dakOnSQAa
	 5aftawxIpxvA9fWQK2NkuiDFKJRrMZbkN/aawxU8DPbnSNuA+a8VVz6lvy0CdhGJU9
	 xrkFjemiauwDCAgfbMFlvK63NLtBAP5J5+Hz9LS2Mi2/AEF9OXc+Ym/tmLVq3LQyFb
	 FHcUMiCKkd8DDikLZ5CtKpLmOcjAdWu1+gCwUTaiQF/ZrgLo9p0Ka1T9CHzBbqzK/9
	 h7pgTV4F9ZoZZiS0QmyHVQfBII5QeXzSFTEc4i6qzZrBNIVXAYg0fOuNSEtTU0Wh62
	 e2CkwxhtkLGSw==
Message-ID: <785b6164-aa71-4fc4-a4f3-f4977b7db30e@kernel.org>
Date: Fri, 1 May 2026 20:30:39 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mm: Support selecting doing direct COW for anonymous
 pmd entry
To: Luka Bai <lukafocus@icloud.com>
Cc: linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 Luka Bai <lukabai@tencent.com>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
 <b5379cd3-f7bf-47f9-8a60-c7300b4415a2@kernel.org>
 <afTR48WxGnIpxK8a@LUKABAI-MC1>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <afTR48WxGnIpxK8a@LUKABAI-MC1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>
>> Note that there was a recent related discussion for executable, which was rejected:
>>
>> https://lore.kernel.org/r/20251226100337.4171191-1-zhangqilong3@huawei.com
>>
> 
> Yes, I know this history, and I know that it will cost some memory or latency,
> That’s why I was wondering maybe I can add a switch to it to make it
> configurable :).

Switches for something like that is just not a good fit.

For example, for a short-lived child (e.g., fork+exec) it usually makes no sense
to cow a larger chunk of address space, when you know that it will exit
immediately either way and free up the memory.

>>>
>>> In addition to the problem above, this logic can also generate some
>>> deficiency for THP itself. Currently THP is just a "best-effort" choice
>>> with no "certainty". THP is easily splitted into multiple small pages
>>> on common calling path like reclaiming, COW. A transparent splitting
>>> can cause throughput fluctuation for some workloads. For these workloads,
>>> we may want to give THP some "certainty" just like hugetlbfs,
>>
>> There are no such guarantees, though. And We wouldn't want to commit to any such
>> guarantees today. For example, simple page migration can split the folio.
>> Allocation failures will fallback to small pages etc.
>>
>> If you need guarantees, use hugetlb for now.
>>
> 
> The reason why I want to use THP over hugetlb is that I need reclamation for my
> workload :). There are many processes in my workload that need 2M
> aligned folios for better performance, and we want to reclaim them back automatically
> when the process doesn’t need the folios. 

Can you share some details how exactly that is supposed to work?

> But hugetlbfs cannot do passive reclamation
> from what I know (except doing active madvise by the processes themselves). And using

Right, you can only return hugetlb folios by doing MADV_DONTNEED or munmap().

> THP can easily split the hugepages. So that’s why I would like to add certainty for THP,

Repeat after me: there are no guarantees. There is no certainty :)

> and use THP for these processes as backend, because THP is very well integrated with
> the swap system and other filesystems. And from what I checked,
> it seems the most common case for splitting a THP is COW and swapping so I am trying
> to handle these two scenarios (But coincidentally, PMD swapping is committed in
> https://lore.kernel.org/all/D3F08F85-76E0-4C5A-ABA1-537C68E038B8@nvidia.com/
> a few days before, which is a great implementation :) ).

Right, but that really only changes how we map large folios, not how we allocate
them. There are no guarantees.

> 
>>> The effect
>>> we want is: after some customized setup, if only the system has usable
>>> folio, and the virtual memory alignment permits (or we setup to), we can
>>> make sure we always use THP for it, the system will never split it except
>>> the user wants to do so.
>>>
>>> This patchset is about both two things above, firstly we add pmd level
>>> THP COW support by revising the code in do_huge_pmd_wp_page, we added
>>> switch for it because different workloads may need different resources,
>>
>> The switch is bad, and we won't accept any toggle like that. A system-wide
>> setting does not make sense for such behavior.
>>
> 
> Oh, the reason why I added a switch globally is also because the scenario I mentioned
> above, I want those processes to always use PMD sized folios as backend to make sure
> performance. 

"Always" is wishful thinking in many scenarios I'm afraid.

> COW is truly not that common like swap out/swap in, it just can happen
> sometimes, which I guess the reason may be about image duplication. Setting the system
> globally is more convenient for my situation :). I can go without this global switch
> if it's more reasonable.
> 
>> A per-VMA flag? Maybe, but I expect pushback as well, as it is way too specific.
>> So we'd have to find some concept that abstracts these semantics. But I expect
>> pushback as well.
>>
>> We messed up enough with toggles in THP space, unfortunately.
>>
>> Also, anything that only works for PMD-sized THPs is a warning sign in 2026 :)
>>
> 
> And for PMD-sized THPs, actually, I’m also considering adding more support for
> COW to mTHP if the upstream consider it useful. And also for pud sized THPs
> also. But I guess I have to firstly handle stage 1: PMD level COW now :).
> And also, since PMD sized folio is commonly used in my workload, I'm also wondering
> digging into pmd sized KSM in the future, in which I think pmd sized COW may
> be more useful then :).

I'm afraid I have to stop you right there: there has to be a pretty convincing
story to add any of that. In particular KSM with large folios (/me shivering).

But I already don't buy the COW story. Just configure khugepaged in a better way
or use MADV_COLLAPSE and you don't really need to modify the kernel at all in
99.99% of the case. (khugepaged needs a lot of tuning work, it's currently not
the smartest implementation)

Maybe, we might give khugepaged better direction of what to try scanning next
(e.g., where we just COW'ed a THP). Not sure, there are plenty of things to explore.

> 
>> You don't really raise any concrete use cases or performance numbers for these
>> use cases. Some details about applications that use fork() and rely on such
>> behavior would be helpful.
>>
> 
> Sorry for that, the concrete workload itself hasn't been finished yet. 

Okay, what I thought after seeing no workloads an no performance numbers :)

If you don't know the workload, how can you claim that the additional latency
and/or memory consumption is not a problem?

Also: there is no guarantee that you will actually succeed in allocating a PMD
THP during a COW fault.


> Now it just
> can happen sometimes in my multi-2M-sized-processes workload test. But the user
> of our 2M sized folio schema is actually not necessarily myself but also can be the
> userspace developers. I cannot guarantee that fork will not be used in the
> performance test of their workload since that is a normal posix call. Maybe a little
> overthinking? :)

If your application cares about performance, you either shouldn't be using
fork(), or you should be using it very, very wisely (e.g., interaction with
multi-threading, MADV_DONTFORK, avoid touching memory in parent until child
completed).

> I just think swap and COW are two main scenarios that may transparently split pmd sized
> folios, so maybe we can solve it and make THP both reclaimable and stable.

There is page migration, MADV_DONTNEED, munmap/mremap/madvise/mprotect in sub-2M
blocks, memory failure handling and probably a lot more. THP allocation might
fail. THP swapout+swapin might fail to allocate THPs.

Tackling COW handling when you don't even know that it's a real problem seems
premature.

> Maybe
> that can make THP more widely used in real deployed environment since the resource
> can become more controllable for the users :). That's why I was thinking maybe
> implementing it with setup switches is a reasonable solution?

No magical toggles.

> 
>> Note that an application that does fork() could use MADV_COLLAPSE after fork()
>> to make sure that it immediately gets THPs back.
>>
>> There is also the option to just use MADV_DONTFORK to not even share ranges with
>> a child process in the first place, avoiding page copies entirely.
>>
> 
> MADV_DONTFORK and MADV_COLLAPSE are nice and great options :), but the former one seems
> to be a little wasteful :). 

It's actually the right thing to do (tm) if you care about fork() performance
and know that your child will not actually need certain memory areas.

For example, in QEMU we use it to exclude all guest memory from fork(), heavily
improving fork() performance. [there are not a lot of fork() use cases left in
QEMU today, fortunately]

-- 
Cheers,

David
