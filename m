Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F000126B08F
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853091; cv=none; b=U+mHt0oj+h7WWkgWvM1vLUx5ZantfeT0f0mWEAOtDhRmY/Ih6bK0gWktaoCByhhrfGWvsh/F8l61/CFABGA0pzZdvTyvMldZa9kNfWlHYh24DG7j8c101ADGDdGfeKsmWvVdOF+O22tVqIRz9ZxEB8iYB6EDAekbEqrwz3IsnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853091; c=relaxed/simple;
	bh=oBHrxFElCzNutCNMmENjLg+wOg2FchLkYvGXhTz/KKo=;
	h=Message-Id:Mime-Version:From:Subject:Date:Content-Type:Cc:To; b=Plr83D5vAsOQpVlkfEedMKu1U+nP1T1bwmAldaS+/sGuIdCHkTdv1j3uNMpkKjIrv/6Q5IYMpCnXMvdtG1E5slmh6/wSX7LjoAChwll7LuZpC0wd4qpXFLHRpJSn07aVneK8k+8ZH9jil+Xa6+WvLGQMx8Vp0X2kzckFAAOG9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iBMN3MJx; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iBMN3MJx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779853077; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/qdLUAhg4q/WASG3TkbS7LjyH1II/YAwBuKSGkt3vIY=;
 b=iBMN3MJxkfS8l74oUA/EbdOyXWaLolQcHzhvXGOoh8cPrbyXCFZF0Njz3j5sF7yeiv/ADU
 uPrjmvIBgh/SvgOB8E6eIoMKhzh7reMadrja2wSx+kRdhdfLsCR073+MR2mH//0UEzFywj
 NpvcAgG1nMPsfvig9K08zPy2k1hfRqWXv4oLeAnSqkehA3WZM4j2CV+jehx7uIAffLGmLm
 f0n8bUp27usINwiYpgdDWfqyY7JIXiGs8H5ZI04raTGozepz2TrLkLfEZmWEvBGFZV49vO
 pWJJEiOut4zGAaFjDNhq5o1No38CZK3wrrKIV0+GlRY8fUUFn5FPpQovWbB9uQ==
Message-Id: <20260527033636.28231-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v3 0/8] mm: speed up ZONE_DEVICE memmap initialization
Date: Wed, 27 May 2026 11:36:28 +0800
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a166713+4b5efd+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>

This series reduces latency in paths which create or recreate
ZONE_DEVICE memmaps. Pmem hotplug is a concrete example.

memmap_init_zone_device() can spend a substantial amount of time
initializing large ZONE_DEVICE ranges because it repeats nearly
identical struct page setup for every PFN.

The series addresses that overhead in eight patches.

The first patch updates a stale comment in __init_zone_device_page() so
it matches the current ZONE_DEVICE refcount rules.

The second patch factors the reusable pieces out of
__init_zone_device_page() so later patches can share the same logic
without changing the existing slow path.

The third patch adds set_page_section_from_pfn(), so generic callers
can update section bits from a PFN without open-coding
SECTION_IN_PAGE_FLAGS handling.

The fourth patch adds a template-based fast path for ZONE_DEVICE head
pages. Instead of rebuilding the same struct page state for every PFN,
it prepares one reusable head-page template through the existing slow
path, refreshes the PFN-dependent fields before each copy, and then
copies that template into the destination page.

The fifth patch extends the same template-based approach to compound
tails, so pfns_per_compound > 1 can also benefit from the fast path.

The sixth patch introduces memcpy_streaming() and
memcpy_streaming_drain() as a generic interface for write-once copies,
with a memcpy() fallback for architectures that do not provide a
specialized backend, or for transfers which an architecture-specific
backend cannot safely handle with non-temporal stores.

The seventh patch extends x86 memcpy_flushcache() small fixed-size
fastpaths for naturally aligned copies, so common struct-page-sized
streaming copies can stay on the inline movnti path while preserving
forward store order.

The last patch switches the zone-device template-copy path over to
memcpy_streaming(). It keeps pageblock-aligned PFNs on regular memcpy()
so pageblock setup can immediately read page metadata back through the
usual helpers, and it drains streaming stores before later normal
stores update overlapping or dependent compound-page metadata.

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
rebinds is used as the repeat-run result.

Performance
===========

nd_pmem rebind, 100 GB fsdax namespace, map=dev
  Base(v7.1-rc3):
    First binding: 1486 ms
    Average of subsequent rebinds: 273.52 ms
  With patches 1-4 applied:
    First binding: 1422 ms
    Average of subsequent rebinds: 246.65 ms
  Full series:
    First binding: 1285 ms
    Average of subsequent rebinds: 114.31 ms

dax_pmem rebind, 100 GB devdax namespace, align=2097152
  Base(v7.1-rc3):
    First binding: 1515 ms
    Average of subsequent rebinds: 313.45 ms
  With patches 1-5 applied:
    First binding: 1422 ms
    Average of subsequent rebinds: 240.42 ms
  Full series:
    First binding: 1331 ms
    Average of subsequent rebinds: 99.37 ms

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

 arch/x86/include/asm/string_64.h | 157 ++++++++++++++++++++++---
 include/linux/mm.h               |  19 ++-
 include/linux/string.h           |  20 ++++
 mm/mm_init.c                     | 195 +++++++++++++++++++++++++++----
 4 files changed, 352 insertions(+), 39 deletions(-)

---
v2: https://lore.kernel.org/all/20260521040124.10608-1-lizhe.67@bytedance.com/
v1: https://lore.kernel.org/all/20260515082045.63029-1-lizhe.67@bytedance.com/

Changelogs:

v2->v3:
- Add a leading comment-only cleanup patch to fix the stale ZONE_DEVICE
  refcount comment, so later refactoring patches no longer carry that
  stale wording forward.
- Rename the refcount-policy helper to pagemap_resets_refcount() and
  make it a bool predicate. Suggested by Mike Rapoport.
- Update the reusable template in place from the first template
  fast-path patch onward, so later patches only change the copy
  primitive instead of introducing an intermediate post-copy fixup
  step. Suggested by Mike Rapoport.
- Clean up helper indentation and use early continue in the
  compound-tail loop. Suggested by Mike Rapoport.
- Narrow the x86 memcpy_streaming() backend to transfers that can stay
  entirely on the non-temporal store path, keeping zero-length and
  unaligned cases on memcpy(). Suggested by Andrew Morton.
- Restrict the x86 memcpy_flushcache() small-copy fastpath to naturally
  aligned cases, add volatile/memory clobbers, and preserve forward
  movnti store order. Suggested by Andrew Morton.
- Drop the obsolete struct page size/alignment eligibility check from
  the template fast path now that the intermediate patches use
  memcpy() and the streaming backend has a safe fallback.
- Refresh the benchmark results.

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
