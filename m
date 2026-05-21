Received: from sg-3-113.ptr.tlmpb.com (sg-3-113.ptr.tlmpb.com [101.45.255.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB7384CF5
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336192; cv=none; b=KT26W1kfdCQPhjIYzr/xnIxLa8KJyJ62zBvfHmys3vP+/sGi0+k1KXFHXqf3HCvRp/8CJxQN2vtAkGz9yjgpl8v9bbfsaYzqeOrXSSqGru0M3NRt989xyjrxjjA8qb9HHvCjtXSpKf88Jh/xn7D8Qs8c6hcBbaUzjZcfAQDcWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336192; c=relaxed/simple;
	bh=93eQjehzU2EibGhHV9TxOLIj3O6xTS5nE7G8tkgGzCY=;
	h=Subject:Message-Id:Content-Type:To:Cc:Mime-Version:From:Date; b=pvh8KqfDTnWUll06x/85eUY5bmk+JmRiWdL40YRKII3tGaRLdrB+nLvaair5cExMbeypE42ZueAOixdDC74ckMGI4MOBH7z2MGlbm7rCNuHjWTcbs5+A+qS/sTclB+BzgMOM+C/cfd4gsKyLWjx17dn/fYReKBmOT6ybtzkMTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qWuU1V7e; arc=none smtp.client-ip=101.45.255.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qWuU1V7e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779336159; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=E/YNDgmqShx3e3fJDptG/XMLbuSaoABmDYTKAIO9WS4=;
 b=qWuU1V7eGqYe+PSwZYr8euYxqeppmmOmuP2GarcEh7cX/W1oKz4rJGdrF0EzkpIOOyzo+W
 gDRsbfGonbKBOMlOxSReGi9Ry+NMOLjKwqMkrNik5tDJmiSMlYO6kTkmFmfSkcsjIMk+VS
 +EAa6FrbKgsONzmeOlLg5kYlNDJHDWn3L8INDgdpZ7NKpUvC0hjQnrJh21BtWqh9f7YY/2
 ELjZDtDnkvlI1ZT2Tb/bzSpssPjIvsf1pTBeIq4CkqwUvTqJCgupODDJQEGSoB3splZ41l
 41uUeFsxY9QmXExEffNKizNpuUDzAFrSrSSJ5ISWtVAE0omFk6UeBiaYdDM0oQ==
X-Mailer: git-send-email 2.45.2
Subject: [PATCH v2 0/7] mm: speed up ZONE_DEVICE memmap initialization
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Message-Id: <20260521040124.10608-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <apopple@nvidia.com>, <akpm@linux-foundation.org>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>, 
	<kees@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <x86@kernel.org>, 
	<linux-hardening@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a0e83dd+44a45e+vger.kernel.org+lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu, 21 May 2026 12:01:17 +0800

memmap_init_zone_device() can spend a substantial amount of time
initializing large ZONE_DEVICE ranges because it repeats nearly
identical struct page setup for every PFN.

This series reduces that overhead in seven steps.

The first patch factors the reusable pieces out of
__init_zone_device_page() so later patches can share the same logic
without changing the existing slow path.

The second patch adds set_page_section_from_pfn(), so generic callers
can update section bits from a PFN without open-coding
SECTION_IN_PAGE_FLAGS checks.

The third patch adds a template-based fast path for ZONE_DEVICE head
pages. Instead of rebuilding the same struct page state for every PFN,
it prepares a reusable page template once and copies it to each
destination page.

The fourth patch extends the same template-based approach to compound
tails, so pfns_per_compound > 1 can also benefit from the fast path.

The fifth patch introduces memcpy_streaming() and
memcpy_streaming_drain() as a generic interface for write-once
streaming copies, with a memcpy() fallback for architectures that do
not provide a specialized backend.

The sixth patch extends x86 memcpy_flushcache() small fixed-size
fastpaths so struct-page-sized streaming copies can stay on the inline
path.

The last patch switches the zone-device template-copy path over to
memcpy_streaming(). It refreshes PFN-dependent fields in the reusable
template before each copy, keeps pageblock-aligned PFNs on regular
memcpy(), and drains streaming stores before later normal stores update
overlapping or dependent metadata.

The optimized path is disabled when the page_ref_set tracepoint is
enabled, sanitized builds remain on the slow path so their
instrumented stores are preserved, and the fast path falls back to the
existing slow path if sizeof(struct page) is not an integral number of
u64 words.

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
  Base(v7.1-rc3):
    First binding: 1486 ms
    Average of subsequent rebinds: 273.52 ms
  With patches 1-3 applied:
    First binding: 1422 ms
    Average of subsequent rebinds: 245.73 ms
  Full series:
    First binding: 1389 ms
    Average of subsequent rebinds: 111.08 ms

dax_pmem rebind, 100 GB devdax namespace, align=2097152
  Base(v7.1-rc3):
    First binding: 1515 ms
    Average of subsequent rebinds: 313.45 ms
  With patches 1-4 applied:
    First binding: 1422 ms
    Average of subsequent rebinds: 256.56 ms
  Full series:
    First binding: 1294 ms
    Average of subsequent rebinds: 110.24 ms

Li Zhe (7):
  mm: factor zone-device page init helpers out of
    __init_zone_device_page
  mm: add a set_page_section_from_pfn() helper
  mm: add a template-based fast path for zone-device page init
  mm: extend the template fast path to zone-device compound tails
  string: introduce memcpy_streaming() helpers
  x86/string: extend memcpy_flushcache() fixed-size fastpaths
  mm: use memcpy_streaming() in zone-device template copies

 arch/x86/include/asm/string_64.h | 100 +++++++++++++---
 include/linux/mm.h               |  19 ++-
 include/linux/string.h           |  18 +++
 mm/mm_init.c                     | 198 +++++++++++++++++++++++++++----
 4 files changed, 294 insertions(+), 41 deletions(-)

---
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

v1->v2:
- Move the pageblock-helper split into patch 1, and add a dedicated
  set_page_section_from_pfn() helper so generic callers no longer
  open-code SECTION_IN_PAGE_FLAGS handling. Suggested by Mike Rapoport.
- Drop the v1 32-bit gating and document instead that CONFIG_ZONE_DEVICE
  is 64-bit only because it depends on MEMORY_HOTPLUG. Suggested by
  Mike Rapoport.
- Replace the v1 BUILD_BUG_ON() struct page layout checks with a runtime
  fast-path eligibility check that falls back to the slow path when the
  layout is unsuitable. Suggested by Mike Rapoport.
- Rename the template fast-path helpers to zone_device_* names for
  clarity. Suggested by Mike Rapoport.
- Replace the v1 open-coded arch_optimize_store_u64()/drain() approach
  with a generic memcpy_streaming()/memcpy_streaming_drain() interface,
  and move the x86 optimization under memcpy_flushcache(). Suggested by
  Alistair Popple.
- Split the old v1 streaming-copy patch into three patches: introduce
  the generic helper, extend the x86 backend, and then switch mm over
  to the new interface. This is part of the memcpy-based rework
  suggested by Alistair Popple.
- Refresh the performance section and report whole-series results as
  series-level numbers.
- Fix a missing memcpy_streaming_drain() in the compound-page
  initialization path, following review feedback from Andrew Morton.

-- 
2.20.1
