Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E973FAE07
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833279; cv=none; b=E19/OAS2h3tCP+h26EK0vbp790W2eASmMTt5HSlQchZ0ShkwTcbzZtNenkvD1SHNBVGekdjwF/TF17y1yBH1PWiXJj2FjEQ4w+5lEvIIGdLFYJZ5sHw8MFNjEmvYS91io43pgjU9ghkUXXOUT56F2VKZa1NI5+Ff+znhL+95D0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833279; c=relaxed/simple;
	bh=6hQz6UAEbCA9+Fiy1NxKGqiEpxvmT6xTvGi9oCiJW+c=;
	h=Content-Type:To:Cc:From:Date:Mime-Version:Message-Id:Subject; b=EW4FaB1rZOrVKOusgl8YbvNwfIdUW/7CHxNDHD1P8ZGlC6/f4qiDZq7PRwBiGHB2HS27+hE44xWOu7YY0dT9BjjaEwKr8yBXigrOnU6hwblq0/rldYQDPJ6kwYdafSn6eXrqbrpD8tttuhVQmadNdWuRbq8EI0vblU9bk4rstGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UtON5KvM; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UtON5KvM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778833266; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sDPgw3TE7pwHq9Vr5cZlrNhK9riXREs8CXWuvtHX3FE=;
 b=UtON5KvMYqi3JfKiKwNbkW21vv4HJkzV1TFrFVNjxEhTmIrT5uZEaCfpJWL/eMVEW/nm5r
 NBwHQ+tJ+nn/bVbYSyk7bFUqxGtLZlGMUHJhouzr5O/WMlrV2YoqAitUCu2z6q/8fI4JdA
 iWwmqGkjt5nwwhULH1Vd8Yv/n9Z1cWCYLOzOBhQNpaNvzk39ibdqB01TDB7L1kO2VOFcM7
 oO2xpmN5IfvrFulhH/+syUm9HWbXOG94G7Lat5EjtgpjzZJDoTV6HAvf/wzl+YTgg/l+ny
 vtdQ/YcxZa1JNQXkYKM0yFCEeHVNqX0ciQOdNpHmuxipx36zUbQi3jLoaWRvAQ==
Content-Type: text/plain; charset=UTF-8
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <arnd@arndb.de>, <rppt@kernel.org>, 
	<akpm@linux-foundation.org>, <david@kernel.org>
Cc: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a06d770+93604e+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Fri, 15 May 2026 16:20:41 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <20260515082045.63029-1-lizhe.67@bytedance.com>
Subject: [PATCH 0/4] mm: speed up ZONE_DEVICE memmap initialization
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

memmap_init_zone_device() can spend a substantial amount of time
initializing large ZONE_DEVICE ranges because it repeats nearly
identical struct page setup for every PFN.

This series reduces that overhead in four steps.

The first patch factors the reusable pieces out of
__init_zone_device_page() so later patches can share the same logic
without changing the existing slow path.

The second patch adds a template-based fast path for zone-device head
pages on 64-bit builds. Instead of rebuilding the same struct page state
for every PFN, it prepares a reusable page template once and copies it
to each destination page.

The third patch extends the same template-based approach to compound
tails, so pfns_per_compound > 1 can also benefit from the fast path.

The last patch introduces arch_optimize_store_u64() and
arch_optimize_store_drain(), with a generic fallback and an x86-64
MOVNTI/SFENCE implementation, and uses them in the template-copy hot
path. It also refreshes the PFN-dependent fields in the reusable
template before each copy, so the hot path remains a fixed-offset store
sequence without post-copy normal stores to the destination page.

The optimized path is intentionally limited to 64-bit builds for now.
The current fast path copies struct page as a sequence of fixed-offset
u64 stores and relies on the set of struct page layouts used by current
64-bit configurations. Extending the same optimization to 32-bit builds
would need a separate store layout scheme and its own validation, so
this series keeps 32-bit on the existing slow path.

The helper interface is also meant to leave room for other
architecture-specific backends. This series only adds an x86-64
implementation because that is the only platform I was able to measure.
Other architectures, including arm64, may be able to add their own
optimized backend in follow-up work. But I do not currently have arm64
hardware available to validate that.

To preserve observability, the optimized path is disabled when the
page_ref_set tracepoint is enabled, because the template-copy path
bypasses set_page_count() and would otherwise hide that trace event.

Patch summary:
  1. mm: factor zone-device page init helpers out of __init_zone_device_page
  2. mm: add a template-based fast path for zone-device page init
  3. mm: extend the template fast path to zone-device compound tails
  4. mm: use arch store helpers in zone-device template copies

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
  Full series:
    First binding: 1272 ms
    Average of subsequent rebinds: 104.59 ms

dax_pmem rebind, 100 GB devdax namespace, align=2097152
  Base(v7.1-rc3):
    First binding: 1515 ms
    Average of subsequent rebinds: 313.45 ms
  Full series:
    First binding: 1286 ms
    Average of subsequent rebinds: 116.93 ms

Li Zhe (4):
  mm: factor zone-device page init helpers out of
    __init_zone_device_page
  mm: add a template-based fast path for zone-device page init
  mm: extend the template fast path to zone-device compound tails
  mm: use arch store helpers in zone-device template copies

 arch/x86/include/asm/struct_page_init.h |  28 +++
 include/asm-generic/Kbuild              |   1 +
 include/asm-generic/struct_page_init.h  |  17 ++
 mm/mm_init.c                            | 260 +++++++++++++++++++++---
 4 files changed, 280 insertions(+), 26 deletions(-)
 create mode 100644 arch/x86/include/asm/struct_page_init.h
 create mode 100644 include/asm-generic/struct_page_init.h

-- 
2.20.1
