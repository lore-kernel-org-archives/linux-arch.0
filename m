From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] modules: add default loader hook implementations
Date: Mon, 27 Jun 2011 13:05:44 +0200
Message-ID: <201106271305.44746.arnd@arndb.de>
References: <1308987512-6583-1-git-send-email-jonas@southpole.se> <87hb7b7ic6.fsf@rustcorp.com.au> <BANLkTinmhQT=__WP+10cr2HZPy1TvdxZ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53869 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1F0LGD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2011 07:06:03 -0400
In-Reply-To: <BANLkTinmhQT=__WP+10cr2HZPy1TvdxZ=w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jonas Bonn <jonas@southpole.se>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Monday 27 June 2011, Geert Uytterhoeven wrote:
> >> I don't care much either way, you would get my Ack for both solutions.
> >> The __weak approach would definitely make a simpler patch, and the
> >> patch you sent adds extra complexity because of the
> >> asm_generic_moduleloader_hooks macro you used to avoid having to
> >> change all other architectures.
> >
> > I think you misread me.  If all else is equal, I dislike weak functions.
> > But AFAICT the two standard mechanisms are #ifdef HAVE_ARCH and __weak.
> > Inventing a third one is not going to be a win.
> 
> It's not inventing a new one, the third one is already in use.

True. In fact, we are (slowly) migrating away from HAVE_ARCH_* elsewhere.
In include/asm-generic/*.h, the common method is now to #define the exact
symbol if an architecture wants to override the generic version.

Weak symbols are fairly obscure in comparison, but they are actively
used by a few architectures (mips, sh) and some core code in kernel/
and mm/.

	Arnd
