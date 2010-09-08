Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:45166 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0IHS6d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2010 14:58:33 -0400
Date: Wed, 8 Sep 2010 14:58:24 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [RFC trollpatch 1/1] genirq: Remove the fits all and nothing
 __do_IRQ() code
Message-ID: <20100908185824.GD24791@bombadil.infradead.org>
References: <20100908152036.643594727@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100908152036.643594727@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, linux-alpha@vger.kernel.org, linux-cris-kernel@axis.com, Haavard Skinnemoen <hskinnemoen@atmel.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Greg Ungerer <gerg@uclinux.org>, Jeff Dike <jdike@addtoit.com>, linux-parisc@vger.kernel.org, Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org
Message-ID: <20100908185824.EBkfnos--3iPbN9bI3MRe3-yE797Jw-me3dZEvASvG4@z>

On Wed, Sep 08, 2010 at 06:14:14PM -0000, Thomas Gleixner wrote:
>  The following architectures are still using __do_IRQ():
> 
>   alpha, cris, ia64, h8300, m32r, m68knommu, parisc, um
> 
> So now the question arises what to do with __do_IRQ().
> 

Thanks Thomas for the reminder, I'll poke at fixing parisc this week,
and maybe try to fix ia64 and alpha too as penance for forgetting about
this for so long.

--Kyle
