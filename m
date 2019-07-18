From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Date: Thu, 18 Jul 2019 22:56:34 +0800
Message-ID: <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 18, 2019 at 10:27:30AM -0400, Daniel Jordan wrote:
>
> That's what I expected when I first saw it too, but nr_cpumask_bits is returned
> to signal the end of the iteration.  The patch always passes 0 for the 'start'
> argument, so when cpumask_next_wrap is called with the last cpu in the mask,
> the end-of-iteration case is triggered.  To reassure you and myself :) I ran it
> and got the expected crash.
> 
> Passing pd->cpu for the start argument instead avoids that problem, but the
> one-cpu-in-mask case still needs handling because cpumask_next_wrap always
> signals end of iteration for that, hence the cpumask_weight check.

My bad.  I should have set start to -1 to make it do the right thing.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
