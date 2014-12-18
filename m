From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
Date: Fri, 19 Dec 2014 00:33:49 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1412190031530.17382@nanos>
References: <1418849927.28384.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60646 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaLRXd6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Dec 2014 18:33:58 -0500
In-Reply-To: <1418849927.28384.1.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>

On Wed, 17 Dec 2014, Joe Perches wrote:
> It seems like early_printk can be configured into
> a few architectures but also appear not to be used.
> 
> $ git grep -w "early_printk"
...
> These seem to the only uses:
... 
> So blackfin, m68k, and mips seems to have it possible to enable,
> but also don't appear at first glance to use it,

Hint: CONFIG_EARLY_PRINTK covers far more than early_printk()
 
> Is early_printk really used by these architectures?
> Should it be removed?

Sure, if you have a good reason to remove working functionality.

Thanks,

	tglx
