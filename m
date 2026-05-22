Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA5839280C
	for <linux-arch@vger.kernel.org>; Fri, 22 May 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436203; cv=none; b=KyzAVzJcQUJNxSxqjDGQkNYFqofSm3JIvX9XMMSg+uPmCdElICt64CZQoqBZvjwgS36zrx0nWCxr45rYabhjMrtX+2L5ab4Zb0SBJtTBiIHh1/8qyQXE4kw1bqhxzFi/9KAFPppJYxNsn9+4utSlZhKGhL3wHayA9eHHcQPijI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436203; c=relaxed/simple;
	bh=X/hE1hO5sXT4ISKIuKrabgqu5qItUGb56mOAjmd/23U=;
	h=Subject:From:In-Reply-To:Cc:Message-Id:Content-Type:To:Date:
	 Mime-Version:References; b=hiJT0VgPUOOX3oKnRvvWXgN4Oi/KaZ7PcO4hbZnZQe6QCLEXUPWM/rcJgd9a9n+ZgIwAwQl5KZNyKlL/lmMrYoBtEyWTgaPbTkcs1p7Z9Pkg+VfJbUeqdLiuNb3CdfWThGkd4HH/hu2JhIOJ/CgIix6yxl9/4Kabyg9Vv16kw2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K4og7kt6; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K4og7kt6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779436195; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jxcBqSnTE8QGLvd7k0gAZTQfr15WCN3mLt1C6micdAg=;
 b=K4og7kt6gqblM70j41+tGVQJtYFeVHKvs0SxYRG2ebey1g1B3UGZV5qIjonVsEn/Bwcy6J
 T9Bc2bqdSdBUo+IQH5wiSwiaj3Yt99ysGcdGqZ9arezu/8sTEBu06CJ1JP8MJ24Rw+GoqW
 Ju3mddrydUeKNbVneT0dKWJbJav3IYRHrkgpcwE5Ilwli5XsTZydpv57I+w3KeH/Hbc01K
 lpULAtHWxnJb6HeYEVi6JqGZZ4bjtODp6D08ATU4uS8Upyp4xJ//bL2qAG2Y65/3mroxbo
 rqBtD2zxNDTjLkdtBNNKkZmMVZiQTVhT6rppm3L6alIGh920CNdrL2OPlfEksg==
Subject: Re: [PATCH v2 0/7] mm: speed up ZONE_DEVICE memmap initialization
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
In-Reply-To: <20260521152029.4299697d40ddc58c721bbafd@linux-foundation.org>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
Message-Id: <20260522074932.62311-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a100aa1+6b25f0+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>
Date: Fri, 22 May 2026 15:49:32 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521152029.4299697d40ddc58c721bbafd@linux-foundation.org>
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 15:20:29 -0700, akpm@linux-foundation.org wrote:

> On Thu, 21 May 2026 12:01:17 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:
> 
> > memmap_init_zone_device() can spend a substantial amount of time
> > initializing large ZONE_DEVICE ranges because it repeats nearly
> > identical struct page setup for every PFN.
> >
> > This series reduces that overhead in seven steps.
> 
> Cool, thanks, we all love speedups.
> 
> > The first patch factors the reusable pieces out of
> > __init_zone_device_page() so later patches can share the same logic
> > without changing the existing slow path.
> >
> > The second patch adds set_page_section_from_pfn(), so generic callers
> > can update section bits from a PFN without open-coding
> > SECTION_IN_PAGE_FLAGS checks.
> >
> > The third patch adds a template-based fast path for ZONE_DEVICE head
> > pages. Instead of rebuilding the same struct page state for every PFN,
> > it prepares a reusable page template once and copies it to each
> > destination page.
> >
> > The fourth patch extends the same template-based approach to compound
> > tails, so pfns_per_compound > 1 can also benefit from the fast path.
> >
> > The fifth patch introduces memcpy_streaming() and
> > memcpy_streaming_drain() as a generic interface for write-once
> > streaming copies, with a memcpy() fallback for architectures that do
> > not provide a specialized backend.
> >
> > The sixth patch extends x86 memcpy_flushcache() small fixed-size
> > fastpaths so struct-page-sized streaming copies can stay on the inline
> > path.
> >
> > The last patch switches the zone-device template-copy path over to
> > memcpy_streaming(). It refreshes PFN-dependent fields in the reusable
> > template before each copy, keeps pageblock-aligned PFNs on regular
> > memcpy(), and drains streaming stores before later normal stores update
> > overlapping or dependent metadata.
> >
> > The optimized path is disabled when the page_ref_set tracepoint is
> > enabled, sanitized builds remain on the slow path so their
> > instrumented stores are preserved, and the fast path falls back to the
> > existing slow path if sizeof(struct page) is not an integral number of
> > u64 words.
> >
> > Testing
> > =======
> >
> > Tests were run in a VM on an Intel Ice Lake server.
> >
> > Two PMEM configurations were used:
> >   - a 100 GB fsdax namespace configured with map=dev, which exercises
> >     the nd_pmem rebind path (pfns_per_compound == 1)
> >   - a 100 GB devdax namespace configured with align=2097152, which
> >     exercises the dax_pmem rebind path (pfns_per_compound > 1)
> >
> > For each configuration, the corresponding driver was unbound and
> > rebound 30 times. Memmap initialization latency was collected from the
> > pr_debug() output of memmap_init_zone_device().
> >
> > The first bind is reported separately, and the average of subsequent
> > rebinds is used as the steady-state result.
> 
> How closely does this workload resemble any real-world user workload?

Not directly. The unbind/rebind loop is mainly a controlled and
repeatable way to measure the memmap_init_zone_device() path with minimal
unrelated noise.

> > Performance
> > ===========
> >
> > nd_pmem rebind, 100 GB fsdax namespace, map=dev
> >   Base(v7.1-rc3):
> >     First binding: 1486 ms
> >     Average of subsequent rebinds: 273.52 ms
> >   With patches 1-3 applied:
> >     First binding: 1422 ms
> >     Average of subsequent rebinds: 245.73 ms
> >   Full series:
> >     First binding: 1389 ms
> >     Average of subsequent rebinds: 111.08 ms
> >
> > dax_pmem rebind, 100 GB devdax namespace, align=2097152
> >   Base(v7.1-rc3):
> >     First binding: 1515 ms
> >     Average of subsequent rebinds: 313.45 ms
> >   With patches 1-4 applied:
> >     First binding: 1422 ms
> >     Average of subsequent rebinds: 256.56 ms
> >   Full series:
> >     First binding: 1294 ms
> >     Average of subsequent rebinds: 110.24 ms
> 
> The improvements appear to range between "modest" and "large", but what
> I'd like to understand is how frequently real-world users are using
> these operations in real-world workloads.
> 
> IOW, (and this is always the bottom line), how valuable is this
> patchset to our users?

This is not a steady-state data-path optimization. Its value is in pmem
bring-up paths, and in our deployment we do have scenarios where
multiple pmem devices are hotplugged , so reducing this latency is useful
in practice for us.

> >   mm: factor zone-device page init helpers out of
> >     __init_zone_device_page
> >   mm: add a set_page_section_from_pfn() helper
> >   mm: add a template-based fast path for zone-device page init
> >   mm: extend the template fast path to zone-device compound tails
> >   string: introduce memcpy_streaming() helpers
> >   x86/string: extend memcpy_flushcache() fixed-size fastpaths
> >   mm: use memcpy_streaming() in zone-device template copies
> >
> >  arch/x86/include/asm/string_64.h | 100 +++++++++++++---
> >  include/linux/mm.h               |  19 ++-
> >  include/linux/string.h           |  18 +++
> >  mm/mm_init.c                     | 198 +++++++++++++++++++++++++++----
> >  4 files changed, 294 insertions(+), 41 deletions(-)
> 
> I won't take any action at this stage - let's await reviewer input.  If
> none is forthcoming then please remind me and I'll figure out what to
> do.
> 
> The ever-present reviewer called "Sashiko" has thoughts to offer:
> 
> 	https://sashiko.dev/#/patchset/20260521040124.10608-1-lizhe.67@bytedance.com
> 
> Please take a look, decide if there's useful material in there.

There is useful material there, mainly around patches 5 and 6.

The memcpy_streaming() x86 backend should be narrower, and the expanded
memcpy_flushcache() small-copy fastpath should keep naturally aligned
cases only and preserve forward movnti store order.

I'll address those points in the next revision and rerun the benchmarks.

Thanks,
Zhe
