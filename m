From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 08/19] genirq; Provide compat handling for
 chip->mask_ack()
Date: Mon, 27 Sep 2010 17:16:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1009271716130.2416@localhost6.localdomain6>
References: <20100927121651.904100669@linutronix.de> <20100927121842.240806983@linutronix.de> <AANLkTimpavoLaAeY7dXPh7-596+xK0ZFxYMb8AHT6fv1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463795968-2123593630-1285600610=:2416"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:49341 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab0I0PRh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 27 Sep 2010 11:17:37 -0400
In-Reply-To: <AANLkTimpavoLaAeY7dXPh7-596+xK0ZFxYMb8AHT6fv1@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795968-2123593630-1285600610=:2416
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 27 Sep 2010, Geert Uytterhoeven wrote:

> On Mon, Sep 27, 2010 at 14:44, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Wrap the old chip function mask_ack() until the migration is complete
> > and the old chip functions are removed.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/irq/chip.c      |   20 ++++++++++++++++++--
> >  kernel/irq/internals.h |   17 +++++++++++------
> >  kernel/irq/manage.c    |   22 +++++++++++-----------
> >  3 files changed, 40 insertions(+), 19 deletions(-)
> 
> 3 files
> 
> > Index: linux-2.6-tip/kernel/irq/chip.c
> > ===================================================================
> > --- linux-2.6-tip.orig/kernel/irq/chip.c
> > +++ linux-2.6-tip/kernel/irq/chip.c
> 
> Only 1 file?

Yes, seems I forgot to refresh the patch stats, grmbl.

     tglx
---1463795968-2123593630-1285600610=:2416--
