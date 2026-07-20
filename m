Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BD3E16BD
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549032; cv=none; b=bYwrOtwOvbyLG6ioORnWhhgnfo6NBeX4Gd/KS86PZhnncxSovQfTQrZhXJnVCn++5k8PlhJtA1BYyiDm7ExVzSwXkKf1oQyGF2A83LGowbCtvaka67uQbIfJHJg0cyTP+kLa7bl3IcWhcwNhQTmJEm6qkRlGYp1NQ/SQci+vkTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549032; c=relaxed/simple;
	bh=r+ngCif+2ZTM3dV/fDnTq3aN32vLGNDDPveNneeRZuY=;
	h=Subject:Date:Message-Id:From:Mime-Version:Content-Type:To:Cc; b=LyhbpcKiOG3ilp6NxejAedQzSnSHK/D57QFb5T19t51yEbBZgkQo3mwQSw6MZ4DCeBRS70l+Izy6b8i/9IkzIg+/aGHOTO93ST4IGCCHyxv34dOjd+ImL10EGL7Mtf40fk9X8ym0AIz72XY1Nha9RC+0fl8Z1mNIIpj7+j8W18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gkCwPRf5; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gkCwPRf5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549017; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=YZqNbH2if8hUjJ9Tg0ji4lns0q8vnGSCzJjMbirHpIY=;
 b=gkCwPRf5OYelaxFVRtKt2pX6aAr6564lfQVdWzI/8u1zpF+AsHXRRIKPToXgWn98sN+/DA
 iYK5wbbtKeSe5lSuHiD5cUWQ1Vh/ojJmqoOoZTrfQXppfYLWjYf5fwQnIK3jmB61mLdZhF
 PnhLSlRBoVW/dt19LEKrvQPlDz3qOez/E1DYr1E2fbkwBW+B8ZbXcXQQj+G+VFNBSr/jHn
 b96y96OxdjRHVwUDBAcmnFB0pUq8hPCEsbRQfXVZ2BHUfDnmrS/ou/qz+oTIpU/2YYFyRN
 47TyiJOUkhXGqT8FS2hNb08QIoB4r9RQea4uhn0GgAZ3I4JN5UsgTwArRfKDAA==
Subject: [PATCH v7 0/9] mm: optimize zone-device memmap initialization
Date: Mon, 20 Jul 2026 20:02:49 +0800
Message-Id: <20260720120259.1545-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a5e0e98+589273+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

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
