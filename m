Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CF13777E
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097511; cv=none; b=S3xmGIY5s19iI0VFi+/1mGbzyzXm2G7HIRRJzYp11gouAUQNvB+R2bl1VIBP+yrGRfds9E6Q+NtoSTps7wRWLQ6fsPlm5OBOS5iR7iwJmloTpko4UOPbDyRPi1t1VOtWuRQCF833dL2NQA96THauD51AcWe2olq+v8d8uV3PXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097511; c=relaxed/simple;
	bh=U9r8chIj1XRiDpB46ZpAuAXyb8tXCKniVknBUnMUP+w=;
	h=References:Mime-Version:To:From:Subject:Date:Message-Id:Cc:
	 In-Reply-To:Content-Type; b=Scf2SUQNEa6DBjOnW8HvEXeaNJex7MH2N9ezl4EekBISZ2rWSg/nU5+QGbkv/vJeIe4rFaBk7aqYatuI6DhhqqlNubJ36gOKK0Z6ADRlqgClP30rF20CMrsMy8c4UVVgo8wr2KxhNyUIkkpXIjj+zTeJi7nKvYroFVwkTBE5xLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ArVMmEBp; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ArVMmEBp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784097497; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JI+RKsGCz/0DZdRNKhXswE1vaznhyS/d6iZ7oFYXWFA=;
 b=ArVMmEBpEg9vVKihM0jbI4d3bZlYnK9d4HjUwa60VkwKYlQBqYRM1vbkPO0UyzUiN3mWiD
 mpkIEOtYT9U7e14KurPKsIYUOq1x9iEMmaXC8f4AQw2eAlBWsuYEsKJ4W0/Rw2m5lN/lcj
 mvQQbCsx5LruG1TyfDO9TfjVkZn2M0KZuOPJSWM9Ky6ClqAWiKo/spMn0dCSj2AJX0F5rT
 IMfHAahsNl31s6G38l5C8CMCKEg6cIV59+nG5Dep5Buj6CS+kdU1hTXfiAmwXOTUHgTP/0
 000uPJ/DJrTYZ8S1/BlGZi9GdRPX63SXVuUZn6FFaGYewkqjhIvntvtMUCGJ4A==
X-Lms-Return-Path: <lba+26a572ad7+468991+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com> <F1115D12-9B88-4230-A3E3-2CA3A961E4A6@linux.dev>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Muchun Song" <muchun.song@linux.dev>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v6 0/8] mm: optimize zone-device memmap initialization
Date: Wed, 15 Jul 2026 14:37:53 +0800
Message-Id: <a3ce9d12-a1b2-4201-b16a-b3f98ec8abd7@bytedance.com>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <x86@kernel.org>
In-Reply-To: <F1115D12-9B88-4230-A3E3-2CA3A961E4A6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird

On 7/13/26 9:15 PM, Muchun Song wrote:
>
>> On Jul 9, 2026, at 19:25, Li Zhe <lizhe.67@bytedance.com> wrote:
>>
>> memmap_init_zone_device() can take a noticeable amount of time when large
>> pmem namespaces are bound or rebound, because it initializes nearly
>> identical struct page descriptors one PFN at a time. This series reduces
> Hi, I have a detailed question regarding the timing of the bound or rebound
> process.
>
> 1. How long does the entire process take?
> 2. Specifically, how long does the struct page initialization take?
>
> I'm trying to understand the time distribution and what percentage of the
> total process is occupied by the struct page initialization.
What I measured and reported in this version is the
memmap_init_zone_device() time from its pr_debug() output.

Separately, on my setup, a flamegraph of the pmem driver bind path
showed __init_zone_device_page() dominating the operation and accounting
for more than 90% of the module insertion time, which is why this
series focuses on that path.


>> that ZONE_DEVICE memmap initialization overhead by reusing prepared
>> struct page templates and, on x86, using memcpy_nt() for the template
>> copy path.
>>
>> The main target is large fsdax/devdax pmem configurations, where the
>> cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
>> bind and rebind latency.
>>
>> Patches 1-3 are preparatory cleanups and helper extraction. Patches 4-5
>> add the template-copy fast path for head pages and compound tails.
>> Patches 6-8 introduce memcpy_nt()/memcpy_nt_drain(), extend the x86
>> fixed-size memcpy_flushcache() inline cases used by that helper, and
>> switch the template-copy path over to memcpy_nt().
>>
>> The fast path remains disabled when the page_ref_set tracepoint is
>> active, and sanitized builds stay on the slow path so their instrumented
>> stores are preserved. Architectures without a specialized memcpy_nt()
>> backend continue to fall back to memcpy().
>>
>> Tested in a VM with a 100 GB fsdax namespace device configured with
>> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
>> server.
>>
>> Test procedure:
>> Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
>> initialization time from the pr_debug() output of
>> memmap_init_zone_device().
>>
>> Base(v7.2-rc1):
>>   First binding for nd_pmem driver: 1456 ms
>>   Average of subsequent rebinds: 244.28 ms
>>
>>   First binding for dax_pmem driver: 1462 ms
>>   Average of subsequent rebinds: 273.31 ms
>>
>> With this series applied:
>>   First binding for nd_pmem driver: 1272 ms
>>   Average of subsequent rebinds: 96.79 ms
>>
>>   First binding for dax_pmem driver: 1354 ms
>>   Average of subsequent rebinds: 119.04 ms
>>
>> This reduces the average rebind time by about 60.4% for nd_pmem and
>> 56.4% for dax_pmem.
> Regarding the 60% reduction in time: does this refer to the entire process,
> or specifically to the initialization of struct pages in memmap_init_zone_device()?
>
> Thanks.
It refers specifically to the measured memmap_init_zone_device() time,
not to the full bind/rebind wall time.

Thanks,
Zhe

>> As an additional data point, I also ran a smaller set of measurements on
>> the same physical x86_64 host with a 100 GB PMEM region created via the
>> memmap= kernel command line, configured as fsdax and devdax namespaces
>> with map=dev and 2 MiB alignment.
>>
>> For brevity, the individual patches keep only the VM results rather than
>> including a second set of physical-host measurements throughout the
>> series. The physical-host numbers below are included only as
>> supplemental evidence that the same optimization also provides a similar
>> benefit on a non-virtualized system.
>>
>> Test procedure:
>> Reconfigure the namespace mode, rebind the nd_pmem or dax_pmem driver
>> once, and collect the memmap initialization time from the pr_debug()
>> output of memmap_init_zone_device().
>>
>> Base (v7.2-rc1):
>>   nd_pmem / fsdax: 179 ms
>>   dax_pmem / devdax: 264 ms
>>
>> With this series applied:
>>   nd_pmem / fsdax: 82 ms
>>   dax_pmem / devdax: 113 ms
>>
>> This reduces the measured rebind time by about 54.2% for nd_pmem and
>> 57.2% for dax_pmem on that setup, which is broadly consistent with the
>> VM results above.
>>
>> As another supplemental data point, I also measured the test_hmm.ko
>> module on the same physical x86_64 host, using the test_hmm.ko setup
>> from the previous discussion that times ten 64 GB
>> memremap_pages()/memunmap_pages() iterations during module insertion[1].
>> By default, module insertion initializes two DEVICE_PRIVATE dmirror
>> devices, so two avg memremap values are reported; each value is the
>> average for one 64 GB chunk.
>>
>> This is not the primary target workload of the series, but it exercises
>> the same large ZONE_DEVICE memmap initialization path and shows the same
>> direction of improvement.
>>
>> Base (v7.2-rc1):
>>   avg memremap reported during module insertion: 116689362 ns, 116539263 ns
>>
>> With this series applied:
>>   avg memremap reported during module insertion: 54607108 ns, 54458236 ns
>>
>> This corresponds to about a 53.2% reduction based on the mean of the
>> reported values, which is again consistent with the pmem bind/rebind
>> results above.
>>
>> [1] https://lore.kernel.org/all/aiEoByaQdRR3xtM5@nvdebian.thelocal/
>>
>> Li Zhe (8):
>>   mm: fix stale ZONE_DEVICE refcount comment
>>   mm: factor zone-device page init helpers out of
>>     __init_zone_device_page
>>   mm: add a set_page_section_from_pfn() helper
>>   mm: add a template-based fast path for zone-device page init
>>   mm: extend the template fast path to zone-device compound tails
>>   string: introduce memcpy_nt() helpers
>>   x86/string: extend memcpy_flushcache() fixed-size fastpaths
>>   mm: use memcpy_nt() in zone-device template copies
>>
>> arch/x86/include/asm/string_64.h |  78 ++++++++++++-
>> include/linux/mm.h               |  15 ++-
>> include/linux/string.h           |  23 ++++
>> mm/mm_init.c                     | 186 ++++++++++++++++++++++++++-----
>> 4 files changed, 273 insertions(+), 29 deletions(-)
>>
>> ---
>> v5: https://lore.kernel.org/all/20260701090553.62691-1-lizhe.67@bytedance.com/
>> v4: https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/
>> v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
>> v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
>> v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/
>>
>> Changelogs:
>>
>> v5->v6:
>> - Rework patch 6 so the x86 memcpy_nt_drain() helper uses wmb()
>>   instead of an open-coded sfence, while architectures that do not
>>   override memcpy_nt() keep the generic no-op drain fallback.
>>   Suggested by Borislav Petkov.
>> - Rework patch 6 to use the usual self-macro override pattern for
>>   memcpy_nt() and memcpy_nt_drain() instead of a dedicated
>>   __HAVE_ARCH_MEMCPY_NT feature macro. Suggested by David
>>   Hildenbrand.
>> - Drop the default: case from pagemap_resets_refcount() and drop the
>>   WARN_ONCE() after the switch so newly added enum memory_type values
>>   remain visible to compiler switch checking. Suggested by David
>>   Hildenbrand.
>> - Drop the unnecessary empty set_page_section() stub from patch 3, keep
>>   set_page_section_from_pfn() as the only !SECTION_IN_PAGE_FLAGS no-op
>>   helper and fix its indentation. Suggested by David Hildenbrand.
>> - Rework patch 4 so the reusable head-page template is seeded from the
>>   first loop iteration, keeping the main loop intact while ensuring the
>>   first page is initialized only once; also drop the extra template
>>   memcpy helper, as suggested by Alistair Popple.
>> - Rework patch 5 similarly for compound tails: seed the reusable tail
>>   template from the first tail-page iteration so the first tail page is
>>   initialized only once, while keeping the main tail loop intact, as
>>   suggested by Alistair Popple.
>> - Rework patch 7 to rename the internal fixed-size MOVNTI helpers to
>>   movnti_*(), keep memcpy_flushcache() as the externally visible
>>   wrapper, fold the new 32/48/64/80/96-byte copies into the main
>>   fixed-size switch, clarify in the code and changelog that the
>>   ZONE_DEVICE template-copy path relies on the 64/80/96-byte struct
>>   page copies while 32/48-byte copies stay inline as well, and drop the
>>   separate alignment check based on the physical-host microbenchmark
>>   results. Suggested by Borislav Petkov.
>> - Run v6 VM spot checks for the fsdax/devdax map=dev paths. The
>>   results stayed in the same ballpark as v5, so keep the previously
>>   posted v5 full-run numbers in this version instead of replacing them
>>   with another partial data set.
>>
>> For changelogs of earlier revisions, please refer to the v5 cover letter.
>>
>> --
>> 2.20.1
