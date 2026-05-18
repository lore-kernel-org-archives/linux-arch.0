Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154231F9A1;
	Mon, 18 May 2026 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104544; cv=none; b=HKWhavc3zw5IgW2szGSkEtONh4ciXePn6gtKD7QNpYbs2M6gE4wbFp5LT22Htw3rzUVItvE0KxvKRGFBt4D4ugD89s06i68Afg/HaHl92hGslgiNn4A+RkiLyGC6bNGo10rD5nrli+Ij5crUrEcwf1dR8IlvxgyjG42VJwM/RHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104544; c=relaxed/simple;
	bh=5fVr8irT34fLgAlGFHPkcaFG+MtRNl5XhMDgmimc7fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpzbw/E+1BMGj1CLVkRjamxcKiD/rw9o5YFToV9um+HfnVWfUuK4D3WLukFd+HdCpQmr8P50K0CoUFd0GDFEZ5hpsbVdIwdC1VZ2959xp4AXWdDF33+9HSh4q7x3E5bG6MbaMj7T0EfY1xxiH5Q13H9XdKDo5eem4MRCPwkEzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ1/izm1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ1/izm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E891FC2BCB7;
	Mon, 18 May 2026 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104543;
	bh=5fVr8irT34fLgAlGFHPkcaFG+MtRNl5XhMDgmimc7fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQ1/izm1hgJXImuxiobG3wAHuX9JKjLpfaX1Z0WwRbF/7nXtNRnqjt96r7ECUy8rd
	 c0wEUStWikSffbaAHDHTqBycKU5YrGxAVYmtpLrTH3CxwAODnXCod5+LRL0laWga5C
	 yEV8CY8a+NZw7LRD+7J5lIgl9q2WT5F6d5LhuDVqN0mhFaKw3MJtG506J2otNOQ4v5
	 RKaFFOq2fDY0NIp8I5+ovDtY92ZERuB3Y2hydIFgCUBMvVwLQFn3LHXSclTg7mRzge
	 P2/jRcs1iYoyVLPf+ocX4VY8GtJZLZTOHxFykMKwhb447HXs0B1kjEv1jP6unL5js/
	 meVWHu1uubNJw==
Date: Mon, 18 May 2026 14:42:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de,
	dave.hansen@linux.intel.com, david@kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mingo@redhat.com, tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 2/4] mm: add a template-based fast path for zone-device
 page init
Message-ID: <agr7GIZOjzr5HZMt@kernel.org>
References: <agq29raPaAPlM8kV@kernel.org>
 <20260518095405.76367-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518095405.76367-1-lizhe.67@bytedance.com>

On Mon, May 18, 2026 at 05:54:05PM +0800, Li Zhe wrote:
> On Mon, 18 May 2026 09:51:34 +0300, rppt@kernel.org wrote:
>
> > > +#ifdef WANT_PAGE_VIRTUAL
> > > +	if (!is_highmem_idx(ZONE_DEVICE))
> > > +		set_page_address(page, __va(pfn << PAGE_SHIFT));
> > 
> > set_page_address() is a not when WANT_PAGE_VIRTUAL, you can drop the ifdef.
> 
> Upon checking the implementation, set_page_address() also has another
> implementation for HASHED_PAGE_VIRTUAL
> 
> Following the style of __init_single_page(), we only want to call
> set_page_address() under WANT_PAGE_VIRTUAL for ZONE_DEVICE initialization,
> so would it be acceptable to keep the #ifdef guard here?

Since there's no other option, keep the ifdef.

-- 
Sincerely yours,
Mike.
