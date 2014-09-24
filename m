Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53861 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbaIXLKG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Sep 2014 07:10:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Wed, 24 Sep 2014 13:10 +0200
Message-ID: <3608975.MxU44B73lk@wuerfel>
In-Reply-To: <CAFiDJ5-bo_WOz6JockX_BaX0_O0D=+8PjKx7gys-ySKA2KMOaw@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com> <12538756.JybTPMqFHj@wuerfel> <CAFiDJ5-bo_WOz6JockX_BaX0_O0D=+8PjKx7gys-ySKA2KMOaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20140924111000.M4iSx8U4CX9Ryh7El5_N3bEmDoygMa2TxbLdFUQ9CoU@z>

On Wednesday 24 September 2014 18:57:54 Ley Foon Tan wrote:
> On Wed, Sep 24, 2014 at 6:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 24 September 2014 18:18:50 Ley Foon Tan wrote:
> >> On Tue, Sep 23, 2014 at 6:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Tuesday 23 September 2014 18:20:08 LF.Tan wrote:
> >> >> Hi Arnd
> >> >>
> >> >> Are you okay with this generic futex in asm-generic?
> >> >>
> >> >
> >> > Yes, this looks good. Remind me again who need this, would it make
> >> > sense to merge this through an architecture-specific tree for
> >> > whichever architecture can benefit from it?
> >> What is the common practice for this?
> >> Do you mean merge with nios2 or other arch, eg m68k?
> >
> > I mean do it as part of the nios2 patches.
> I am okay with this.
> Do I need to get ACK for all patches in order for nios2 merge into mainline?
> Thanks.
> 

Please add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' to this patch
once Thomas is ok with it. I think we had concluded already that it
was correct when we talked about it last time, but he doesn't seem
convinced yet so I want to wait for his reply.

You definitely need an Ack for all patches touching code outside of
arch/nios2, from the respective maintainers. For the nios2 code,
having as many acks as you can helps, and I should probably take
a last look so I can ack the pull request when you send it.

	Arnd
