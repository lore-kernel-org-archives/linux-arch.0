Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9CC3E3D99
	for <linux-arch@vger.kernel.org>; Mon, 18 May 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094654; cv=none; b=sBmPPmz3zlPv6r4b7NP845U6NXetlusaLsHkIruOKzsyAQeMVBMMY9rzJ62uXhYZ5dW6UhESfUmMbAvZR5G0CUEYDT+RveU/L6mi2JXfTN80Qhar4TkU1Teod7mOu+3TUIyRU8CFKGeMXykHc4fSeXtI7SUdaOF/pFzPiHQcEus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094654; c=relaxed/simple;
	bh=3WebVR9JAr5YyYyooKwGPrFHG221BzzgbpAEka5fRgE=;
	h=Cc:From:Message-Id:Mime-Version:In-Reply-To:Content-Type:Subject:
	 Date:To:References; b=bjaJyWZSGV+I28ynhQ4kNX4V8tUDvVSAKJna1y/w5GjaaNEYIfRrHrm7Nulz5ICAV8OZ/QB7u/mkhe8e8pYmAjqiXY6xcnFcZUPQAuQeACqremw3ZRBcjvz4ybtNxIWVVxsQKH5CgRYutfm20g4nfW3lVjxzN+UJMRJiL9U0DS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Pt5rS03G; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Pt5rS03G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779094646; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+jP3zYR2Gd1m9hwwG4m0TQaKDhI1orzMcn5CiNLD3r8=;
 b=Pt5rS03G03WcUrKHLaQ8U8ZYMuhtCuuLcDz4MnyVqRhBV5yP6Tohl5xIZ2mnkIGHPzXTVw
 U5EgGa1I3CCQajz/YEnNcouYfOCh45Mh1BuQ1Zm1GOTcN5jg/J0I3D1jQsGYGo6uct8AJT
 QQpICpu5SIV4swgI0/aAflSIej6ahE0b3kJ42qBfmr5FSYQ2R/ayB9IKyKrbeDvycLxCR5
 C4BXl5hs+w9zJelDXL/PSBLVVQ7GmSj7B2f+ExK2Eqws/ulbuIoEad64mhU5ljartdTgqW
 D7sMRJGKivRdYJVPt71Jw9wEKos81I4SWAsgXAzFWqJXYcRrTkp8qZd7DbEvGQ==
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a0ad474+55a486+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260518085700.69849-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <agqwZaEtwXg4-O9z@kernel.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 0/4] mm: speed up ZONE_DEVICE memmap initialization
Date: Mon, 18 May 2026 16:57:00 +0800
To: <rppt@kernel.org>
References: <agqwZaEtwXg4-O9z@kernel.org>
X-Mailer: git-send-email 2.45.2

On Mon, 18 May 2026 09:23:33 +0300, rppt@kernel.org wrote:

> Hi,
> 
> On Fri, May 15, 2026 at 04:20:41PM +0800, Li Zhe wrote:
> > memmap_init_zone_device() can spend a substantial amount of time
> > initializing large ZONE_DEVICE ranges because it repeats nearly
> > identical struct page setup for every PFN.
> > 
> > This series reduces that overhead in four steps.
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
> > 
> > Performance
> > ===========
> > nd_pmem rebind, 100 GB fsdax namespace, map=dev
> >   Base(v7.1-rc3):
> >     First binding: 1486 ms
> >     Average of subsequent rebinds: 273.52 ms
> >   Full series:
> >     First binding: 1272 ms
> >     Average of subsequent rebinds: 104.59 ms
> > 
> > dax_pmem rebind, 100 GB devdax namespace, align=2097152
> >   Base(v7.1-rc3):
> >     First binding: 1515 ms
> >     Average of subsequent rebinds: 313.45 ms
> >   Full series:
> >     First binding: 1286 ms
> >     Average of subsequent rebinds: 116.93 ms
> 
> This is really good improvement!
> 
> It would be also interesting to see how the template approach would improve
> "normal" memory map initialization.

I also experimented with this approach earlier. Unfortunately, in the
normal memory map initialization path, functions such as
deferred_free_pages() are invoked shortly after struct page
initialization, and this function performs both read and write accesses
to members of the struct page.

Non-temporal stores via MOVNTI are primarily beneficial for streaming
write operations, where the cache lines written are not expected to be
reused by the CPU in the near future. In this case, however, data
written using MOVNTI is immediately accessed again through regular load
and store instructions. This results in an access pattern that resembles
a write-then-reuse workload rather than a pure streaming store.

Consequently, non-temporal stores do not deliver the expected reduction
in cache pollution, and using MOVNTI provides no measurable performance
benefit for this particular workload.

That said, a template-based approach can still accelerate initialization.
Based on measurements from this patchset, it should improve performance
on the generic path by roughly 10%. I would appreciate feedback on
whether such an optimization is still considered useful.

Thanks,
Zhe
