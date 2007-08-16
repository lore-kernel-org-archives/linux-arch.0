Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:34209 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757786AbXHPB1a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Aug 2007 21:27:30 -0400
In-Reply-To: <20070815234021.GA28775@gondor.apana.org.au>
References: <E1ILCgh-00052A-00@gondolin.me.apana.org.au> <46C32618.2080108@redhat.com> <20070815234021.GA28775@gondor.apana.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3694fb2e4ed1e4d9bf873c0d050c911e@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 0/24] make atomic_read() behave consistently across all architectures
Date: Thu, 16 Aug 2007 03:26:02 +0200
Sender: linux-arch-owner@vger.kernel.org
To: Herbert Xu <herbert.xu@redhat.com>
Cc: heiko.carstens@de.ibm.com, horms@verge.net.au, linux-kernel@vger.kernel.org, rpjday@mindspring.com, ak@suse.de, netdev@vger.kernel.org, cfriesen@nortel.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, jesper.juhl@gmail.com, linux-arch@vger.kernel.org, zlynx@acm.org, satyam@infradead.org, clameter@sgi.com, schwidefsky@de.ibm.com, Chris Snook <csnook@redhat.com>, davem@davemloft.net, wensong@linux-vs.org, wjiang@resilience.com
List-ID: <linux-arch.vger.kernel.org>

>> Part of the motivation here is to fix heisenbugs.  If I knew where 
>> they
>
> By the same token we should probably disable optimisations
> altogether since that too can create heisenbugs.

Almost everything is a tradeoff; and so is this.  I don't
believe most people would find disabling all compiler
optimisations an acceptable price to pay for some peace
of mind.


Segher

