Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55972
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751636AbXKLV3A (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Nov 2007 16:29:00 -0500
Date: Mon, 12 Nov 2007 13:28:59 -0800 (PST)
Message-Id: <20071112.132859.82406611.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1IrWuB-0005nS-00@gondolin.me.apana.org.au>
References: <20071101.155805.65012933.davem@davemloft.net>
	<E1IrWuB-0005nS-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: clameter@sgi.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 12 Nov 2007 18:52:35 +0800

> David Miller <davem@davemloft.net> wrote:
> > 
> > Each IP compression tunnel instance does an alloc_percpu().
> 
> Actually all IPComp tunnels share one set of objects which are
> allocated per-cpu.  So only the first tunnel would do that.
> 
> In fact that was precisely the reason why per-cpu is used in
> IPComp as otherwise we can just allocate normal memory.

Hmmm... indeed.  Thanks for clearing this up.
