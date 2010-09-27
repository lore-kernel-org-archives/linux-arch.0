From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC trollpatch 1/1] genirq: Remove the fits all and nothing
 __do_IRQ() code
Date: Mon, 27 Sep 2010 21:54:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1009272152360.2416@localhost6.localdomain6>
References: <20100908152036.643594727@linutronix.de> <AANLkTin23sJT+OqjDqjyk-Gr5r-GfJ_03Q1WUqNLCzgH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463795968-1112802732-1285617250=:2416"
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <AANLkTin23sJT+OqjDqjyk-Gr5r-GfJ_03Q1WUqNLCzgH@mail.gmail.com>
Sender: linux-parisc-owner@vger.kernel.org
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-alpha@vger.kernel.org, linux-cris-kernel@axis.com, Haavard Skinnemoen <hskinnemoen@atmel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Greg Ungerer <gerg@uclinux.org>, Jeff Dike <jdike@addtoit.com>, linux-parisc@vger.kernel.org, Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795968-1112802732-1285617250=:2416
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 27 Sep 2010, richard -rw- weinberger wrote:

> On Wed, Sep 8, 2010 at 8:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > __do_IRQ() has been deprecated after a two years migration phase in
> >  The following architectures are still using __do_IRQ():
> >
> >  alpha, cris, ia64, h8300, m32r, m68knommu, parisc, um
> >
> 
> Maybe I'm naive but shouldn't this path work?
> Does um need some extra work?

Yes. It needs to set the proper flow handlers. Look for set_irq_chip*
functions and how they are used in other archs.

Thanks,

	tglx

 
---1463795968-1112802732-1285617250=:2416--
