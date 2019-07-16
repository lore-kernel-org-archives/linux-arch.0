From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Date: Tue, 16 Jul 2019 21:52:35 +0800
Message-ID: <20190716135235.f3nvzdyryjnmmzi5@gondor.apana.org.au>
References: <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716131520.GB3402@hirez.programming.kicks-ass.net>
 <20190716131807.twahbbdff6jhpnu2@gondor.apana.org.au>
 <20190716135010.GC3402@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190716135010.GC3402@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 16, 2019 at 03:50:10PM +0200, Peter Zijlstra wrote:
>
> Could well be, I'm not much familiar with this code; I'll look more
> careful.

My patch is broken anyway.  We can't just switch pd structures
as the code relies on going to exactly the same CPU on the starting
pd to ensure ordering.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
