Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:55558 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbbDHMCP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2015 08:02:15 -0400
Message-ID: <552518A0.10205@citrix.com>
Date: Wed, 8 Apr 2015 13:01:36 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v15 12/15] pvqspinlock, x86: Enable PV qspinlock
 for Xen
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
 <1428375350-9213-13-git-send-email-Waiman.Long@hp.com>
In-Reply-To: <1428375350-9213-13-git-send-email-Waiman.Long@hp.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150408120136.AqOHclDV_D8WGQEztsAhGWP8TtoDzqmxiJqM4Iq47Ho@z>

On 07/04/15 03:55, Waiman Long wrote:
> This patch adds the necessary Xen specific code to allow Xen to
> support the CPU halting and kicking operations needed by the queue
> spinlock PV code.

This basically looks the same as the version I wrote, except I think you
broke it.

> +static void xen_qlock_wait(u8 *byte, u8 val)
> +{
> +	int irq = __this_cpu_read(lock_kicker_irq);
> +
> +	/* If kicker interrupts not initialized yet, just spin */
> +	if (irq == -1)
> +		return;
> +
> +	/* clear pending */
> +	xen_clear_irq_pending(irq);
> +
> +	/*
> +	 * We check the byte value after clearing pending IRQ to make sure
> +	 * that we won't miss a wakeup event because of the clearing.

My version had a barrier() here to ensure this.  The documentation of
READ_ONCE() suggests that it is not sufficient to meet this requirement
(and a READ_ONCE() here is not required anyway).

> +	 *
> +	 * The sync_clear_bit() call in xen_clear_irq_pending() is atomic.
> +	 * So it is effectively a memory barrier for x86.
> +	 */
> +	if (READ_ONCE(*byte) != val)
> +		return;
> +
> +	/*
> +	 * If an interrupt happens here, it will leave the wakeup irq
> +	 * pending, which will cause xen_poll_irq() to return
> +	 * immediately.
> +	 */
> +
> +	/* Block until irq becomes pending (or perhaps a spurious wakeup) */
> +	xen_poll_irq(irq);
> +}

David

