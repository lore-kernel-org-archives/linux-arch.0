From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/25] asm-generic: Change time_t and clock_t to 64 bit
Date: Tue, 13 May 2014 15:38:51 +0200
Message-ID: <6047893.vbvIgNOHCV@wuerfel>
References: <1399971456-3941-1-git-send-email-lftan@altera.com> <alpine.DEB.2.02.1405131405590.6261@ionos.tec.linutronix.de> <CAMuHMdV2NPwacZwP=QRP+d+eFT85jDq9V0F+Q+Hdch3xukpbkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59174 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbaEMNjZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 May 2014 09:39:25 -0400
In-Reply-To: <CAMuHMdV2NPwacZwP=QRP+d+eFT85jDq9V0F+Q+Hdch3xukpbkw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, James Hogan <james.hogan@imgtec.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>

On Tuesday 13 May 2014 15:11:33 Geert Uytterhoeven wrote:
> On Tue, May 13, 2014 at 2:07 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 13 May 2014, Arnd Bergmann wrote:
> >> On Tuesday 13 May 2014 18:17:40 Ley Foon Tan wrote:
> >> > When we export this posix_types.h file for user software, they need to
> >> > define this config, eg: CONFIG_32BIT_TIME to use 32 bit time. Is this
> >> > what we want to do?
> >>
> >> No, this doesn't really work: You can't use CONFIG_* symbols in
> >> user-visible header files.
> >
> > Then make the config symbol generate the header from a template.
> 
> Indeed. I think it's worthwhile to add CONFIG_* expansion for such "hard"
> CONFIG symbols to make headers_install, cfr. the existing unifdef support.
> 
> We do such a hard work to improve asm-generic, so new architectures can
> just use that, only to see early adaptors now having to migrate away from it
> (e.g. OpenRISC suddenly gaining uapi/asm/posix_types.h).

This was always the idea: New architectures should use the default ABI
as it is defined at the time when they get added. When we later change
the ABI, everything that is already there is no longer using the default,
so they now have to change.
 
> Or is there another solution?

We could in theory have a versioned ABI, and define for instance that
openrisc uses the 3.1 version while nios2 uses the 3.16 version.

Doing that would introduce other problems I guess, but it would
avoid the use of changing lots of architectures when the default
ABI changes.

	Arnd
