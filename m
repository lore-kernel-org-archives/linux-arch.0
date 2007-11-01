Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49316
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752993AbXKAFih (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 01:38:37 -0400
Date: Wed, 31 Oct 2007 22:38:36 -0700 (PDT)
Message-Id: <20071031.223836.162573733.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0710312115520.26072@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0710311810390.25643@schroedinger.engr.sgi.com>
	<20071031.181335.207429553.davem@davemloft.net>
	<Pine.LNX.4.64.0710312115520.26072@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Wed, 31 Oct 2007 21:16:59 -0700 (PDT)

>  /*
>   * Maximum allowed per cpu data per cpu
>   */
> +#ifdef CONFIG_NUMA
> +#define PER_CPU_ALLOC_SIZE (32768 + MAX_NUMNODES * 512)
> +#else
>  #define PER_CPU_ALLOC_SIZE 32768
> +#endif
> +

Christoph, as Rusty found out years ago when he first wrote this code,
you cannot put hard limits on the alloc_percpu() allocations.

They can be done by anyone, any module, and since there was no limit
before you cannot reasonably add one now.

As just one of many examples, several networking devices use
alloc_percpu() for each instance they bring up.  This alone can
request arbitrary amounts of per-cpu data.

Therefore, you'll need to do your optimization without imposing any
size limits.
