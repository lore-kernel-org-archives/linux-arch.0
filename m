Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:46260 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752438AbaLSWtJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Dec 2014 17:49:09 -0500
Message-ID: <1419029345.25129.16.camel@perches.com>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
From: Joe Perches <joe@perches.com>
Date: Fri, 19 Dec 2014 14:49:05 -0800
In-Reply-To: <yw1xy4q4exo9.fsf@unicorn.mansr.com>
References: <1418849927.28384.1.camel@perches.com>
	 <alpine.DEB.2.11.1412190031530.17382@nanos>
	 <1418951658.28384.20.camel@perches.com>
	 <yw1x388ch0su.fsf@unicorn.mansr.com> <1418954914.25129.1.camel@perches.com>
	 <yw1xy4q4exo9.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
Message-ID: <20141219224905.5dGk3SpGry7oqo2TpXkMy_jP1-16KX4eQ4IumTYW2oU@z>

On Fri, 2014-12-19 at 10:33 +0000, Måns Rullgård wrote:
> Joe Perches <joe@perches.com> writes:
> > The kernel/printk/early_printk() function seems
> > used only by arm/microblaze/tile/x86.
> 
> Rather than introduce more config complexity, you could try to remove
> the 7 remaining uses of early_printk().

That's the general idea actually.
Dunno if that's possible at one go though.

cheers, Joe

