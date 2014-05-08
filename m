Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37131 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbaEHTCP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 May 2014 15:02:15 -0400
Date: Thu, 8 May 2014 21:02:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 07/19] qspinlock: Use a simple write to grab the
 lock, if applicable
Message-ID: <20140508190203.GP2844@laptop.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
 <1399474907-22206-8-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399474907-22206-8-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140508190203.AtmNAnp7AHK4CSYEy26tbj6FrtEGRnYvLBq2ONKGZro@z>

On Wed, May 07, 2014 at 11:01:35AM -0400, Waiman Long wrote:
>  /**
> + * get_qlock - Set the lock bit and own the lock
> + * @lock: Pointer to queue spinlock structure
> + *
> + * This routine should only be called when the caller is the only one
> + * entitled to acquire the lock.
> + */
> +static __always_inline void get_qlock(struct qspinlock *lock)

set_locked()

> +{
> +	struct __qspinlock *l = (void *)lock;
> +
> +	barrier();
> +	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
> +	barrier();
> +}

get_qlock() is just horrible. The function doesn't actually _get_
anything, and qlock is not in line with the rest of the naming.
