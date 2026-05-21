Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674981A9B58;
	Thu, 21 May 2026 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779402031; cv=none; b=lh2ZYtDkzWhlJmrACXazT5Jvguub2Bucw1oA6xAe/jthMic8uZO3egjWL0Xs7xd3mOofbVJubFTyzdk5rr3apdyXbkyfGMaOj9YGtfT2CTjMX/FFRK4GVYCiPRewpkq1GarUT4dosuUFZ+0NhqkqCCXrvg0l9LCdqRoQep/y59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779402031; c=relaxed/simple;
	bh=s55yBuwnQ0FKdjtX/1svttVTQOxnGfS+c+wiaeLps2k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G1uFrbnZPgfHF/VPSKNPqXldO9VUEPFev997mxuHbDLcOsetXDdhRN5HlVlN7EVQMymP+OWqkIrjaoouxv/mNICqhX5K/RcwQRj99lLNYIKqLqnkFuzdf22bIpmVfLj987NLpX6afx7ZthxVaO2UyvEeo0z+fJqZSh7HhD6hSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZDiCZ6j1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZDiCZ6j1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7611F000E9;
	Thu, 21 May 2026 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779402029;
	bh=tFL4uh44e2osjW96okVmaXqXdngbMfy8bfdPJ/HYlLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZDiCZ6j1CFm38N3scsO8Zkw7tw4OdhWhXcSz8PPSTNuBEYjrYpcdrAnh35DRc3SJ8
	 tiyi6snhVvSydpoFs3zRqE8gG+qkCCoZuRK3DKra87F9zxqMJZsJkCd7Sib2NIshaD
	 xdHfK9Nj3gRo305i/noMvbpBiV+KSeSUMPN2dWTs=
Date: Thu, 21 May 2026 15:20:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <david@kernel.org>, <mingo@redhat.com>,
 <rppt@kernel.org>, <tglx@kernel.org>, <kees@kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <x86@kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] mm: speed up ZONE_DEVICE memmap initialization
Message-Id: <20260521152029.4299697d40ddc58c721bbafd@linux-foundation.org>
In-Reply-To: <20260521040124.10608-1-lizhe.67@bytedance.com>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 12:01:17 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> memmap_init_zone_device() can spend a substantial amount of time
> initializing large ZONE_DEVICE ranges because it repeats nearly
> identical struct page setup for every PFN.
> 
> This series reduces that overhead in seven steps.

Cool, thanks, we all love speedups.

> The first patch factors the reusable pieces out of
> __init_zone_device_page() so later patches can share the same logic
> without changing the existing slow path.
> 
> The second patch adds set_page_section_from_pfn(), so generic callers
> can update section bits from a PFN without open-coding
> SECTION_IN_PAGE_FLAGS checks.
> 
> The third patch adds a template-based fast path for ZONE_DEVICE head
> pages. Instead of rebuilding the same struct page state for every PFN,
> it prepares a reusable page template once and copies it to each
> destination page.
> 
> The fourth patch extends the same template-based approach to compound
> tails, so pfns_per_compound > 1 can also benefit from the fast path.
> 
> The fifth patch introduces memcpy_streaming() and
> memcpy_streaming_drain() as a generic interface for write-once
> streaming copies, with a memcpy() fallback for architectures that do
> not provide a specialized backend.
> 
> The sixth patch extends x86 memcpy_flushcache() small fixed-size
> fastpaths so struct-page-sized streaming copies can stay on the inline
> path.
> 
> The last patch switches the zone-device template-copy path over to
> memcpy_streaming(). It refreshes PFN-dependent fields in the reusable
> template before each copy, keeps pageblock-aligned PFNs on regular
> memcpy(), and drains streaming stores before later normal stores update
> overlapping or dependent metadata.
> 
> The optimized path is disabled when the page_ref_set tracepoint is
> enabled, sanitized builds remain on the slow path so their
> instrumented stores are preserved, and the fast path falls back to the
> existing slow path if sizeof(struct page) is not an integral number of
> u64 words.
> 
> Testing
> =======
> 
> Tests were run in a VM on an Intel Ice Lake server.
> 
> Two PMEM configurations were used:
>   - a 100 GB fsdax namespace configured with map=dev, which exercises
>     the nd_pmem rebind path (pfns_per_compound == 1)
>   - a 100 GB devdax namespace configured with align=2097152, which
>     exercises the dax_pmem rebind path (pfns_per_compound > 1)
> 
> For each configuration, the corresponding driver was unbound and
> rebound 30 times. Memmap initialization latency was collected from the
> pr_debug() output of memmap_init_zone_device().
> 
> The first bind is reported separately, and the average of subsequent
> rebinds is used as the steady-state result.

How closely does this workload resemble any real-world user workload?

> Performance
> ===========
> 
> nd_pmem rebind, 100 GB fsdax namespace, map=dev
>   Base(v7.1-rc3):
>     First binding: 1486 ms
>     Average of subsequent rebinds: 273.52 ms
>   With patches 1-3 applied:
>     First binding: 1422 ms
>     Average of subsequent rebinds: 245.73 ms
>   Full series:
>     First binding: 1389 ms
>     Average of subsequent rebinds: 111.08 ms
> 
> dax_pmem rebind, 100 GB devdax namespace, align=2097152
>   Base(v7.1-rc3):
>     First binding: 1515 ms
>     Average of subsequent rebinds: 313.45 ms
>   With patches 1-4 applied:
>     First binding: 1422 ms
>     Average of subsequent rebinds: 256.56 ms
>   Full series:
>     First binding: 1294 ms
>     Average of subsequent rebinds: 110.24 ms

The improvements appear to range between "modest" and "large", but what
I'd like to understand is how frequently real-world users are using
these operations in real-world workloads.

IOW, (and this is always the bottom line), how valuable is this
patchset to our users?

>   mm: factor zone-device page init helpers out of
>     __init_zone_device_page
>   mm: add a set_page_section_from_pfn() helper
>   mm: add a template-based fast path for zone-device page init
>   mm: extend the template fast path to zone-device compound tails
>   string: introduce memcpy_streaming() helpers
>   x86/string: extend memcpy_flushcache() fixed-size fastpaths
>   mm: use memcpy_streaming() in zone-device template copies
> 
>  arch/x86/include/asm/string_64.h | 100 +++++++++++++---
>  include/linux/mm.h               |  19 ++-
>  include/linux/string.h           |  18 +++
>  mm/mm_init.c                     | 198 +++++++++++++++++++++++++++----
>  4 files changed, 294 insertions(+), 41 deletions(-)

I won't take any action at this stage - let's await reviewer input.  If
none is forthcoming then please remind me and I'll figure out what to
do.

The ever-present reviewer called "Sashiko" has thoughts to offer:

	https://sashiko.dev/#/patchset/20260521040124.10608-1-lizhe.67@bytedance.com

Please take a look, decide if there's useful material in there.

