Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback-mx.in-berlin.de ([192.109.42.17]:53472 "EHLO
	hirscho.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbXHOQMs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2007 12:12:48 -0400
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l7FGCltS024819
	for <linux-arch@vger.kernel.org>; Wed, 15 Aug 2007 18:12:47 +0200
Message-ID: <46C3253F.5090707@s5r6.in-berlin.de>
Date: Wed, 15 Aug 2007 18:09:35 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
Subject: Re: [PATCH 0/24] make atomic_read() behave consistently across all
 architectures
References: <46C2350A.1010807@redhat.com> <E1ILCgh-00052A-00@gondolin.me.apana.org.au> <20070815081841.GA16551@osiris.boeblingen.de.ibm.com> <46C30540.2070603@s5r6.in-berlin.de> <alpine.LFD.0.999.0708151941150.16414@enigma.security.iitk.ac.in> <20070815145207.GA23106@gondor.apana.org.au>
In-Reply-To: <20070815145207.GA23106@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Satyam Sharma <satyam@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Chris Snook <csnook@redhat.com>, clameter@sgi.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, ak@suse.de, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com, segher@kernel.crashing.org
List-ID: <linux-arch.vger.kernel.org>

Herbert Xu wrote:
> On Wed, Aug 15, 2007 at 08:05:38PM +0530, Satyam Sharma wrote:
>>> I don't know if this here is affected:

[...something like]
	b = atomic_read(a);
	for (i = 0; i < 4; i++) {
		msleep_interruptible(63);
		c = atomic_read(a);
		if (c != b) {
			b = c;
			i = 0;
		}
	}

> Nope, we're calling schedule which is a rather heavy-weight
> barrier.

How does the compiler know that msleep() has got barrier()s?
-- 
Stefan Richter
-=====-=-=== =--- -====
http://arcgraph.de/sr/
