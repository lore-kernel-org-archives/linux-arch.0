Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D14407568
	for <linux-arch@vger.kernel.org>; Wed,  3 Jun 2026 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473796; cv=none; b=c/89WX1o5YUDLvhoGVkyDwR4Ev4RVa+GFxhbpg5lpf9GMy8yQnBq69v1kd636L/IBTSJUHfSGzras8OInraN9AhhjjeoU2uK6XSDSWxgPX8w65zPIr5RT2xpSxLilmokZXZQyVdE9hwEEDMGJ6UceXp6+5yoeN4TLh/mJxyGb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473796; c=relaxed/simple;
	bh=zY9uSA9mh2VIN/I3X32zfuPMh2mwuFkmFTC7yRagVjY=;
	h=Subject:Date:Cc:From:Content-Type:To:Message-Id:Mime-Version; b=nbf0N/wsr9CtFtd2mlTzUW2LHP6JGrEFoCKRfEkiZmwauQgxgY8EYgnytb1qD20ktUZVpHLRWF/WFACYAwfz6bjOsyzW+9hCb2d2vdhOq7xo11OUAGOiqkCijur4hxhh/aMPs0i7AG88qbq8968BbvP79Apl2ZIJKhwSLTunbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XhyhxQVt; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XhyhxQVt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780473785; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mlIIN622rLr22plKnXfWrvgdqL032Wr8kiqR08LjPLw=;
 b=XhyhxQVtwdu7YbtdnzYMUC3AbW7fd3Fk7Kr6/21Dx9zAadCBWoz2E9PbnH4ma1yhudSGD2
 IrrqyI9TK8j83Bsk4eqOYyYWzgddEpiFsAPz+Jl4YsydWx2zDs9j8Expvc69QMmG2qesvI
 zfof/RMcR8Qr9NKceU8ApJ7JA4Z5fq2cjM5BHdc+EhksGOSoaoETqQCz+QNEj4EA3JJq2t
 NkDJGByIHw7LE9TEVjSkHDjeCy/kKujZvBQLUQH6ocrKCJB6PnuJZeunvbeGc9IreKdnzm
 mX90p4eYnF5SS7Mf/AGvpm5J3cVuw2I33X0TBqYuI3rUznY/U3Pp912tlONBBw==
Subject: [PATCH v4 0/8] mm: speed up ZONE_DEVICE memmap initialization
Date: Wed,  3 Jun 2026 16:01:44 +0800
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
X-Mailer: git-send-email 2.45.2
Message-Id: <20260603080152.64728-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a1fdfb7+d48ee0+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

memmap_init_zone_device() can spend a substantial amount of time
initializing large ZONE_DEVICE ranges because it repeats nearly
identical struct page setup for every PFN.

This series reduces that overhead in eight steps.

The first patch fixes a stale comment in __init_zone_device_page() so
the documented refcount policy matches the current ZONE_DEVICE code.

The second patch factors the reusable pieces out of
__init_zone_device_page() so later patches can share the same logic
without changing the existing slow path.

The third patch adds set_page_section_from_pfn(), so callers that want
to refresh section bits from a PFN no longer need to open-code
SECTION_IN_PAGE_FLAGS handling.

The fourth patch adds a template-based fast path for ZONE_DEVICE head
pages. Instead of rebuilding the same struct page state for every PFN,
it prepares one reusable template through the existing slow path,
refreshes the PFN-dependent fields in that template, and copies it to
each destination page.

The fifth patch extends the same template-based approach to compound
tails, so pfns_per_compound > 1 can also benefit from the fast path.

The sixth patch introduces memcpy_streaming() and
memcpy_streaming_drain() as a generic interface for write-once copies.
Architectures that do not provide a specialized backend, or cases that
cannot safely use one, fall back to memcpy().

The seventh patch extends x86 memcpy_flushcache() small fixed-size
fastpaths so struct-page-sized streaming copies can stay on the inline
path when alignment permits.

The last patch switches the ZONE_DEVICE template-copy path over to
memcpy_streaming(). It keeps pageblock-aligned PFNs on regular memcpy(),
uses memcpy_streaming() for the remaining write-once copies, and drains
streaming stores before later metadata updates that may depend on them.

This is not intended as a steady-state data-path optimization. Its
benefit is in pmem bring-up paths where memmap_init_zone_device()
dominates device online / rebind latency, such as:
  - fsdax or devdax namespace creation and reconfiguration
  - nd_pmem / dax_pmem driver bind or rebind

In those paths, the kernel initializes a large vmemmap range once and
does not immediately benefit from keeping the copied struct page state
hot in cache. Reducing write-allocate traffic in that one-time setup
path can therefore reduce end-to-end device bring-up latency.

The optimized path is disabled when the page_ref_set tracepoint is
enabled, and sanitized builds remain on the slow path so their
instrumented stores are preserved.

Testing
=======

Tests were run in a VM on an Intel Ice Lake server.

Two PMEM configurations were used:
  - a 100 GB fsdax namespace configured with map=dev, which exercises
    the nd_pmem rebind path (pfns_per_compound == 1)
  - a 100 GB devdax namespace configured with align=2097152, which
    exercises the dax_pmem rebind path (pfns_per_compound > 1)

For each configuration, the corresponding driver was unbound and
rebound 30 times. Memmap initialization latency was collected from the
pr_debug() output of memmap_init_zone_device().

The first bind is reported separately, and the average of subsequent
rebinds is used as the steady-state result.

Performance
===========

nd_pmem rebind, 100 GB fsdax namespace, map=dev
  Base(v7.1-rc6):
    First binding: 1466 ms
    Average of subsequent rebinds: 262.12 ms
  Full series:
    First binding: 1359 ms
    Average of subsequent rebinds: 108.36 ms

dax_pmem rebind, 100 GB devdax namespace, align=2097152
  Base(v7.1-rc6):
    First binding: 1430 ms
    Average of subsequent rebinds: 229.12 ms
  Full series:
    First binding: 1273 ms
    Average of subsequent rebinds: 100.17 ms

Li Zhe (8):
  mm: fix stale ZONE_DEVICE refcount comment
  mm: factor zone-device page init helpers out of
    __init_zone_device_page
  mm: add a set_page_section_from_pfn() helper
  mm: add a template-based fast path for zone-device page init
  mm: extend the template fast path to zone-device compound tails
  string: introduce memcpy_streaming() helpers
  x86/string: extend memcpy_flushcache() fixed-size fastpaths
  mm: use memcpy_streaming() in zone-device template copies

 arch/x86/include/asm/string_64.h | 140 ++++++++++++++++++--
 include/linux/mm.h               |  19 ++-
 include/linux/string.h           |  20 +++
 mm/mm_init.c                     | 221 +++++++++++++++++++++++++++----
 4 files changed, 360 insertions(+), 40 deletions(-)

---
v3: https://lore.kernel.org/all/20260527033636.28231-1-lizhe.67@bytedance.com/
v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

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
