From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/27] score: create head files hardirq.h hw_irq.h
Date: Tue, 9 Jun 2009 19:33:08 +0200
Message-ID: <200906091933.08483.arnd@arndb.de>
References: <OFE06CA763.2ED1275C-ON482575D0.00237A09-482575D0.0023EB63@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:61842 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbZFIRdn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:33:43 -0400
In-Reply-To: <OFE06CA763.2ED1275C-ON482575D0.00237A09-482575D0.0023EB63@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> --- /dev/null
> +++ b/arch/score/include/asm/hardirq.h
> @@ -0,0 +1,16 @@
> +#ifndef _ASM_SCORE_HARDIRQ_H
> +#define _ASM_SCORE_HARDIRQ_H
> +
> +#include <linux/threads.h>
> +#include <linux/irq.h>
> +
> +typedef struct {
> +       unsigned int __softirq_pending;
> +} ____cacheline_aligned irq_cpustat_t;
> +
> +/* Standard mappings for irq_cpustat_t above */
> +#include <linux/irq_cpustat.h>
> +
> +extern void ack_bad_irq(unsigned int irq);

In this case (ack_bad_irq is extern), you can still use
the generic file by adding

#define ack_bad_irq ack_bad_irq

in front of the #include, in order to override the default
implementation.

	Arnd <><
