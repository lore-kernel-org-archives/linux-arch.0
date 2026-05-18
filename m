Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B63E0C62;
	Mon, 18 May 2026 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085421; cv=none; b=uVn23o7a//brHsNpJ7a8/klSLmFe/45g3LZTwx+A3YaHLCMgYpi8pEplrQ7C/2aEYxxKaJZIU9g8nqGu/JCvN89/u6Gr46/uN8VKn22wCAVLQAOW+RxWuaOviFPivjjjviv3I1RPZOVqNmnKnoYbnJ3j5ASGZrSYWEb1C7yiwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085421; c=relaxed/simple;
	bh=afZ+tMUxJ/YdqFH0mgRBOco1DIIvYJ7z7LVPpWe/EUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOrrILjJmIPJbMgTSsycoRPbUATv/w5OoQIMrPXXs+7EWUvqruOp2YjW6hRzPa7Q3OfoGjesKqe3GKHPoEfrn5rHvcoHroTaGzWbzWs/iTOWRFIfWMEdYwQPNWTS5RcrdQOAUnTUCZvVNywVGUPrIcEUhBpxeaVZUkFBpNozE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUEH/P1K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUEH/P1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5F9C2BCB7;
	Mon, 18 May 2026 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779085421;
	bh=afZ+tMUxJ/YdqFH0mgRBOco1DIIvYJ7z7LVPpWe/EUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUEH/P1Kx3Q5Wt9ATuJMURyLg7WA6PZzOOyy+9io9nzld8PyN5oFZbFTTUz4qhd2H
	 zbDpALV216Y3Qk++BSUGMrDDiMs/QhoLOA6PxeBZZ4MJ9Eta8Yw/axDP1eaEB0HtV7
	 TQ8sqng3fzi+gkLGjRnCYYaTb1btjqKIx7SJhy+SWu4MLx7OtVTkuZ6l6jAaew9Ycf
	 grs9erXpmzXoNucL6Pbgo08AG/QUjcv7D+2NNesQAV2Le492E4VvnzCm3vie5Ma25+
	 Ewni5Hngd6wrOUzv0G+ZP4OUH8bfxOUpZBEVHDXQIq38UQpqsshbiB0qvxLz/9YXtg
	 QATOLGhAlgijg==
Date: Mon, 18 May 2026 09:23:33 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, arnd@arndb.de,
	akpm@linux-foundation.org, david@kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm: speed up ZONE_DEVICE memmap initialization
Message-ID: <agqwZaEtwXg4-O9z@kernel.org>
References: <20260515082045.63029-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515082045.63029-1-lizhe.67@bytedance.com>

Hi,

On Fri, May 15, 2026 at 04:20:41PM +0800, Li Zhe wrote:
> memmap_init_zone_device() can spend a substantial amount of time
> initializing large ZONE_DEVICE ranges because it repeats nearly
> identical struct page setup for every PFN.
> 
> This series reduces that overhead in four steps.
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
> 
> Performance
> ===========
> nd_pmem rebind, 100 GB fsdax namespace, map=dev
>   Base(v7.1-rc3):
>     First binding: 1486 ms
>     Average of subsequent rebinds: 273.52 ms
>   Full series:
>     First binding: 1272 ms
>     Average of subsequent rebinds: 104.59 ms
> 
> dax_pmem rebind, 100 GB devdax namespace, align=2097152
>   Base(v7.1-rc3):
>     First binding: 1515 ms
>     Average of subsequent rebinds: 313.45 ms
>   Full series:
>     First binding: 1286 ms
>     Average of subsequent rebinds: 116.93 ms

This is really good improvement!

It would be also interesting to see how the template approach would improve
"normal" memory map initialization.
 
> Li Zhe (4):
>   mm: factor zone-device page init helpers out of
>     __init_zone_device_page
>   mm: add a template-based fast path for zone-device page init
>   mm: extend the template fast path to zone-device compound tails
>   mm: use arch store helpers in zone-device template copies
> 
>  arch/x86/include/asm/struct_page_init.h |  28 +++
>  include/asm-generic/Kbuild              |   1 +
>  include/asm-generic/struct_page_init.h  |  17 ++
>  mm/mm_init.c                            | 260 +++++++++++++++++++++---
>  4 files changed, 280 insertions(+), 26 deletions(-)
>  create mode 100644 arch/x86/include/asm/struct_page_init.h
>  create mode 100644 include/asm-generic/struct_page_init.h
> 
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.
