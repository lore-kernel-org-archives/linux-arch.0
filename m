Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:38132 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbfGRDbo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 23:31:44 -0400
Date: Thu, 18 Jul 2019 11:31:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Message-ID: <20190718033131.ia1O4w0Ppe7QvcXQIHBmeyQOz4DbUSlFlsMVrj10Ywk@z>

On Wed, Jul 17, 2019 at 02:32:27PM -0400, Daniel Jordan wrote:
>
> We'll crash when cpumask_next_wrap returns nr_cpumask_bits and later try to get
> the corresponding per-cpu queue.

The whole point of cpumask_next_wrap is to wrap around to the
beginning when it hits nr_cpumask_bits.  So it cannot return
nr_cpumask_bits.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
