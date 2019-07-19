Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:58292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfGSOVu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 10:21:50 -0400
Date: Fri, 19 Jul 2019 10:21:13 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190719142113.ixalfoikevwnhvaq@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717232136.pboms73sqf6fdzic@ca-dmjordan1.us.oracle.com>
 <20190718033008.wle67s7esg27mrtz@gondor.apana.org.au>
 <20190718142515.teinr4da3gps5r7a@ca-dmjordan1.us.oracle.com>
 <20190718144950.yc6sambgdsz7vrvq@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718144950.yc6sambgdsz7vrvq@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Message-ID: <20190719142113.pjD6goiwX524yIuTMovdSTmm8ZvvCwFRp_a2u83rChk@z>

On Thu, Jul 18, 2019 at 10:49:50PM +0800, Herbert Xu wrote:
> On Thu, Jul 18, 2019 at 10:25:15AM -0400, Daniel Jordan wrote:
> >
> > Which memory barrier do you mean?  I think you're referring to the one that
> > atomic_inc might provide?  If so, the memory model maintainers can correct me
> > here, but my understanding is that RMW atomic ops that don't return values are
> > unordered, so switching the lines has no effect.
> > 
> > Besides, the smp_mb__after_atomic is what orders the list insertion with the
> > trylock of pd->lock.
> 
> The primitive smp_mb__after_atomic only provides a barrier when
> used in conjunction with atomic_inc (and similar atomic ops).
> 
> The actual barrier may either be in smp_mb__after_atomic or the
> atomic op itself (which is the case on x86).  Since we need the
> barrier to occur after the list insertion we must move both of
> these after the list_add_tail.

Yes, my mistake!  Thanks for clarifying that.
