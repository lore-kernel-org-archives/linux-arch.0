Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E2346AD6
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549053; cv=none; b=lzNCpE4Sc0kKLfa61LdbxZrNfFzFmDo0MC7nPyae3h0Q2w+te8umoLZ7Kvd22DV7ag/dzVlblcZKmyG10EOswWCT/Wo57OqlYXKtvjD9BZPgTwh1k+OA8KXuNjUKyhjKF6TCu40F/LD79AvtjVwfs5LYo66XgdmyRd097212fBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549053; c=relaxed/simple;
	bh=r+ngCif+2ZTM3dV/fDnTq3aN32vLGNDDPveNneeRZuY=;
	h=Cc:Subject:References:Message-Id:Mime-Version:To:In-Reply-To:
	 Content-Type:From:Date; b=UyGxWpWuTJldBslX9lhAFyNzWEnNbWLbegu6RmvHR8L6cF9hhX3UDywoSSEsE+rmde0vrUjEnX46TWnreJPsebq7/C4PDaeHCakD41LxKZ7QHabzZTTzviLXomV2CnPH7Ye90enU/9vZm17reiLoZAPdkLYt6MBKLzG7KXUnDt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R9LyQKxT; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R9LyQKxT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549040; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YZqNbH2if8hUjJ9Tg0ji4lns0q8vnGSCzJjMbirHpIY=;
 b=R9LyQKxTPN3H2L1JCHoN1dqj96A2F7ISe8vHbP3QT2+gy9T3DoxeIlj1osYxd+DlitoM5T
 sqR/fDs/ZvPvlpTCqToTIhY6m1kuHP6+wdXRVbO7yUnw8NPxoelOPRslQODPLo2l7F3pcK
 p0GJACLNfaThTkYnO053O8NklLD8U4Ag1MGtsQC3hqZ4GpCfe++yxiIaCGFB2QleQUudX0
 yK5EV37qiyzAhzP7u9fSSaxg9vo4/iN2HNDE/h+tb/L9MSHStHrmNsZpze6E6G5YJKWPvR
 AitjrMU3pUX5rOU1QI/7daI21aLvYGYBWIBEWAD1c8bhN9wUTDF4hJnOeYfifA==
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a5e0eae+71586d+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Subject: [PATCH v7 0/9] mm: optimize zone-device memmap initialization
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Message-Id: <20260720120259.1545-2-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 20 Jul 2026 20:02:50 +0800

memmap_init_zone_device() can take a noticeable amount of time when large
pmem namespaces are bound or rebound, because it initializes nearly
identical struct page descriptors one PFN at a time. This series reduces
that ZONE_DEVICE memmap initialization overhead by reusing prepared
struct page templates and, on x86, using memcpy_nontemporal() for the
template copy path.

The main target is large fsdax/devdax pmem configurations, where the
cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
bind and rebind latency.

Patches 1-3 are preparatory cleanups and helper extraction. Patches 4-5
add the template-copy path for head pages and compound tails. Patches
6-8 introduce memcpy_nontemporal(), extend the x86 fixed-size
memcpy_flushcache() inline cases used by that helper, and switch the
template-copy path over to memcpy_nontemporal(). Patch 9 removes the
remaining local opt-out predicate and always uses the template path after
the first real page seeds the reusable template.

Architectures without a specialized memcpy_nontemporal() backend fall
back to memcpy(), so the template-copy optimization remains available
without arch-specific support. On x86, memcpy_nontemporal() maps to the
existing memcpy_flushcache() backend and can use the fixed-size MOVNTI
paths added by this series for struct page sized copies.

This version also incorporates a round of review comments from Sashiko
on patches 6-8.

For patch 6, the generic memcpy_nontemporal() fallback is a macro alias
to memcpy(), rather than an inline wrapper, so architectures without a
specialized backend keep the usual memcpy() FORTIFY coverage when object
sizes remain visible at the original call site.

For patch 7, I re-checked whether the new 32/48/64/80/96-byte MOVNTI
cases should add a separate alignment check before staying on the inline
fast path. I re-checked the Intel SDM together with the existing
memcpy_flushcache() behavior, and I did not find an architectural
statement that would make those new cases require a different
correctness rule from the long-standing 4/8/16-byte fast paths. This
series therefore keeps the new fixed-size cases inline without adding a
separate alignment check.

For patch 8, I re-checked whether the template-copy path needs a
helper-level drain after the MOVNTI-based copies. This series keeps
memcpy_nontemporal() as a copy primitive only. Callers that use it for a
producer-consumer or device-visible handoff must provide the required
ordering. The ZONE_DEVICE template-copy path uses it only while
initializing struct page metadata, so the copy primitive itself does not
grow a separate drain contract.

The numbers below measure the time spent in memmap_init_zone_device()
during driver bind/rebind. They are not measurements of the full
nd_pmem or dax_pmem bind/rebind operation.

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

This reduces the average memmap initialization time measured during
rebind by about 60.4% for nd_pmem and 56.4% for dax_pmem.

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

This reduces the measured memmap initialization time during rebind by
about 54.2% for nd_pmem and 57.2% for dax_pmem on that setup, which is
broadly consistent with the VM results above.

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

Li Zhe (9):
  mm: fix stale ZONE_DEVICE refcount comment
  mm: factor zone-device page init helpers out of
    __init_zone_device_page
  mm: add a set_page_section_from_pfn() helper
  mm: add a template-based fast path for zone-device page init
  mm: extend the template fast path to zone-device compound tails
  string: introduce memcpy_nontemporal()
  x86/string: extend memcpy_flushcache() fixed-size fastpaths
  mm: use memcpy_nontemporal() in zone-device template copies
  mm: always use the zone-device template init path

 arch/x86/include/asm/string_64.h |  68 +++++++++++++++-
 include/linux/mm.h               |  15 +++-
 include/linux/string.h           |  12 +++
 mm/mm_init.c                     | 131 +++++++++++++++++++++++++------
 4 files changed, 198 insertions(+), 28 deletions(-)

---
v6: https://lore.kernel.org/all/20260709112520.24857-1-lizhe.67@bytedance.com/
v5: https://lore.kernel.org/all/20260701090553.62691-1-lizhe.67@bytedance.com/
v4: https://lore.kernel.org/all/20260603080152.64728-1-lizhe.67@bytedance.com/
v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

v6->v7:
- Rename memcpy_nt() to memcpy_nontemporal() so the generic helper name
  is explicit rather than abbreviated. Suggested by Muchun Song.
- Drop the separate memcpy_nt_drain() helper and remove the drain calls
  from the ZONE_DEVICE template-copy path. Suggested by Muchun Song.
- Rework patch 6 so the generic memcpy_nontemporal() fallback uses
  '#define memcpy_nontemporal memcpy', preserving the usual memcpy()
  FORTIFY coverage when object sizes remain visible at the original call
  site.
- Summarize the off-list Sashiko review comments relayed by Andrew on
  the memcpy helper and x86 memcpy_flushcache() pieces.
- Add patch 9 to remove the local template-enable predicate and the
  remaining non-template fallback path, as suggested by Muchun. This
  also means KASAN/KMSAN builds no longer force the per-page
  initialization path, and page_ref_set no longer observes every
  initialization-time refcount assignment.
- Re-ran the VM performance test for v7. The results were close to the
  previously reported v5 numbers, so keep the existing performance data
  unchanged.
- Rename pagemap_resets_refcount() to pagemap_requires_refcount_reset()
  and invert the predicate accordingly. Suggested by Balbir Singh.

For changelogs of earlier revisions, please refer to the v6 cover letter.

-- 
2.20.1
