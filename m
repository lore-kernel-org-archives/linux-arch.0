From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [patch 00/47] Sparse irq rework
Date: Mon, 4 Oct 2010 10:31:18 -0600
Message-ID: <20101004163118.GA13749@angua.secretlab.ca>
References: <20100930221351.682772535@linutronix.de>
 <m1wrpzfctu.fsf@fess.ebiederm.org>
 <alpine.LFD.2.00.1010032034420.14550@localhost6.localdomain6>
 <1286146653.2463.310.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45690 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756522Ab0JDQbX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Oct 2010 12:31:23 -0400
Content-Disposition: inline
In-Reply-To: <1286146653.2463.310.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>

On Mon, Oct 04, 2010 at 09:57:33AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2010-10-03 at 21:16 +0200, Thomas Gleixner wrote:
> > 
> > And I really do not see a point to have a truly random 64bit number
> > space for interrupts. Especially the dynamically allocated interrupts
> > (MSI & co) do not care about the number space at all. They care about
> > getting a unique number, nothing else.
> 
> Actually, some implementations care about the actual number... but then,
> at least on powerpc, those are hidden behind the virq translation so we
> really don't care :-)

In fact, if it wasn't for all the embedded platforms where some hard
coded irq number is encoded into the static device tables
(platform_device et al.) I'd argue that the irq number is completely
meaningless outside of the core irq code, and from a device driver
point of view it is just an opaque cookie.

Also from the userspace point of view, the attachment to a particular
irq controller instance is far more interesting than the specific irq
number.

g.
