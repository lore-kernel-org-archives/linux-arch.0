Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45127 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966054AbaFRLkr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jun 2014 07:40:47 -0400
Message-ID: <53A17A88.7090705@redhat.com>
Date: Wed, 18 Jun 2014 13:39:52 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 05/11] qspinlock: Optimize for smaller NR_CPUS
References: <20140615124657.264658593@chello.nl> <20140615130153.483502389@chello.nl>
In-Reply-To: <20140615130153.483502389@chello.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, gleb@redhat.com, scott.norton@hp.com, chegu_vinod@hp.com, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20140618113952.GDn1pjuhMktXk3FvlzFZob3cXsvWibnyC1pzrPMLnyU@z>

Il 15/06/2014 14:47, Peter Zijlstra ha scritto:
>
> -	for (;;) {
> -		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
> -
> -		old = atomic_cmpxchg(&lock->val, val, new);
> -		if (old == val)
> -			break;
> -
> -		val = old;
> -	}
> +	clear_pending_set_locked(lock, val);
>  	return;


Might as well add clear_pending_set_locked already in patch 3.

Paolo
