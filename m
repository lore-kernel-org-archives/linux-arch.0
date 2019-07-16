Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:39404 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfGPPok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 11:44:40 -0400
Subject: Re: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned
 padata jobs
References: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
 <20190712100636.mqdr567p7ozanlyl@gondor.apana.org.au>
 <20190712101012.GW14601@gauss3.secunet.de>
 <20190712160737.iniaaxlsnhs6azg5@ca-dmjordan1.us.oracle.com>
 <20190716125309.GA10672@andrea>
 <20190716150142.rebjmpjjiesaiwyt@gondor.apana.org.au>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <c1bbbe94-dbdc-da14-e0c3-850c965d8b5d@oracle.com>
Date: Tue, 16 Jul 2019 11:44:12 -0400
MIME-Version: 1.0
In-Reply-To: <20190716150142.rebjmpjjiesaiwyt@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>, Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, boqun.feng@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190716154412.GhdwLTe0E0HHH4rvx0PD1n-RXZj28SjIPOPF7gVx0g4@z>

On 7/16/19 11:01 AM, Herbert Xu wrote:
> On Tue, Jul 16, 2019 at 02:53:09PM +0200, Andrea Parri wrote:
>>
>> P1(atomic_t *reorder_objects, spinlock_t *pd_lock, spinlock_t *reorder_lock)
>> {
>> 	int r1;
>>
>> 	spin_lock(reorder_lock);
>> 	atomic_inc(reorder_objects);
>> 	spin_unlock(reorder_lock);
>> 	//smp_mb();
>> 	r1 = spin_trylock(pd_lock);
>> }
> 
> Yes we need a matching mb on the other side.  However, we can
> get away with using smp_mb__after_atomic thanks to the atomic_inc
> above.
> 
> Daniel, can you please respin the patch with the matching smp_mb?

Sure, Herbert, will do.

Thanks,
Daniel
