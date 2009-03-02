From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 02 Mar 2009 19:02:55 +0100
Message-ID: <1236016975.5330.990.camel@laptop>
References: <1235996477.5330.174.camel@laptop>
	 <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain>
	 <200903021855.02765.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:48832 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758601AbZCBSDR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 13:03:17 -0500
In-Reply-To: <200903021855.02765.bzolnier@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, 2009-03-02 at 18:55 +0100, Bartlomiej Zolnierkiewicz wrote:
> IDE IRQ handler (& probably many others) assume that IRQ layer won't be
> trying to call it again while IRQ is being serviced -- is this going to
> change with the introduction of threaded IRQs?

No, the real hardirq handler needs to disable the irq line before
telling it wants the thread to run. The thread will then have to
re-enable the irq line after its done.
