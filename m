Received: from sg-3-113.ptr.tlmpb.com (sg-3-113.ptr.tlmpb.com [101.45.255.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737B3DE43E
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175107; cv=none; b=Zu2GTPpoCfJVyibksmJbIALdUA7jKn3QuQSuNCH+NWTVnvLgEjo0iuc+YVcy4TlOD8/42SheN8Waw3FSJcRjmVUR0DwHAvUv4anoVwjqvxXyJzMuntLIE2ILiRwkc8yXn8pA8EJWQUQE8umxOmEQ+EMz37ml26ZrZzcA0bx5lzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175107; c=relaxed/simple;
	bh=B9f4R/ozDd2MP4r1cFc0kzdUL4TsmcGuKuO94bd2mvM=;
	h=From:Message-Id:Mime-Version:Content-Type:To:Date:Cc:Subject; b=SisAka4SHGpMFYitbpdI7Yemxy4qummlWWYPlgCa0D9NzITcen0FUKRBzTT76Pi1l0VmIQ38vHj67ctopHBhUTmC+EvjWCIAnoQBCtKxJ/fcMQHU5OKbOQ5LP6zgEdddwOJaY8knWmltH7RbVP3uYmogo2jKBYutQwrB2M8525U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Thkfo2GE; arc=none smtp.client-ip=101.45.255.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Thkfo2GE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788175048; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zafJqSeEeHqjJ82fLLRjlm02xhpYDt1Y2q1o1VoGjaY=;
 b=Thkfo2GE6yBLxkeJwyQZI7OpivdA1I5GOZdkC5PqEQqHVacckeGseYHKH/GvP+1lXE9b3o
 aKP6GtugHRaFHKw+TF0Wf9qHtur6oZCSf4crdUNWUu/cD3j7VtNZIiMQbESiXzjaBIym5t
 xK8VDCdAjSnImRszdFgVBex63vRmDX/HL0xgr67lVBpJu5drXT+6bLTqZdVytVTXraCoh6
 /4qmOnx/7RmNkOWp+PbgUzjiGSVCKy9g9ovzazqsCHWWTmFEb9oTTw+wKflNT9CGS8Kj9B
 spLAhvt81UABYle7yIw2wB/rROclA7+6N2GL1rGqygMux99sMObvJfPAuHe0Xg==
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260831111638.76012-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a9562c6+2d5a6f+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Date: Mon, 31 Aug 2026 19:16:31 +0800
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Subject: [PATCH v11 0/7] mm: optimize zone-device memmap initialization
Content-Transfer-Encoding: 7bit

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

Patches 1-2 are preparatory cleanups and helper extraction. Patches 3-4
add the template-copy path for head pages and compound tails. Patch 5
introduces memcpy_nontemporal(). Patch 6 switches the ZONE_DEVICE
template-copy path over to memcpy_nontemporal(). Patch 7 extends the x86
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

Tested in an x86_64 QEMU/KVM VM with a 100 GB fsdax namespace device
configured with map=dev and a 100 GB devdax namespace (align=2097152)
on Intel Ice Lake server.

Test procedure:
Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

Base(v7.3-rc1):
  Average of nd_pmem rebinds: 221.07 ms
  Average of dax_pmem rebinds: 191.20 ms

With this series applied:
  Average of nd_pmem rebinds:  71.93 ms
  Average of dax_pmem rebinds:  87.37 ms

This reduces the average memmap initialization time measured during
rebind by about 67.5% for nd_pmem and 54.3% for dax_pmem.

As an additional x86_64 data point, I also ran measurements on the same
physical host with a 100 GB PMEM region created via the memmap= kernel
command line, configured as fsdax and devdax namespaces with map=dev and
2 MiB alignment.

For brevity, the individual patches keep only the VM results rather than
including a second set of physical-host measurements throughout the
series. The physical-host numbers below are included only as
supplemental evidence that the same optimization also provides a similar
benefit on a non-virtualized system.

Test procedure:
Reconfigure the namespace mode, rebind the nd_pmem or dax_pmem driver
30 times, and collect the memmap initialization time from the pr_debug()
output of memmap_init_zone_device().

Base (v7.3-rc1):
  nd_pmem / fsdax: 205.90 ms
  dax_pmem / devdax: 225.43 ms

With this series applied:
  nd_pmem / fsdax: 69.13 ms
  dax_pmem / devdax: 90.67 ms

This reduces the measured memmap initialization time during rebind by
about 66.4% for nd_pmem and 59.8% for dax_pmem on that setup, which is
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

Base (v7.3-rc1):
  avg memremap reported during module insertion: 116500596 ns, 116438028 ns

With this series applied:
  avg memremap reported during module insertion: 46953088 ns, 46428399 ns

This corresponds to about a 59.9% reduction based on the mean of the
reported values, which is again consistent with the pmem bind/rebind
results above.

I also include an arm64 data point for the generic template-copy part.
It was measured on an arm64 QEMU virt VM with 64 KB pages and a 100 GB
ACPI NVDIMM sparse backend. This setup does not use the x86 MOVNTI fast
paths, so it exercises the architecture-independent part of the
optimization.

For devdax, 2 MiB alignment is rejected in this 64 KB page setup, so the
devdax namespace was tested with the supported default 512 MiB
alignment.

Base (v7.3-rc1):
  Average of rebinds for nd_pmem driver: 27.93 ms
  Average of rebinds for dax_pmem driver: 27.87 ms

With this series applied:
  Average of rebinds for nd_pmem driver: 14.53 ms
  Average of rebinds for dax_pmem driver: 16.27 ms

This reduces the average memmap initialization time measured during
rebind by about 48.0% for nd_pmem and 41.6% for dax_pmem on that arm64
VM setup. Since this arm64 setup does not use the x86 MOVNTI fast paths,
the result also suggests that the generic template-copy optimization can
benefit architectures without an architecture-specific
memcpy_nontemporal() backend.

[1] https://lore.kernel.org/all/aiEoByaQdRR3xtM5@nvdebian.thelocal/

Li Zhe (7):
  mm: fix stale ZONE_DEVICE refcount comment
  mm: add a set_page_section_from_pfn() helper
  mm: add a template-based fast path for zone-device page init
  mm: extend the template fast path to zone-device compound tails
  string: introduce memcpy_nontemporal()
  mm: use memcpy_nontemporal() in zone-device template copies
  x86/string: extend memcpy_flushcache() fixed-size fastpaths

 arch/x86/include/asm/string_64.h | 83 ++++++++++++++++++++++++++------
 include/linux/mm.h               | 15 ++++--
 include/linux/string.h           | 13 +++++
 mm/mm_init.c                     | 72 +++++++++++++++++++++------
 4 files changed, 149 insertions(+), 34 deletions(-)

---
v10: https://lore.kernel.org/all/20260810122057.30447-1-lizhe.67@bytedance.com/
v9: https://lore.kernel.org/all/20260803070929.86075-1-lizhe.67@bytedance.com/
v8: https://lore.kernel.org/all/20260727123429.5673-1-lizhe.67@bytedance.com/
v7: https://lore.kernel.org/all/20260720120259.1545-1-lizhe.67@bytedance.com/
v6: https://lore.kernel.org/all/20260709112520.24857-1-lizhe.67@bytedance.com/
v5: https://lore.kernel.org/all/20260701090553.62691-1-lizhe.67@bytedance.com/
v4: https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/
v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

v10->v11:
- Rebased the series on v7.3-rc1.
- Refresh the benchmark numbers on v7.3-rc1.
- Dropped the standalone helper split around __init_zone_device_page(); keep
  the existing helper shape and layer the template path directly on top.
  Suggested by Mike Rapoport.
- Move the first head-page/tail-page initialization out of the template-copy
  loops. Suggested by Mike Rapoport.
- Fold the template PFN-dependent field refresh into the template-copy helper
  instead of keeping a separate zone_device_page_update_template() helper.
  Suggested by Mike Rapoport.

For changelogs of earlier revisions, please refer to the v10 cover letter.

-- 
2.20.1
