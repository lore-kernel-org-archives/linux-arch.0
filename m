From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 0/2] Run interrupt handlers always with interrupts disabled
Date: Fri, 26 Mar 2010 00:06:44 -0000
Message-ID: <20100326000325.917127328@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:58652 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679Ab0CZAHf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Mar 2010 20:07:35 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <andi@firstfloor.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>, Arnaldo Carvalho de Melo <acme@redhat.com>

The following patch series removes the IRQF_DISABLED functionality
from the core interrupt code and runs all interrupt handlers with
interrupts disabled.

IRQF_DISABLED is kept as a define and scheduled for feature removal.

I booted and stressed that patches w/o any obvious fallout on more
than 20 different systems in my arsenal of test machines which
includes various embedded non x86 systems.

To debug eventual latency issues we (admittedly I talked acme into
looking at that) want to extend perf with a top like tool to monitor
the maximum runtime of interrupt handlers with the already existing
tracepoints.

Thanks,

	tglx
