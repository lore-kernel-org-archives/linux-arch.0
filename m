From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 14/23] make section names compatible with
	-ffunction-sections -fdata-sections: parisc
Date: Tue, 01 Jul 2008 18:41:00 -0500
Message-ID: <1214955660.3316.31.camel@localhost.localdomain>
References: <200807020239.11410.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:55689 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797AbYGAXlI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 19:41:08 -0400
In-Reply-To: <200807020239.11410.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>

On Wed, 2008-07-02 at 02:39 +0200, Denys Vlasenko wrote:
> The purpose of this patch is to make kernel buildable
> with "gcc -ffunction-sections -fdata-sections".
> This patch fixes parisc architecture.
>=20
> Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>

Um ... if you look at the Makefile you'll see we already build parisc
with -ffunction-sections; we have to: our relative jumps are too small
to guarantee finding the stubs in large files.

Since our text is -ffunction-sections compatible already, I question th=
e
need for transformations like this:

> =EF=BB=BF-               *(.text.do_softirq)
> -               *(.text.sys_exit)
> -               *(.text.do_sigaltstack)
> -               *(.text.do_fork)
> +               *(.do_softirq.text)
> +               *(.sys_exit.text)
> +               *(.do_sigaltstack.text)
> +               *(.do_fork.text)

And thus by the same token the data transformations.

James
