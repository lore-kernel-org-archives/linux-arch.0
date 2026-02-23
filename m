Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065DB1D54FA;
	Mon, 23 Feb 2026 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860670; cv=none; b=Ctxl+hQE2X+DKUnxpD9ec5Xbru3UwreKIcNz230pS9E/UxgVV0g0rg+6kcd2K3GmzZHtJ1Fz+0p1lynSGuwTT81/ppzm/j2pVCNUlzEp2M8dYEUpZs53rwwG2RF6KGVViZoHX0QkZQuWiiD8y2MHHCdDGYRRGQCk1OcSKiYwgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860670; c=relaxed/simple;
	bh=SXZbasoq/CXrbVuU7cwQOSmYwvFlNuPnKTKASQS2bPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5UjXTEiGsgbJdXmAeRAMiAuwMx5RNVVd1XXzfiSqkBmWwRaFlhJMkxO2NhhyNUQbvXSj4LDN9m5jHsM54lTfZ7R39XpyZGkMjk7OQLRaM22H3DoZvJkRSunTsFNktO4STSDcCC+VH8ItlZvV0HBZl7xwmVJYQFgPKDJAMBDnCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoA8KAg+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoA8KAg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771860668; x=1803396668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SXZbasoq/CXrbVuU7cwQOSmYwvFlNuPnKTKASQS2bPo=;
  b=FoA8KAg+/6cKGQclK0dISB9c53XAZ4LXspOr2ZwPemcnC4uv7KUhYu2p
   PFVi2lfTiPN/1U4yo/WKcDIQknxG6iMojBpYRzTHnF17VfIayPLlmUCUp
   vz9EI9rtcK3bqVcAyJTAu8llktnio7X6lZ+hfpV4XYlQl6zHEzANTN4dg
   zptSthdLwVbiSj2Vm58sNgVTmBgfSyQUjPqdfBCktc/Y6pXhXbLZu42p0
   ixD2Ie1z9cl8JbLIlKmX4CtWQmbPf/OmFvTeY0Et47NZhUctswcB9Zymk
   vEXR2XSHnJwPzgn1TbbVJoEYykGaPzcwnrk+xrnHU/3W83NwSxNG35Xx4
   Q==;
X-CSE-ConnectionGUID: dk1B2pe+RJOmWaP/wutw3g==
X-CSE-MsgGUID: DRDbDNAxQ7CCDDcCQ+mEFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="76722062"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76722062"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:31:07 -0800
X-CSE-ConnectionGUID: 3RdSeWRtQ1OGmwABwOqOQQ==
X-CSE-MsgGUID: HpkJ5mxMT22hY3yqnfnyyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220144437"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.205]) ([10.125.110.205])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:31:07 -0800
Message-ID: <a0c434c4-ec65-4a37-9422-5614249124bc@intel.com>
Date: Mon, 23 Feb 2026 07:31:08 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
To: Lance Yang <lance.yang@linux.dev>, david@kernel.org
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org, will@kernel.org
References: <2a6c4e62-1663-4a98-9adc-406a6a1ebfd3@kernel.org>
 <20260223125826.28207-1-lance.yang@linux.dev>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260223125826.28207-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/26 04:58, Lance Yang wrote:
...
> +/**
> + * tlb_remove_table_sync_rcu() - synchronize with software page-table walkers
> + *
> + * Like tlb_remove_table_sync_one() but uses RCU grace period instead of IPI
> + * broadcast. Should be used in slow paths where sleeping is acceptable.

Just a nit on comments: Use imperative voice:

	... Use in slow paths where sleeping is acceptable.

> + * Software/Lockless page-table walkers use local_irq_disable(), which is also
> + * an RCU read-side critical section. synchronize_rcu() waits for all such
> + * sections, providing the same guarantee as tlb_remove_table_sync_one() but
> + * without disrupting all CPUs with IPIs.

Yep, synchronize_rcu() is likely slower (longer wall clock time) but
less disruptive to other CPUs.

Is it worth explaining here that this should be used when code really
needs to _wait_ and *not* for freeing memory? Freeing memory should use
RCU callbacks that don't cause latency spikes in this thread, not this.

> + * Context: Can sleep/block. Cannot be called from any atomic context.

As a general rule, expressing constraints like this is best done in
code, not comments, so:

	might_sleep();
or
	WARN_ON_ONCE(!in_atomic());

seem appropriate.

I didn't see any obvious warning like that in the top levels of
synchronize_rcu().

> +static void tlb_remove_table_sync_rcu(void)
> +{
> +	synchronize_rcu();
> +}
> +
>  #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
> 
>  static void tlb_remove_table_free(struct mmu_table_batch *batch)
> @@ -303,6 +321,10 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>  	__tlb_remove_table_free(batch);
>  }
> 
> +static void tlb_remove_table_sync_rcu(void)
> +{
> +}
> +
>  #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
This seems a _little_ dangerous to even define. We don't want this
sneaking into use when it doesn't do anything.
