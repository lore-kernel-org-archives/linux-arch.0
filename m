From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 12/24] C6X: interrupt handling
Date: Wed, 28 Sep 2011 01:30:28 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109280115130.2711@ionos>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-13-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57160 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab1I0Xaa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 Sep 2011 19:30:30 -0400
In-Reply-To: <1317155405-26235-13-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

B1;2601;0cOn Tue, 27 Sep 2011, Mark Salter wrote:
> diff --git a/arch/c6x/kernel/irq.c b/arch/c6x/kernel/irq.c
> +static raw_spinlock_t core_irq_lock;

static DEFINE_RAW_SPINLOCK(...) please, so you can get rid of the
raw_spin_lock_init(...) below.

> +static int core_host_map(struct irq_host *h, unsigned int virq,
> +			 irq_hw_number_t hw)
> +{
> +	if (hw < 4 || hw >= NR_PRIORITY_IRQS)
> +		return -1;

Proper error code please, i.e -EINVAL or such

> +
> +	irq_set_status_flags(virq, IRQ_LEVEL);
> +	irq_set_chip_and_handler(virq, &core_chip, handle_level_irq);
> +	return 0;
> +}
> +
> +static struct irq_host_ops core_host_ops = {
> +	.map = core_host_map,
> +};
> +
> +void __init init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	raw_spin_lock_init(&core_irq_lock);

See above.

Aside of that I'm still not too happy about the of_/irqhost/domain
code replication and the cleanup which needs to be done after that has
been solved. Though if you and Grant have a plan for that, I'm not in
the way.

Btw, keeping people who have been added to previous review comments of
a particular patch in the CC makes everyones life easier.

Thanks,

	tglx
