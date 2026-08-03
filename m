Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646D39479B
	for <linux-arch@vger.kernel.org>; Mon,  3 Aug 2026 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741018; cv=none; b=fvKjVxH7eJjjB2yxB5qPFex8oUUcKy4C1sYQy9TWfM2n/ivxZOlMklXlCO+zoafui/rp2ZdMO1E6HfVfJ6Kd7Yz0HHtKBXmVT5ndZcT2jtqq55E32rpb3ehAPqFnymVTs3P2h7norA8OthbO79LkkgKXXZp+MFZN1DP9bH7mJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741018; c=relaxed/simple;
	bh=O7aJvyTpViOaQkOBg+spNZ7K+ywfMuBD/X7mhJvL+9M=;
	h=To:Subject:Cc:Content-Type:From:Date:Message-Id:Mime-Version; b=NsySZTntn2EBIeOsbg0LZ8Iai7L8HBM/GLrfyZpx7oiU1pU01rvLW2NiUCYc0yGNNtMoamyeP2JQylh0BmiY2B1lidLMacpMrOhFW1eLBHuZQ1ZUpaAvKCjR5ZYX3TS28ei5n4MYU63DzFNEHOlQ/km2G4Oi9jmcf951kTdMeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Yv+rapu3; arc=none smtp.client-ip=209.127.231.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Yv+rapu3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785741004; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Dlxlju2HTEwtVmJagDsLypfIpt084rUgsfdg3oPPP2E=;
 b=Yv+rapu3nvFwufQyDk9X2aJmCFNEHL0xkzWMrPG4B8EG9AvI1LUgoMCEc6ZkbWBRamok8H
 GrXBeSYmDPvZwJzdqvFKoY2CFpXe8LPtRm4fWLU5trWj7uzbVOjfsySPeNPjxTRuiqzhfk
 Cq1UjAoTbSiubJIPH9xeLSS+C5dJxsWeKs98QqR677wK8hj8ksH8ywC+g62Hq1o9tKWcGJ
 ly2vH5unMs10YkWozvT/hXG3EFCnG50u4un67uf1GxnnSTktv+SHObBkJ/Hv4yQAxuClTk
 lsw0+JD9rCXs25vFK+g8070gToPIE6vbkI6YC5nMQ1KHjtQCNTAF9UkECATm7A==
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v9 0/8] mm: optimize zone-device memmap initialization
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a703ecb+0adc5e+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon,  3 Aug 2026 15:09:21 +0800
Message-Id: <20260803070929.86075-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

memmap_init_zone_device() can take a noticeable amount of time when large
pmem namespaces are bound or rebound, because it initializes nearly
identical struct page descriptors one PFN at a time. This series reduces
that ZONE_DEVICE memmap initialization overhead by reusing prepared
struct page templates and, on x86, using memcpy_nontemporal() for the
template copy path.

The main target is large fsdax/devdax pmem configurations, where the
cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
bind and rebind latency. This matters because the cost is paid in the
synchronous probe/bind path for large DAX/PMEM ZONE_DEVICE mappings.
Userspace workflows such as provisioning or reconfiguring
nd_pmem/dax_pmem namespaces, bringing hot-added PMEM-backed capacity
online, and recovering or rebinding a device after driver or device
changes all wait for this initialization to finish. Reducing this cost
will yield benefits as lower user-visible provisioning, hot-add,
recovery, and rebind latency for large DAX/PMEM devices.

Patches 1-3 are preparatory cleanups and helper extraction. Patches 4-5
add the template-copy path for head pages and compound tails. Patch 6
introduces memcpy_nontemporal(). Patch 7 switches the ZONE_DEVICE
template-copy path over to memcpy_nontemporal(). Patch 8 extends the x86
fixed-size memcpy_flushcache() inline cases used by the x86
memcpy_nontemporal() backend for struct page sized copies.

Architectures without a specialized memcpy_nontemporal() backend fall
back to memcpy(), so the generic template-copy optimization remains
available without arch-specific support. On x86, memcpy_nontemporal()
maps to the existing memcpy_flushcache() backend and can use the
fixed-size MOVNTI paths added by this series for struct page sized
copies.

memcpy_nontemporal() is only a copy primitive. It does not imply a drain
or a publication barrier. Callers that use it before a producer-consumer
or device-visible handoff must provide the required ordering. The
ZONE_DEVICE template-copy path uses it only while initializing struct
page metadata, so the copy primitive itself does not grow a separate
drain contract.

The numbers below measure the time spent in memmap_init_zone_device()
during driver bind/rebind. They are not measurements of the full
nd_pmem or dax_pmem bind/rebind operation.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.2-rc1):
  Average of nd_pmem rebinds: 244.28 ms
  Average of dax_pmem rebinds: 273.31 ms

With this series applied:
  Average of nd_pmem rebinds: 96.79 ms
  Average of dax_pmem rebinds: 119.04 ms

This reduces the average memmap initialization time measured during
rebind by about 60.4% for nd_pmem and 56.4% for dax_pmem.

As an additional x86_64 data point, I also ran a smaller set of
measurements on the same physical host with a 100 GB PMEM region created
via the memmap= kernel command line, configured as fsdax and devdax
namespaces with map=dev and 2 MiB alignment.

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

This reduces the measured memmap initialization time during rebind by
about 54.2% for nd_pmem and 57.2% for dax_pmem on that setup, which is
broadly consistent with the VM results above.

As another supplemental data point, I measured the test_hmm.ko module on
the same physical x86_64 host, using the test_hmm.ko setup from the
previous discussion that times ten 64 GB
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

I also tested the generic template-copy part on an arm64 QEMU virt VM
with 64 KB pages and a 100 GB ACPI NVDIMM sparse backend. This setup
does not use the x86 MOVNTI fast paths, so it exercises the
architecture-independent part of the optimization.

For devdax, 2 MiB alignment is rejected in this 64 KB page setup, so the
devdax namespace was tested with the supported default 512 MiB
alignment.

Base (v7.2-rc1):
  Average of rebinds for nd_pmem driver: 25.60 ms
  Average of rebinds for dax_pmem driver: 25.60 ms

With this series applied:
  Average of rebinds for nd_pmem driver: 11.07 ms
  Average of rebinds for dax_pmem driver: 13.20 ms

This reduces the average memmap initialization time measured during
rebind by about 56.8% for nd_pmem and 48.4% for dax_pmem on that arm64
VM setup. Since this arm64 setup does not use the x86 MOVNTI fast paths,
the result also suggests that the generic template-copy optimization can
benefit architectures without an architecture-specific
memcpy_nontemporal() backend.

Li Zhe (8):
  mm: fix stale ZONE_DEVICE refcount comment
  mm: factor zone-device page init helpers out of
    __init_zone_device_page
  mm: add a set_page_section_from_pfn() helper
  mm: add a template-based fast path for zone-device page init
  mm: extend the template fast path to zone-device compound tails
  string: introduce memcpy_nontemporal()
  mm: use memcpy_nontemporal() in zone-device template copies
  x86/string: extend memcpy_flushcache() fixed-size fastpaths

 arch/x86/include/asm/string_64.h |  68 +++++++++++++++-
 include/linux/mm.h               |  15 +++-
 include/linux/string.h           |  13 +++
 mm/mm_init.c                     | 132 +++++++++++++++++++++++++------
 4 files changed, 200 insertions(+), 28 deletions(-)

---
v8: https://lore.kernel.org/all/20260727123429.5673-1-lizhe.67@bytedance.com/
v7: https://lore.kernel.org/all/20260720120259.1545-1-lizhe.67@bytedance.com/
v6: https://lore.kernel.org/all/20260709112520.24857-1-lizhe.67@bytedance.com/
v5: https://lore.kernel.org/all/20260701090553.62691-1-lizhe.67@bytedance.com/
v4: https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/
v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

v8->v9:
- Fold the removal of the local non-template fallback into the relevant
  template-copy patches and drop the separate cleanup patch.
- Reorder the memcpy_nontemporal() use before the x86 fixed-size
  fastpath patch, so the x86 patch shows its incremental ZONE_DEVICE
  benefit directly.
- Rework the x86 fixed-size fastpath commit message to justify the
  struct page sized copies and report real ZONE_DEVICE initialization
  data instead of a standalone microbenchmark.
- Add arm64 QEMU nd_pmem map=dev and dax_pmem devdax measurements for
  the generic template-copy path.
- Refresh the per-patch performance data for patches 4, 5, 7, and 8.

For changelogs of earlier revisions, please refer to the v8 cover
letter.

-- 
2.20.1
