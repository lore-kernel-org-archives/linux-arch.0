From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Date: Tue, 16 Jul 2019 21:09:28 +0800
Message-ID: <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 16, 2019 at 08:57:04PM +0800, Herbert Xu wrote:
>
> How about using RCU?
> 
> We still need to fix up the refcnt if it's supposed to limit the
> overall number of outstanding requests.

Hmm, it doesn't work because the refcnt is attached to the old
pd.  That shouldn't be a problem though as we could simply ignore
the refcnt in padata_flush_queue.

However, I think this leads to another bug in that pcrypt doesn't
support dm-crypt properly.  It never does the backlog stuff and
therefore can't guarantee reliable processing which dm-crypt requires.

Is it intentional to only allow pcrypt for IPsec?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
