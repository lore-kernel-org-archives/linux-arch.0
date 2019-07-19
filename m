From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [v2 PATCH] padata: Replace delayed timer with immediate
 workqueue in padata_reorder
Date: Fri, 19 Jul 2019 22:55:46 +0800
Message-ID: <20190719145546.hkpe77mevab3gzwq@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
 <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
 <20190718150146.bztw3uugd5sqhdvk@gondor.apana.org.au>
 <20190719143721.awtvjf2pk37f5zsv@ca-dmjordan1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190719143721.awtvjf2pk37f5zsv@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 19, 2019 at 10:37:21AM -0400, Daniel Jordan wrote:
>
> If I'm not missing anything, still looks like get_cpu() and reorder_via_wq no
> longer have an effect with this patch and can be removed.

You're right that they're not needed.  But we shouldn't mix clean-ups
with substantial changes (in case we break something this would make
bisection less efficient).  So feel free to send a patch on top of
this one to remove them.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
