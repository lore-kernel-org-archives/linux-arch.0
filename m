Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D093F4824
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896806; cv=none; b=ddRvY9rnVxX7mB1/+y90aWE8SVp64GxJd9FLajuzvt+gA7u7erHg2yoLE3FP5C7UVFELmPFODVthz6zRORUPKFZwC9OSm5nEM+QnMzyB+Zpi6iYsIIFa14EBg33afEXEf6MqN5BugkRX7NXq/RveoFF3nnAPcqb+k47hlguBMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896806; c=relaxed/simple;
	bh=AnkOeZIxYVZ5Da140oXlC1j3YjOwdrXbGPhJRoHDG1k=;
	h=Date:Mime-Version:Message-Id:Cc:From:Subject:To:Content-Type; b=NeIdPrC2IMpyMJUHBCinhsJSz5mGmvwqMT+PV+uis6hq4ur9jKmq6IaNNFdw4fzpjzcd3zte8E9Nu0Rf20hwCe+/qB/+Z4vU1wnyXjRVgpEFJPasNaiagNIu3DHIVRBIeOrQ23AVzfdS59Mkrsb24SaX8GpiglP1Qis2ENgfbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AUzTuqlX; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AUzTuqlX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782896792; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EjyWjEtrStwT/2+GI68sA9Nxt1WEmHQBHqN0cpYv9mI=;
 b=AUzTuqlXcRIm1fVH9G21uK/TvuhInTC43antstOtLIaofe7UDmyMxvQ275UzJEk68bXz3j
 3osGYWwCSZQ5yEYJihOMfDd6/IJECLI6B4rQSaAds4Rc6AKAuTMOTTasqG93nrauRrNIvD
 ldZ7lhvbFvvaPx7MT1DundeGyNFy9tjY8CoTOTyEpWV5QxkcvKA4gEUoF3eMmIstc+ZglR
 XQ8YHnAmQdUSkQnaKMs7MIU4EBhWGnFfMY4DM4SCb/EEb5dVWUguBNmFQpLIbzFE2RcZIT
 KyXewqVz+CDL1tXqAE4z3LUXVEmRI/mn7CYA06Zq9OlSQ95y5y8nfuH9FjK1GA==
Date: Wed,  1 Jul 2026 17:05:45 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260701090553.62691-1-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v5 0/8] mm: optimize zone-device memmap initialization
X-Lms-Return-Path: <lba+26a44d896+1fdd0c+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Content-Type: text/plain; charset=UTF-8

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

 arch/x86/include/asm/string_64.h |  96 +++++++++++++-
 include/linux/mm.h               |  19 ++-
 include/linux/string.h           |  18 +++
 mm/mm_init.c                     | 209 +++++++++++++++++++++++++++----
 4 files changed, 311 insertions(+), 31 deletions(-)

---
v4: https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/
v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

v4->v5:
- Rebase the series from v7.1-rc6 to v7.2-rc1, and refresh the VM
  performance numbers.
- Simplify patch 6 around a small memcpy_nt()/memcpy_nt_drain()
  interface, rename the previous memcpy_streaming() helpers
  accordingly, make the generic implementation fall back to memcpy(),
  and let x86 reuse the existing memcpy_flushcache() backend instead of
  carrying extra policy/alignment logic in the generic layer. Suggested
  by Borislav Petkov.
- Add physical-host measurements for a 100 GB PMEM region simulated via
  the memmap= kernel command line to the cover letter as supplemental
  evidence that the same optimization also improves fsdax/devdax map=dev
  bind/rebind latency outside the VM, while keeping the per-patch
  performance data limited to the VM measurements for consistency across
  the series. Suggested by Borislav Petkov.
- Add supplemental test_hmm.ko results to the cover letter as another
  physical-host data point, in addition to the pmem bind/rebind
  measurements.

v3->v4:
- Rebase the series from v7.1-rc3 to v7.1-rc6.
- Rework patch 4 so the reusable head-page template is seeded from the
  first real struct page, rather than being initialized directly on a
  stack-resident template object. Also add an explicit !nr_pages early
  return. Suggested by Andrew Morton.
- Rework patch 5 similarly for compound tails: seed the reusable
  tail-page template from the first real tail page, thread
  use_template through compound-page initialization, and reuse that
  prepared tail-page image for the remaining tails. Suggested by Andrew
  Morton.
- Tighten patch 6 so memcpy_streaming() maps to memcpy_flushcache() only
  when the destination alignment and size allow the transfer to stay
  entirely on the non-temporal path; other cases fall back to memcpy().
  Suggested by Andrew Morton.
- Rework patch 7 so the existing 4/8/16-byte cases remain handled
  directly in memcpy_flushcache(), while the new aligned fixed-size
  fastpaths cover only the larger 32/48/64/80/96-byte cases. Suggested
  by Andrew Morton.

For changelogs of earlier revisions, please refer to the v3 cover letter:
https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/

-- 
2.20.1
