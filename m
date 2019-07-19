Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:39944 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfGSO2A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 10:28:00 -0400
Date: Fri, 19 Jul 2019 10:27:35 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190719142735.s2oggziz4wqwebxf@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
 <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
 <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718145634.xagjemdqpoe44xxh@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Message-ID: <20190719142735.xTM0zwq-L6eMZrluPD6lTKDhozFGzWBxX4rq1YJdDHE@z>

On Thu, Jul 18, 2019 at 10:56:34PM +0800, Herbert Xu wrote:
> On Thu, Jul 18, 2019 at 10:27:30AM -0400, Daniel Jordan wrote:
> >
> > That's what I expected when I first saw it too, but nr_cpumask_bits is returned
> > to signal the end of the iteration.  The patch always passes 0 for the 'start'
> > argument, so when cpumask_next_wrap is called with the last cpu in the mask,
> > the end-of-iteration case is triggered.  To reassure you and myself :) I ran it
> > and got the expected crash.
> > 
> > Passing pd->cpu for the start argument instead avoids that problem, but the
> > one-cpu-in-mask case still needs handling because cpumask_next_wrap always
> > signals end of iteration for that, hence the cpumask_weight check.
> 
> My bad.  I should have set start to -1 to make it do the right thing.

Oh, you're right, that's nicer, just noticed other callers do it that way as
well.
