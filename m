From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 00/75] genirq: Overhaul for 2.6.39
Date: Fri, 11 Feb 2011 14:59:06 +0100
Message-ID: <20110211135906.GA16358@elte.hu>
References: <20110210222908.661199947@linutronix.de>
 <AANLkTi=waRQcvdxyKUgcLZ1r-hwUcAVZeVDcBa-apyK2@mail.gmail.com>
 <alpine.LFD.2.00.1102110058450.31804@localhost6.localdomain6>
 <AANLkTin3o9eFjpe6TMmKb5LSRUT+0Y2EpD4OU4LzN8Kd@mail.gmail.com>
 <alpine.LFD.2.00.1102110135320.31804@localhost6.localdomain6>
 <alpine.LFD.2.00.1102111359580.31804@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57101 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214Ab1BKN7V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Feb 2011 08:59:21 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102111359580.31804@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> B1;2401;0cOn Fri, 11 Feb 2011, Thomas Gleixner wrote:
> > On Thu, 10 Feb 2011, Linus Torvalds wrote:
> > So yes, it's net more source lines, but not resulting in any binary
> > bloat.
>=20
> Just checked. When the compat layer goes away it will kill about 500
> lines. So it's less code with better encapsulation.
>=20
> Once all genirq archs convert to the generic irq_show_interrupts(),
> this will kill another 1000+ lines.

So while this is the first step:

> =A029 files changed, 1353 insertions(+), 899 deletions(-)

It turns into this end result (mockup):

> =A0129 files changed, 1353 insertions(+), 2400 deletions(-)

Right? Or, more likely, considering all the surrounding code changes, s=
omething=20
like:

> =A0129 files changed, 4353 insertions(+), 5400 deletions(-)

Did I get the file count right - roughtly how many files are affected t=
hroughout all=20
architectures? The changes are massively intrusive and widely spread ou=
t so we=20
cannot do them in one go, right?

Thanks,

	Ingo
