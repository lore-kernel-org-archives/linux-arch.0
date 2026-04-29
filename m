Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE2D34CFCF;
	Wed, 29 Apr 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473762; cv=none; b=Vf4SNW9ILOt1dM2M+PidC2WD001WZitJks2AKnNZq3iFikBwuXZ7u90D9qExPGBdtjSTZd7f1EsogWyzdGdQIPbjAnkDHIFYw2eeDreUcIwm+sC9DtT04IpZwgkhkazuQrFFStvhcDCvx+2JOCOoPzxBiHMafn6uXVEWFfMpdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473762; c=relaxed/simple;
	bh=p++YllAgo3zKlnyl/JQIUjXXYurKVSfK85qEuqMWRv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ummqzr5V2VcSLfA3ivK/7KZIo/nv3+9MwxHR39aiDH1XHzL62nQATLTRoHP6Igv1E5m906m3CPhFcxL89WuYiBCkPxuPZo9McdscQJWafUvKycrfazBjFiE55DdAkqfKhCkxe9/xwTCeYr4nziCLI26IpNFCIcRE3b4rEwYCq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FNOpvnT2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FNOpvnT2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0C721596;
	Wed, 29 Apr 2026 07:42:34 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5382F3F763;
	Wed, 29 Apr 2026 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777473760; bh=p++YllAgo3zKlnyl/JQIUjXXYurKVSfK85qEuqMWRv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNOpvnT2UnIDLx7xLrJ9QrwaaYb4fg3fyxTc0TEQRFOMlUvuNl+1e8Ny4+tSZcY5P
	 7Xhzadyb/ODwynFJNTOFnI7gXLtYxd9vb+KM5pMPk/g1MWqS+8I+7rx2MpEaX/BN7e
	 O0UOeItO/ucZDQBINLlsJiv+AC75tqqWDSlu9kj8=
Date: Wed, 29 Apr 2026 15:42:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, urezki@gmail.com,
	kees@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, arnd@arndb.de,
	Muhammad Usama Anjum <usama.anjum@arm.com>, ljs@kernel.org,
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, tglx@kernel.org,
	mathieu.desnoyers@efficios.com, linux-arch@vger.kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v4 1/3] vmalloc: add __GFP_SKIP_KASAN support
Message-ID: <afIY0OOqPezzTVBt@arm.com>
References: <20260429102704.680174-1-dev.jain@arm.com>
 <20260429102704.680174-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429102704.680174-2-dev.jain@arm.com>

On Wed, Apr 29, 2026 at 03:57:02PM +0530, Dev Jain wrote:
> From: Muhammad Usama Anjum <usama.anjum@arm.com>
> 
> For allocations that will be accessed only with match-all pointers
> (e.g., kernel stacks), setting tags is wasted work. If the caller
> already set __GFP_SKIP_KASAN, skip tag setting of vmalloc pages.
> 
> Before this patch, __GFP_SKIP_KASAN wasn't being used with vmalloc
> APIs. So it wasn't being checked. Now its being checked and acted
> upon. Other KASAN modes are unchanged because __GFP_SKIP_KASAN is
> ignored for them in the page allocator, and in vmalloc too we ignore
> this flag for them.
> 
> This is a preparatory patch for optimizing kernel stack allocations.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  include/linux/gfp_types.h |  6 +++---
>  mm/vmalloc.c              | 13 +++++++++----
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 6c75df30a281d..c2bd723c8ec62 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -281,9 +281,9 @@ enum {
>   *
>   * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
>   * Used for userspace and vmalloc pages; the latter are unpoisoned by
> - * kasan_unpoison_vmalloc instead. For userspace pages, results in
> - * poisoning being skipped as well, see should_skip_kasan_poison for
> - * details. Only effective in HW_TAGS mode.
> + * kasan_unpoison_vmalloc instead. If passed to vmalloc, kasan_unpoison_vmalloc
> + * is skipped too. For userspace pages, results in poisoning being skipped as
> + * well, see should_skip_kasan_poison for details. Only effective in HW_TAGS mode.

Nit: keep the comment line length to less than 80, ideally close to the
comments above (for esthetic reasons).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
