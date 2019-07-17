Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([62.96.220.36]:33830 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQI2R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 04:28:17 -0400
Date: Wed, 17 Jul 2019 10:28:15 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH] padata: Use RCU when fetching pd from do_serial
Message-ID: <20190717082815.GP17989@gauss3.secunet.de>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
 <20190715161045.zqwgsp62uqjnvx3l@ca-dmjordan1.us.oracle.com>
 <20190716100447.pdongriwwfxsuajf@gondor.apana.org.au>
 <20190716111410.GN17989@gauss3.secunet.de>
 <20190716125704.l2jolyyd3bue6hhn@gondor.apana.org.au>
 <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190716130928.ga4acvxipsdzyzlp@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190717082815._1IRgXER65XEwRUxz4ai3FTjbHOEoLMjFemsIm81Uhw@z>

On Tue, Jul 16, 2019 at 09:09:28PM +0800, Herbert Xu wrote:
> 
> However, I think this leads to another bug in that pcrypt doesn't
> support dm-crypt properly.  It never does the backlog stuff and
> therefore can't guarantee reliable processing which dm-crypt requires.
> 
> Is it intentional to only allow pcrypt for IPsec?

I had a patch to support crypto backlog some years ago,
but testing with dm-crypt did not show any performance
improvement. So I decided to just skip that patch because
it added code for no need.
