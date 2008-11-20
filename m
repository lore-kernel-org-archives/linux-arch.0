Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:53737 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752663AbYKTS64 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Nov 2008 13:58:56 -0500
Subject: Re: [patch] mm: vmalloc fix lazy unmapping cache aliasing
From: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20081119201715.GA9404@flint.arm.linux.org.uk>
References: <20081119045338.GA18697@wotan.suse.de>
	 <20081119201715.GA9404@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 18:43:38 +0000
Message-ID: <1227206618.14146.77.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20081120184338.CslWaK3VA1jJJuVhYNptBqLdBssCB1pDh22T5SBprdA@z>

On Wed, 2008-11-19 at 20:17 +0000, Russell King wrote:
> The reason I ask is that with VIPT caches, the mapping has to be
> present so the hardware knows the physical tag to be flushed, so if
> the mapping has been torn down, we'll get an exception.  _If_ and
> only if we convert flush_cache_vunmap() to be less heavy weight
> than its current flush_cache_all().

I posted a patch for simplifying flush_cache_v(un)map some time ago but
only for the VIPT non-aliasing case. I think we still need it to do
cache flushing for the VIPT aliasing systems.

-- 
Catalin

