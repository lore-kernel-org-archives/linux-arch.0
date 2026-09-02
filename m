Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B1282F1F;
	Wed,  2 Sep 2026 04:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788322748; cv=none; b=USHAEyca8t4SBpA6DpyV7Dwu1mV+cQGfe5/GyKV/o1yomOMV0Xaa3lAabc+AJi+wX+bL0M2azB4y6B1U8WE/h/+XKbVgeZFERKLMt4FTyaOh/52aYWsOxaifwgkRU7f+Zd+vqhCMHqjnmA93O4MgxwGNh83Z9FDIOfhyFiuIiLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788322748; c=relaxed/simple;
	bh=5V/z/Eq8Rg2OiBdCmsA9M9wG3jYJRudSZaq9q9mBzC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6WITDamvZ/6i+O8iwBh63sYsoaUI91mJE4WZWmLyHTcmC8k+bb5dSdjtaagsCwguShjNVdmV+pfFrDpmeV2HgA4mXsRa7l+XCdwMOKvzxeMNRCmoypmSBYkJCqogO32O2syMCQQ9gBtG11L1L6MFyCvLwOTVdjGUdmAZ0Vn9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzzt1f9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzzt1f9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B1A1F000E9;
	Wed,  2 Sep 2026 04:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788322745;
	bh=43iYBd+5tkBDbCmBuYzijZla7qQPqLGtI/WeTFqT7iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zzzt1f9DAyv6cX+5revKYxP0iKU1GMsyF+WqyOiJJfw4HO63HHnyvop1Xi473zRNH
	 5IH3H3WUyW8fUUc6Xhpo2bYOb041oJWG/v/zxO8firAifnSAjZfp8Rc50rUSHD2lCc
	 kLtvGfDK4vCxfomPFpezg1oF+GEb8cbxsjwL9rfXArJJT91CCusvHnXsKxaEzoUIlA
	 q1uGfV4StuTb5t1Uj0485XpcoYiNpIY9nZmxFHJ4trxhtxKk5R7xzr8s3ZeSqOuAlB
	 Hp4WyaJDa796rHz+KEQ3KZ7sfH9pQvziy6ylWwHLy0qOQsyIBYiBeIb4gvE8YaLIak
	 mNxrBkjeiLX8g==
Date: Wed, 2 Sep 2026 07:18:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com,
	david@kernel.org, kees@kernel.org, mingo@redhat.com,
	muchun.song@linux.dev, tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v11 4/7] mm: extend the template fast path to zone-device
 compound tails
Message-ID: <apejsLXJGvV9sxOt@kernel.org>
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
 <20260831111638.76012-5-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831111638.76012-5-lizhe.67@bytedance.com>

On Mon, Aug 31, 2026 at 07:16:35PM +0800, Li Zhe wrote:
> The template fast path from the previous patch only accelerates head
> pages. Compound tails in memmap_init_compound() still go through the
> normal initialization path one by one.
> 
> Build separate head and tail templates and reuse one prepared tail
> template across the tail pages in a compound range. Head pages preserve
> the existing refcount policy, while compound tails always start with a
> refcount of 0 after prep_compound_tail().
> 
> This extends the template-copy fast path to pfns_per_compound > 1.
> Tail-page PFN-dependent fields are refreshed in the reusable tail
> template before each copy.
> 
> Do not keep a separate non-template fallback for compound tails either.
> These pages are still under memmap initialization, and the
> initialization-time refcount updates are not part of the observable
> lifetime of pages handed out later.
> 
> The impact is controlled for the same reason as for head pages. The
> first tail page still seeds the reusable tail template through the
> normal tail initialization sequence, and the copied tail pages have the
> same final initialized state except for the PFN-dependent fields
> refreshed before each copy.
> 
> Tested in a VM with a 100 GB devdax namespace (align=2097152) on Intel
> Ice Lake server. This test exercises the dax_pmem rebind path and
> measures memmap initialization latency.
> 
> Test procedure:
> Unbind and rebind the dax_pmem driver 30 times, collect memmap
> initialization time from the pr_debug() output of
> memmap_init_zone_device().
> 
> Base(v7.3-rc1):
>   Average of rebinds for dax_pmem driver: 191.20 ms
> 
> With this patch and its prerequisites applied:
>   Average of rebinds for dax_pmem driver: 176.87 ms
> 
> This reduces the average memmap initialization time measured during
> rebind from 191.20 ms to 176.87 ms, or about 7.5%.
> 
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

-- 
Sincerely yours,
Mike.
