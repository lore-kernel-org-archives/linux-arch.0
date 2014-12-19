From: Joe Perches <joe@perches.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
Date: Thu, 18 Dec 2014 17:14:18 -0800
Message-ID: <1418951658.28384.20.camel@perches.com>
References: <1418849927.28384.1.camel@perches.com>
	 <alpine.DEB.2.11.1412190031530.17382@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:59806 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751830AbaLSBOW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Dec 2014 20:14:22 -0500
In-Reply-To: <alpine.DEB.2.11.1412190031530.17382@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>

On Fri, 2014-12-19 at 00:33 +0100, Thomas Gleixner wrote:
> On Wed, 17 Dec 2014, Joe Perches wrote:
> > It seems like early_printk can be configured into
> > a few architectures but also appear not to be used.
> > 
> > $ git grep -w "early_printk"
> ...
> > These seem to the only uses:
> ... 
> > So blackfin, m68k, and mips seems to have it possible to enable,
> > but also don't appear at first glance to use it,
> 
> Hint: CONFIG_EARLY_PRINTK covers far more than early_printk()

I know this.

Note also I didn't specify CONFIG_EARLY_PRINTK,
just early_printk.
 
> > Is early_printk really used by these architectures?
> > Should it be removed?
> 
> Sure, if you have a good reason to remove working functionality.

Unused.

Ideally, all direct early_printk() uses would go away.
This would just be a starting point to minimize code.
