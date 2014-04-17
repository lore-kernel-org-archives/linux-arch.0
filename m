Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58122 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaDQPtQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 11:49:16 -0400
Date: Thu, 17 Apr 2014 17:49:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 04/19] qspinlock: Extract out the exchange of tail
 code word
Message-ID: <20140417154902.GO11096@twins.programming.kicks-ass.net>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
 <1397747051-15401-5-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397747051-15401-5-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140417154902.VXo0rTatsANaQ3_KPyYvwQmlEb1Iu37UwAl5M-QEtyg@z>

On Thu, Apr 17, 2014 at 11:03:56AM -0400, Waiman Long wrote:
> @@ -192,36 +220,25 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	node->next = NULL;
>  
>  	/*
> +	 * We touched a (possibly) cold cacheline; attempt the trylock once
> +	 * more in the hope someone let go while we weren't watching as long
> +	 * as no one was queuing.
>  	 */
> +	if (!(val & _Q_TAIL_MASK) && queue_spin_trylock(lock))
> +		goto release;

But you just did a potentially very expensive op; @val isn't
representative anymore!
