Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw1.cosmosbay.com ([86.65.150.130]:35438 "EHLO
	gw1.cosmosbay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbXKLTtB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2007 14:49:01 -0500
Message-ID: <4738AE04.1030506@cosmosbay.com>
Date: Mon, 12 Nov 2007 20:48:20 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
References: <E1IrWuB-0005nS-00@gondolin.me.apana.org.au> <Pine.LNX.4.64.0711121112410.26682@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0711121112410.26682@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

Christoph Lameter a écrit :
> On Mon, 12 Nov 2007, Herbert Xu wrote:
> 
>> David Miller <davem@davemloft.net> wrote:
>>> Each IP compression tunnel instance does an alloc_percpu().
>> Actually all IPComp tunnels share one set of objects which are
>> allocated per-cpu.  So only the first tunnel would do that.
> 
> Ahh so the need to be able to expand per cpu memory storage on demand 
> is not as critical as we thought.
> 

Yes, but still desirable for future optimizations.

For example, I do think using a per cpu memory storage on net_device refcnt & 
last_rx could give us some speedups.



