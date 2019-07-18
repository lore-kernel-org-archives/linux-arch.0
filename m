Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:42330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRO1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 10:27:55 -0400
Date: Thu, 18 Jul 2019 10:27:30 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH] padata: Replace delayed timer with immediate workqueue
 in padata_reorder
Message-ID: <20190718142730.uhdkwx5onigdpxno@ca-dmjordan1.us.oracle.com>
References: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
 <20190716163253.24377-1-daniel.m.jordan@oracle.com>
 <20190717111147.t776zlyhdqyl5dhc@gondor.apana.org.au>
 <20190717183227.b3hqphukkndqumhw@ca-dmjordan1.us.oracle.com>
 <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718033131.4m4ypbq7tiucqcsl@gondor.apana.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Steffen Klassert <steffen.klassert@secunet.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Message-ID: <20190718142730.udYMxGuByQ1mB4XAkX0HZRqtpurhd-SjKXxr5ECHrSI@z>

On Thu, Jul 18, 2019 at 11:31:31AM +0800, Herbert Xu wrote:
> On Wed, Jul 17, 2019 at 02:32:27PM -0400, Daniel Jordan wrote:
> >
> > We'll crash when cpumask_next_wrap returns nr_cpumask_bits and later try to get
> > the corresponding per-cpu queue.
> 
> The whole point of cpumask_next_wrap is to wrap around to the
> beginning when it hits nr_cpumask_bits.  So it cannot return
> nr_cpumask_bits.

That's what I expected when I first saw it too, but nr_cpumask_bits is returned
to signal the end of the iteration.  The patch always passes 0 for the 'start'
argument, so when cpumask_next_wrap is called with the last cpu in the mask,
the end-of-iteration case is triggered.  To reassure you and myself :) I ran it
and got the expected crash.

Passing pd->cpu for the start argument instead avoids that problem, but the
one-cpu-in-mask case still needs handling because cpumask_next_wrap always
signals end of iteration for that, hence the cpumask_weight check.
