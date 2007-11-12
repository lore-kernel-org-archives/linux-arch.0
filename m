Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:4313 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753131AbXKLKxu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2007 05:53:50 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu access overhead
In-Reply-To: <20071101.155805.65012933.davem@davemloft.net>
Message-Id: <E1IrWuB-0005nS-00@gondolin.me.apana.org.au>
Date: Mon, 12 Nov 2007 18:52:35 +0800
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: clameter@sgi.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

David Miller <davem@davemloft.net> wrote:
> 
> Each IP compression tunnel instance does an alloc_percpu().

Actually all IPComp tunnels share one set of objects which are
allocated per-cpu.  So only the first tunnel would do that.

In fact that was precisely the reason why per-cpu is used in
IPComp as otherwise we can just allocate normal memory.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
