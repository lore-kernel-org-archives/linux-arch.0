From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Date: Mon, 13 Oct 2008 03:18:27 +0200
Message-ID: <20081013011827.GA1299@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de> <20081012054732.GB12535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56110 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbYJMBSc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 12 Oct 2008 21:18:32 -0400
Content-Disposition: inline
In-Reply-To: <20081012054732.GB12535@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org

On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> 
> Implement a more optimal mutex fastpath for powerpc, making use of acquire
> and release barrier semantics. This takes the mutex lock+unlock benchmark
> from 203 to 173 cycles on a G5.
> 
> +static inline int
> +__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> +{
> +	if (likely(__mutex_cmpxchg_lock(count, 1, 0) == 1))
> +		return 1;

Oops, I must have sent the wrong version. This needs a return 0 here.

> +}
