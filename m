From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 21/29] nios2: Futex operations
Date: Fri, 18 Jul 2014 11:55:26 +0200
Message-ID: <5659104.6O7AZx76W6@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <17186253.ZJUn1qWK0f@wuerfel> <alpine.DEB.2.10.1407181140250.24854@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:51818 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456AbaGRJzg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jul 2014 05:55:36 -0400
In-Reply-To: <alpine.DEB.2.10.1407181140250.24854@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>

On Friday 18 July 2014 11:42:34 Thomas Gleixner wrote:
> On Fri, 18 Jul 2014, Arnd Bergmann wrote:
> > On Friday 18 July 2014 14:07:42 Ley Foon Tan wrote:
> > > On Thu, Jul 17, 2014 at 7:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > If this understanding is right, we can probably just merge the
> > m68k implementation into the asm-generic version, as that does
> > exactly that, and just isn't SMP safe. I'm still unsure whether
> > I'm missing something here though, as everything else seems to
> > do this in assembly, even for non-SMP machines that could use
> > the trivial method that m68k has.
> 
> For UP relying of pagefault disable should be good enough indeed. I
> guess the asm for the other UP stuff results from looking at
> architectures or copying from architectures which did this in ASM 

Ok, thanks for the confirmation!

Ley Foon Tan, I think the best way forward then is for you to
take the m68k code and copy (or move) that into asm-generic/futex.h
under an #ifndef CONFIG_SMP.

	Arnd
