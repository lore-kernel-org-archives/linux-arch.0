Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162010;
	b=2W9zQivQ+cYnf6Sk0qknWvxS5Y5WisCKicbzDvK5zlxwJVUd+Pdb53S+lfvLyehgyry9
	 jkAypk1ytex8/1hHjv0CbB0aU6MzDuQ8+VJ7Gu0aDryXrjpf19dqd/zvJNWSBhoUotxwH
	 r8JM7HRlNC/n93Y/2R9/2A+IcYsszne0A+KwFbHFAwvk/W0iHtqMCub5kbi88A13aJYuO
	 2/9lmsbsrhOo/X3aMI4KKnCeyiI1bxEgOVzx03e+EQdEe12bggbfgN5EBp+zdWy+F6Tf2
	 hfz4EVA3LyJ7crrmbnngcSGwczk4ivcpq74XjsYUy5UyXlqvUsKZCE4KjBzwodbZtMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162010;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hoaYYE9clIuJ0Ig445chvZt4nolRKxe5BT9MRTh3Egg=;
	b=orAeAPDf/Ib9fpxMq66ZdQPI2feMdCqZACLDIWA//sCkd1lbxs/6x1a+0asMQdrZ6cCR
	 2ZcRpbs2ReKmcok1aZx+UQnBN8+xbdW2eRzvdycuZq/ufGaJtPiz53G3r348XRE333Mvy
	 V4DO89TeBIsqM763eQj10y8QvwUjq/h1SiGUhUUkMo57UQKQz1cz+t1D08FeaSc+W3VFI
	 L+/BIB54cKyKyO/PIYLlP1i1wMkBujYKZFHozvWpQUv305BOhT6HCMOhpgJOEUFla2OK5
	 RCzK3Ga7v/tYC9NlKyixY1PMbylkv1wadZsg46z6Ib1waaRwRfclcfw11qh2vflaalA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WeW0dcEy;
	arc=none smtp.remote-ip=95.215.58.212
Received: from mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58F606A31F
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 04:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D58F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WeW0dcEy
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=T4efCo2Hap6aPJgKK/ehUGhK0yIt+mn0LCQnSmlQd0s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793162000; v=1; x=1793766800;
 b=WeW0dcEyzkw6mTIdVt2Z06iHEedOA9csfafpNxIqlvgXWGNleOMk4G5+xIqtxnfY0oJlEGQo
 3RIOLo03odtO32V/gvt274JFHEpf0OAsY2K6WgJh+s2w2M9H9KOLel/juzZL0FcuRQ3OjvRdcI0
 9UEAxWdkfJdjVzGrmw7+tycY=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bee4a2cb7972e2c2;
	Wed, 28 Oct 2026 04:33:20 +0000
X-Mizu-Trace-ID: bee4a2cb7972e2c2
X-Migadu-Flow: FLOW_OUT
Message-ID: <fa0f07af-e8d7-44b0-b1e7-ad325d75ac34@linux.dev>
Date: Wed, 28 Oct 2026 12:32:54 +0800
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org,
 peterz@infradead.org, jannh@google.com, pfalcato@suse.de, hughd@google.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, willy@infradead.org,
 jack@suse.cz, ziy@nvidia.com, riel@surriel.com, harry@kernel.org,
 apopple@nvidia.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 osalvador@suse.de, minchan@kernel.org, muchun.song@linux.dev,
 xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, josef@toxicpanda.com
References: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
 <20261027121307.40431-1-lance.yang@linux.dev>
 <87e3d64e-8b25-4d51-a984-7ab8a58f785d@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <87e3d64e-8b25-4d51-a984-7ab8a58f785d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/28 03:41, David Hildenbrand (Arm) wrote:
>> LLM stumbled upon a possible race in kpage_read() ...
>>
>> Say the reader passes pfn_section_valid() for a device PFN in a section
>> shared with online RAM, gets preempted, and resumes after
>> pgmap_array_delete(). We'd then find no pgmap and return pfn_to_page(pfn),
>> even though the subsection is no longer valid ...
> 
> I think that's similar to our pfn_to_online_page() vs. memory offlining races,
> just slightly different. Getting these races down to 0 is pretty hard.
> 
> This patch here tries to do better and arguably almost looks like a cleanup.
> 
> I wouldn't worry about that one for now; it's extremely unlikely to hit. And it'

Ack.

>>
>> Could we take the memory hotplug read lock in kpage_read(), covering both
>> the lookup and the metadata reads? We can drop it before put_user(), once
>> we're done with the page.
>>
>> Maybe along these lines?
>>
>> ---8<---
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index 6aa99e42ec22..12bed36d76dc 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/hugetlb.h>
>>   #include <linux/memremap.h>
>>   #include <linux/memcontrol.h>
>> +#include <linux/memory_hotplug.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/page_idle.h>
>>   #include <linux/kernel-page-flags.h>
>> @@ -77,6 +78,8 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
>>   	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>>
>>   	while (count > 0) {
>> +		/* Prevent memory removal while inspecting the memmap. */
>> +		get_online_mems();
> get_online_mems() is the big hammer we try to avoid (or ideally remove at some
> point). And it's most pfn_to_online_page() users that are affected.
> 
> A seqcount in pfn_to_online_page() could detect concurrent pgmap removal and
> retry from the start. But I'd rather delay something like that.

Fair enough, let's leave it alone for now given how unlikely it is to hit :)

> Thanks for taking a look! (Can I convince you to review some of the THP fixes?
> pleeeeaaasseee :) )

Of coursssssssse! I'm already looking through the THP fixes :D

Cheers, Lance

