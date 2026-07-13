Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AAF421A03
	for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948571; cv=none; b=jB9WaYH9TveeRt4SqLRaArrb9UiRvJHX7sMa/k9VwY0/i9sy82uneQ6UMPAmIdk848Eml/QTjfgEVaV2gqRKH0Wi1MuaFllYnm1DATqS+A7d7m39f1dzRT/ZTUkYNqQG1wHUvWhaLFSAvQW5qWMGcLt6wLlBUZPFzmE7bWgCqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948571; c=relaxed/simple;
	bh=a4SzCdkRRHc/jms2Jj79zGLP27YJuyvagu4ZznWT118=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ukVVEwNOCeUrhtCmayqsJM1ulZnTCiL8AzB6DPdpbaD93jHskopiiNvkFVqLJKjE4CTV5m+iE12EB0+99Fy+rxG/0SrgTURXrWpy6gT+3/SujS4kb1LyYPL8lhyWd+/PZeC0iiyytIYZzOS2tWuD39epmowQsziHcNd/OwjvHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LzlWtJnY; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LzlWtJnY"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783948557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loKEcLzupCf5eogPXEODoUGsHwah+Nyt24MVTxOpJDU=;
	b=LzlWtJnY7ZWv3HudNubSmpvpLWrqzfRvPluQCU7iADMhfHzGQql69P3IvMU4imgn/N6rKE
	iipXYs79lNyUTtL5FWOY/X+f+abZGzOa46wjqbBz5fsBUy7F6gTgWsUMDolFpiWMRyFu4A
	DV1N8VYxpmbnD1Io03kX+OydZ/Ww9iQ=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v6 0/8] mm: optimize zone-device memmap initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
Date: Mon, 13 Jul 2026 21:15:26 +0800
Cc: akpm@linux-foundation.org,
 apopple@nvidia.com,
 arnd@arndb.de,
 balbirs@nvidia.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 david@kernel.org,
 kees@kernel.org,
 mingo@redhat.com,
 rppt@kernel.org,
 tglx@kernel.org,
 linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1115D12-9B88-4230-A3E3-2CA3A961E4A6@linux.dev>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
To: Li Zhe <lizhe.67@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 9, 2026, at 19:25, Li Zhe <lizhe.67@bytedance.com> wrote:
>=20
> memmap_init_zone_device() can take a noticeable amount of time when =
large
> pmem namespaces are bound or rebound, because it initializes nearly
> identical struct page descriptors one PFN at a time. This series =
reduces

Hi, I have a detailed question regarding the timing of the bound or =
rebound
process.

1. How long does the entire process take?
2. Specifically, how long does the struct page initialization take?

I'm trying to understand the time distribution and what percentage of =
the
total process is occupied by the struct page initialization.

> that ZONE_DEVICE memmap initialization overhead by reusing prepared
> struct page templates and, on x86, using memcpy_nt() for the template
> copy path.
>=20
> The main target is large fsdax/devdax pmem configurations, where the
> cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
> bind and rebind latency.
>=20
> Patches 1-3 are preparatory cleanups and helper extraction. Patches =
4-5
> add the template-copy fast path for head pages and compound tails.
> Patches 6-8 introduce memcpy_nt()/memcpy_nt_drain(), extend the x86
> fixed-size memcpy_flushcache() inline cases used by that helper, and
> switch the template-copy path over to memcpy_nt().
>=20
> The fast path remains disabled when the page_ref_set tracepoint is
> active, and sanitized builds stay on the slow path so their =
instrumented
> stores are preserved. Architectures without a specialized memcpy_nt()
> backend continue to fall back to memcpy().
>=20
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=3Ddev and a 100 GB devdax namespace (align=3D2097152) on Intel Ice =
Lake
> server.
>=20
> Test procedure:
> Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
> initialization time from the pr_debug() output of
> memmap_init_zone_device().
>=20
> Base(v7.2-rc1):
>  First binding for nd_pmem driver: 1456 ms
>  Average of subsequent rebinds: 244.28 ms
>=20
>  First binding for dax_pmem driver: 1462 ms
>  Average of subsequent rebinds: 273.31 ms
>=20
> With this series applied:
>  First binding for nd_pmem driver: 1272 ms
>  Average of subsequent rebinds: 96.79 ms
>=20
>  First binding for dax_pmem driver: 1354 ms
>  Average of subsequent rebinds: 119.04 ms
>=20
> This reduces the average rebind time by about 60.4% for nd_pmem and
> 56.4% for dax_pmem.

Regarding the 60% reduction in time: does this refer to the entire =
process,
or specifically to the initialization of struct pages in =
memmap_init_zone_device()?

Thanks.

>=20
> As an additional data point, I also ran a smaller set of measurements =
on
> the same physical x86_64 host with a 100 GB PMEM region created via =
the
> memmap=3D kernel command line, configured as fsdax and devdax =
namespaces
> with map=3Ddev and 2 MiB alignment.
>=20
> For brevity, the individual patches keep only the VM results rather =
than
> including a second set of physical-host measurements throughout the
> series. The physical-host numbers below are included only as
> supplemental evidence that the same optimization also provides a =
similar
> benefit on a non-virtualized system.
>=20
> Test procedure:
> Reconfigure the namespace mode, rebind the nd_pmem or dax_pmem driver
> once, and collect the memmap initialization time from the pr_debug()
> output of memmap_init_zone_device().
>=20
> Base (v7.2-rc1):
>  nd_pmem / fsdax: 179 ms
>  dax_pmem / devdax: 264 ms
>=20
> With this series applied:
>  nd_pmem / fsdax: 82 ms
>  dax_pmem / devdax: 113 ms
>=20
> This reduces the measured rebind time by about 54.2% for nd_pmem and
> 57.2% for dax_pmem on that setup, which is broadly consistent with the
> VM results above.
>=20
> As another supplemental data point, I also measured the test_hmm.ko
> module on the same physical x86_64 host, using the test_hmm.ko setup
> from the previous discussion that times ten 64 GB
> memremap_pages()/memunmap_pages() iterations during module =
insertion[1].
> By default, module insertion initializes two DEVICE_PRIVATE dmirror
> devices, so two avg memremap values are reported; each value is the
> average for one 64 GB chunk.
>=20
> This is not the primary target workload of the series, but it =
exercises
> the same large ZONE_DEVICE memmap initialization path and shows the =
same
> direction of improvement.
>=20
> Base (v7.2-rc1):
>  avg memremap reported during module insertion: 116689362 ns, =
116539263 ns
>=20
> With this series applied:
>  avg memremap reported during module insertion: 54607108 ns, 54458236 =
ns
>=20
> This corresponds to about a 53.2% reduction based on the mean of the
> reported values, which is again consistent with the pmem bind/rebind
> results above.
>=20
> [1] https://lore.kernel.org/all/aiEoByaQdRR3xtM5@nvdebian.thelocal/
>=20
> Li Zhe (8):
>  mm: fix stale ZONE_DEVICE refcount comment
>  mm: factor zone-device page init helpers out of
>    __init_zone_device_page
>  mm: add a set_page_section_from_pfn() helper
>  mm: add a template-based fast path for zone-device page init
>  mm: extend the template fast path to zone-device compound tails
>  string: introduce memcpy_nt() helpers
>  x86/string: extend memcpy_flushcache() fixed-size fastpaths
>  mm: use memcpy_nt() in zone-device template copies
>=20
> arch/x86/include/asm/string_64.h |  78 ++++++++++++-
> include/linux/mm.h               |  15 ++-
> include/linux/string.h           |  23 ++++
> mm/mm_init.c                     | 186 ++++++++++++++++++++++++++-----
> 4 files changed, 273 insertions(+), 29 deletions(-)
>=20
> ---
> v5: =
https://lore.kernel.org/all/20260701090553.62691-1-lizhe.67@bytedance.com/=

> v4: =
https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/=

> v3: =
https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/=

> v2: =
https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/=

> v1: =
https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/=

>=20
> Changelogs:
>=20
> v5->v6:
> - Rework patch 6 so the x86 memcpy_nt_drain() helper uses wmb()
>  instead of an open-coded sfence, while architectures that do not
>  override memcpy_nt() keep the generic no-op drain fallback.
>  Suggested by Borislav Petkov.
> - Rework patch 6 to use the usual self-macro override pattern for
>  memcpy_nt() and memcpy_nt_drain() instead of a dedicated
>  __HAVE_ARCH_MEMCPY_NT feature macro. Suggested by David
>  Hildenbrand.
> - Drop the default: case from pagemap_resets_refcount() and drop the
>  WARN_ONCE() after the switch so newly added enum memory_type values
>  remain visible to compiler switch checking. Suggested by David
>  Hildenbrand.
> - Drop the unnecessary empty set_page_section() stub from patch 3, =
keep
>  set_page_section_from_pfn() as the only !SECTION_IN_PAGE_FLAGS no-op
>  helper and fix its indentation. Suggested by David Hildenbrand.
> - Rework patch 4 so the reusable head-page template is seeded from the
>  first loop iteration, keeping the main loop intact while ensuring the
>  first page is initialized only once; also drop the extra template
>  memcpy helper, as suggested by Alistair Popple.
> - Rework patch 5 similarly for compound tails: seed the reusable tail
>  template from the first tail-page iteration so the first tail page is
>  initialized only once, while keeping the main tail loop intact, as
>  suggested by Alistair Popple.
> - Rework patch 7 to rename the internal fixed-size MOVNTI helpers to
>  movnti_*(), keep memcpy_flushcache() as the externally visible
>  wrapper, fold the new 32/48/64/80/96-byte copies into the main
>  fixed-size switch, clarify in the code and changelog that the
>  ZONE_DEVICE template-copy path relies on the 64/80/96-byte struct
>  page copies while 32/48-byte copies stay inline as well, and drop the
>  separate alignment check based on the physical-host microbenchmark
>  results. Suggested by Borislav Petkov.
> - Run v6 VM spot checks for the fsdax/devdax map=3Ddev paths. The
>  results stayed in the same ballpark as v5, so keep the previously
>  posted v5 full-run numbers in this version instead of replacing them
>  with another partial data set.
>=20
> For changelogs of earlier revisions, please refer to the v5 cover =
letter.
>=20
> --
> 2.20.1

