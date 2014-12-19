Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:47734 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751158AbaLSCIi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Dec 2014 21:08:38 -0500
Message-ID: <1418954914.25129.1.camel@perches.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
From: Joe Perches <joe@perches.com>
Date: Thu, 18 Dec 2014 18:08:34 -0800
In-Reply-To: <yw1x388ch0su.fsf@unicorn.mansr.com>
References: <1418849927.28384.1.camel@perches.com>
	 <alpine.DEB.2.11.1412190031530.17382@nanos>
	 <1418951658.28384.20.camel@perches.com>
	 <yw1x388ch0su.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
Message-ID: <20141219020834.3aDqIBoVBNej2mlaWANM9R8IywYbV0_eQ6--9n7FbZo@z>

On Fri, 2014-12-19 at 01:43 +0000, Måns Rullgård wrote:
> What exactly are you proposing to remove?

Optionally compile out
kernel/printk/printk.c:early_printk()
even if CONFIG_EARLY_PRINTK is enabled.

> I see no unused code related
> to early printk (in any variant) under arch/mips.

I think there could be yet another CONFIG option
to specifically enable the early_printk function
for the arches that use it.

The kernel/printk/early_printk() function seems
used only by arm/microblaze/tile/x86.


