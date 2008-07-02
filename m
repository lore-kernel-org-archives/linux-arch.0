From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 5/23] make section names compatible with -ffunction-sections -fdata-sections: blackfin
Date: Wed, 2 Jul 2008 02:08:33 +0200
Message-ID: <200807020208.33302.vda.linux@googlemail.com>
References: <200807020235.08025.vda.linux@googlemail.com> <8bd0f97a0807011558u2c02f6fcre2f3af3d5cced936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.224]:15434 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYGBAIl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 20:08:41 -0400
Received: by qb-out-0506.google.com with SMTP id a33so5142794qbd.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 17:08:40 -0700 (PDT)
In-Reply-To: <8bd0f97a0807011558u2c02f6fcre2f3af3d5cced936@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>

On Wednesday 02 July 2008 00:58, Mike Frysinger wrote:
> On Tue, Jul 1, 2008 at 8:35 PM, Denys Vlasenko wrote:
> > The purpose of this patch is to make kernel buildable
> > with "gcc -ffunction-sections -fdata-sections".
> > This patch fixes blackfin architecture.
> 
> the comment right above what you changed says it already works for
> Blackfin.  so you arent fixing it at all.
> >                /* This gets done first, so the glob doesn't suck it in */
> >                . = ALIGN(32);
> > -               *(.data.cacheline_aligned)
> > +               *(.cacheline_aligned.data)

This may pull in an unrelated data object named "cacheline_aligned"
(say, a static variable in a driver). If that variable is not
itself aligned to the cacheline size, it will mess up alignment of all
objects in .data.cacheline_aligned which follow. Not good.

To be safe from such weird and hard to debug problems
it's better to not use names like .data.XXXX at all.
I just uniformly renamed al such "special sections"
in the kernel to .XXXXX.data
--
vda
