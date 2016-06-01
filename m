Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tex.lwn.net ([70.33.254.29]:37124 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbcFAShI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jun 2016 14:37:08 -0400
Date: Wed, 1 Jun 2016 12:37:05 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 5/8] x86, pkeys: allocation/free syscalls
Message-ID: <20160601123705.72a606e7@lwn.net>
In-Reply-To: <20160531152822.FE8D405E@viggo.jf.intel.com>
References: <20160531152814.36E0B9EE@viggo.jf.intel.com>
	<20160531152822.FE8D405E@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave@sr71.net>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com
Message-ID: <20160601183705.Vx2t-RjDwUC4N2lOmuLJrd-JRo3BuYoiqy9KqGPqrME@z>

Sorry, I have one more obnoxious question...

> +static inline
> +int mm_pkey_free(struct mm_struct *mm, int pkey)
> +{
> +	/*
> +	 * pkey 0 is special, always allocated and can never
> +	 * be freed.
> +	 */
> +	if (!pkey || !validate_pkey(pkey))
> +		return -EINVAL;
> +	if (!mm_pkey_is_allocated(mm, pkey))
> +		return -EINVAL;
> +
> +	mm_set_pkey_free(mm, pkey);
> +
> +	return 0;
> +}

If I read this right, it doesn't actually remove any pkey restrictions
that may have been applied while the key was allocated.  So there could be
pages with that key assigned that might do surprising things if the key is
reallocated for another use later, right?  Is that how the API is intended
to work?

Thanks,

jon
