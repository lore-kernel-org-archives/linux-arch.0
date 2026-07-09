Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1F3F5BC7
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596363; cv=none; b=p7aHPe3HFkB3X0pFcNAc+Y1H7K01Y/zyGonBe5ZK5SeNGxvnDIWE9rdLefsW4y9L0Y/Wn3N2spGsPEuVGyyTO9thVqrSBzfJtio9AFbXBrY9LXFypbmqKjLLZawqfC1XBBEEtVHlOrFSUovdBehbhYXBECXCDRGXraCG69g+IQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596363; c=relaxed/simple;
	bh=m/pd2dP2zINWku9rXXBt6JnvTg9ByMMSESiJmZWTRu4=;
	h=To:From:Date:Content-Type:Cc:Subject:Message-Id:Mime-Version; b=PqyrOVu3AdR6nhzAn6lxODbeYUfZNDl+JM7RwxxtFEwsbnNO/tJ6j2ztuaiSSEs327v8WLag4D44DtQ1HPx280gwrultXN2gLS3kbGu02oKkqEKISgEyWFbG0tXcqrtGkwSPCI4cnejGhpGJ5xHUjW4lop5U7FB5FL1SKz7jRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kzjgJrZq; arc=none smtp.client-ip=209.127.231.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kzjgJrZq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596348; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4hnKT2U0BQq9BUwMBRD2qfbEirp8V8apnVJSe2FPr0M=;
 b=kzjgJrZq+Ip8/EyWMUvE4wp8CkbAoKLcYPn4g00hN8za62oF13oyeF9GhAiXCl/nxcXG75
 21CAJnRu3e5ilsJEZZyRlmdhnq19TLCr2OYzhYwD7szWC0SJ/9b/9d8AoGVMowacFM60gc
 Kj/GkqzUpzTX3t5mpsKVwTxCYNPs/fhoqTOvuOwU5F9kXkbEbA8WTWGg1BseH13MM3WkkM
 jGlQx+UV+zVfIBHcJ16pnvljztYcBGGNY3r+m0js7Up7hQ5OronqKzAlseZSq12bnIuCvN
 NMIPy52FU4B/ye0ObiK9bmZF5Zxd86skd96svkEHSYYAmpqBOwdp9BNaWM7r0Q==
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Date: Thu,  9 Jul 2026 19:25:12 +0800
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
Subject: [PATCH v6 0/8] mm: optimize zone-device memmap initialization
Message-Id: <20260709112520.24857-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4f853a+d301fb+vger.kernel.org+lizhe.67@bytedance.com>

memmap_init_zone_device() can take a noticeable amount of time when large
pmem namespaces are bound or rebound, because it initializes nearly
identical struct page descriptors one PFN at a time. This series reduces
that ZONE_DEVICE memmap initialization overhead by reusing prepared
struct page templates and, on x86, using memcpy_nt() for the template
copy path.

The main target is large fsdax/devdax pmem configurations, where the
cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
bind and rebind latency.

Patches 1-3 are preparatory cleanups and helper extraction. Patches 4-5
add the template-copy fast path for head pages and compound tails.
Patches 6-8 introduce memcpy_nt()/memcpy_nt_drain(), extend the x86
fixed-size memcpy_flushcache() inline cases used by that helper, and
switch the template-copy path over to memcpy_nt().

The fast path remains disabled when the page_ref_set tracepoint is
active, and sanitized builds stay on the slow path so their instrumented
stores are preserved. Architectures without a specialized memcpy_nt()
backend continue to fall back to memcpy().

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem driver 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.2-rc1):
  First binding for nd_pmem driver: 1456 ms
  Average of subsequent rebinds: 244.28 ms

  First binding for dax_pmem driver: 1462 ms
  Average of subsequent rebinds: 273.31 ms

With this series applied:
  First binding for nd_pmem driver: 1272 ms
  Average of subsequent rebinds: 96.79 ms

  First binding for dax_pmem driver: 1354 ms
  Average of subsequent rebinds: 119.04 ms

This reduces the average rebind time by about 60.4% for nd_pmem and
56.4% for dax_pmem.

As an additional data point, I also ran a smaller set of measurements on
the same physical x86_64 host with a 100 GB PMEM region created via the
memmap= kernel command line, configured as fsdax and devdax namespaces
with map=dev and 2 MiB alignment.

For brevity, the individual patches keep only the VM results rather than
including a second set of physical-host measurements throughout the
series. The physical-host numbers below are included only as
supplemental evidence that the same optimization also provides a similar
benefit on a non-virtualized system.

Test procedure:
Reconfigure the namespace mode, rebind the nd_pmem or dax_pmem driver
once, and collect the memmap initialization time from the pr_debug()
output of memmap_init_zone_device().

Base (v7.2-rc1):
  nd_pmem / fsdax: 179 ms
  dax_pmem / devdax: 264 ms

With this series applied:
  nd_pmem / fsdax: 82 ms
  dax_pmem / devdax: 113 ms

This reduces the measured rebind time by about 54.2% for nd_pmem and
57.2% for dax_pmem on that setup, which is broadly consistent with the
VM results above.

As another supplemental data point, I also measured the test_hmm.ko
module on the same physical x86_64 host, using the test_hmm.ko setup
from the previous discussion that times ten 64 GB
memremap_pages()/memunmap_pages() iterations during module insertion[1].
By default, module insertion initializes two DEVICE_PRIVATE dmirror
devices, so two avg memremap values are reported; each value is the
average for one 64 GB chunk.

This is not the primary target workload of the series, but it exercises
the same large ZONE_DEVICE memmap initialization path and shows the same
direction of improvement.

Base (v7.2-rc1):
  avg memremap reported during module insertion: 116689362 ns, 116539263 ns

With this series applied:
  avg memremap reported during module insertion: 54607108 ns, 54458236 ns

This corresponds to about a 53.2% reduction based on the mean of the
reported values, which is again consistent with the pmem bind/rebind
results above.

[1] https://lore.kernel.org/all/aiEoByaQdRR3xtM5@nvdebian.thelocal/

Li Zhe (8):
  mm: fix stale ZONE_DEVICE refcount comment
  mm: factor zone-device page init helpers out of
    __init_zone_device_page
  mm: add a set_page_section_from_pfn() helper
  mm: add a template-based fast path for zone-device page init
  mm: extend the template fast path to zone-device compound tails
  string: introduce memcpy_nt() helpers
  x86/string: extend memcpy_flushcache() fixed-size fastpaths
  mm: use memcpy_nt() in zone-device template copies

 arch/x86/include/asm/string_64.h |  78 ++++++++++++-
 include/linux/mm.h               |  15 ++-
 include/linux/string.h           |  23 ++++
 mm/mm_init.c                     | 186 ++++++++++++++++++++++++++-----
 4 files changed, 273 insertions(+), 29 deletions(-)

---
v5: https://lore.kernel.org/all/20260701090553.62691-1-lizhe.67@bytedance.com/
v4: https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/
v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

v5->v6:
- Rework patch 6 so the x86 memcpy_nt_drain() helper uses wmb()
  instead of an open-coded sfence, while architectures that do not
  override memcpy_nt() keep the generic no-op drain fallback.
  Suggested by Borislav Petkov.
- Rework patch 6 to use the usual self-macro override pattern for
  memcpy_nt() and memcpy_nt_drain() instead of a dedicated
  __HAVE_ARCH_MEMCPY_NT feature macro. Suggested by David
  Hildenbrand.
- Drop the default: case from pagemap_resets_refcount() and drop the
  WARN_ONCE() after the switch so newly added enum memory_type values
  remain visible to compiler switch checking. Suggested by David
  Hildenbrand.
- Drop the unnecessary empty set_page_section() stub from patch 3, keep
  set_page_section_from_pfn() as the only !SECTION_IN_PAGE_FLAGS no-op
  helper and fix its indentation. Suggested by David Hildenbrand.
- Rework patch 4 so the reusable head-page template is seeded from the
  first loop iteration, keeping the main loop intact while ensuring the
  first page is initialized only once; also drop the extra template
  memcpy helper, as suggested by Alistair Popple.
- Rework patch 5 similarly for compound tails: seed the reusable tail
  template from the first tail-page iteration so the first tail page is
  initialized only once, while keeping the main tail loop intact, as
  suggested by Alistair Popple.
- Rework patch 7 to rename the internal fixed-size MOVNTI helpers to
  movnti_*(), keep memcpy_flushcache() as the externally visible
  wrapper, fold the new 32/48/64/80/96-byte copies into the main
  fixed-size switch, clarify in the code and changelog that the
  ZONE_DEVICE template-copy path relies on the 64/80/96-byte struct
  page copies while 32/48-byte copies stay inline as well, and drop the
  separate alignment check based on the physical-host microbenchmark
  results. Suggested by Borislav Petkov.
- Run v6 VM spot checks for the fsdax/devdax map=dev paths. The
  results stayed in the same ballpark as v5, so keep the previously
  posted v5 full-run numbers in this version instead of replacing them
  with another partial data set.

For changelogs of earlier revisions, please refer to the v5 cover letter.

-- 
2.20.1
