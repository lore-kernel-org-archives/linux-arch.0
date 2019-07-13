From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
Date: Sat, 13 Jul 2019 13:03:21 +0800
Message-ID: <20190713050321.c5wq7a7jrb6q2pxn@gondor.apana.org.au>
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, andrea.parri@amarulasolutions.com, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 12, 2019 at 12:07:37PM -0400, Daniel Jordan wrote:
>
> modprobe (CPU2)               kworker/21:1-293 (CPU21)                              kworker/5:2-276 (CPU5)
> --------------------------    ------------------------                              ----------------------
> <submit job, seq_nr=16581>
> ...
>   padata_do_parallel
>     queue_work_on(21, ...)
> <sleeps>
>                               padata_parallel_worker
>                                 pcrypt_aead_dec
>                                   padata_do_serial
>                                     padata_reorder

This can't happen because if the job started on CPU2 then it must
go back to CPU2 for completion.  IOW padata_do_serial should be
punting this to a work queue for CPU2 rather than calling
padata_reorder on CPU21.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
