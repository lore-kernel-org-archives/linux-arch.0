From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 00/47] Sparse irq rework
Date: Mon, 04 Oct 2010 09:57:33 +1100
Message-ID: <1286146653.2463.310.camel@pasglop>
References: <20100930221351.682772535@linutronix.de>
	 <m1wrpzfctu.fsf@fess.ebiederm.org>
	 <alpine.LFD.2.00.1010032034420.14550@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60127 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab0JCW6H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 3 Oct 2010 18:58:07 -0400
In-Reply-To: <alpine.LFD.2.00.1010032034420.14550@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>

On Sun, 2010-10-03 at 21:16 +0200, Thomas Gleixner wrote:
> 
> And I really do not see a point to have a truly random 64bit number
> space for interrupts. Especially the dynamically allocated interrupts
> (MSI & co) do not care about the number space at all. They care about
> getting a unique number, nothing else.

Actually, some implementations care about the actual number... but then,
at least on powerpc, those are hidden behind the virq translation so we
really don't care :-)

(IE. Some PCI host bridges give meaning to the bits of the number, while
x86 tends to use the address for that).

Cheers,
Ben.
