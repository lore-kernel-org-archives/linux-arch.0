From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Wed, 18 May 2016 19:33:41 +0200
Message-ID: <20160518173341.GF3206@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59503 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbcERRdt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2016 13:33:49 -0400
Content-Disposition: inline
In-Reply-To: <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Wed, May 18, 2016 at 04:10:59PM +0100, David Howells wrote:
> +/**
> + * atomic_fetch_or - perform *v |= mask and return old value of *v
> + * @v: pointer to atomic_t
> + * @mask: mask to OR on the atomic_t
> + */
> +static inline int atomic_fetch_or(atomic_t *v, int mask)
> +{
> +	return __atomic_fetch_or(&v->counter, mask, __ATOMIC_SEQ_CST);
> +}

We just merged a patch flipping those arguments; also I suppose you've
seen my larger atomic*_fetch_*() patch set?
