From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Mon, 1 Dec 2008 14:59:22 +0100
Message-ID: <20081201135922.GA30068@elte.hu>
References: <20081129192610.716a2d57.h.mitake@gmail.com> <20081129105229.GA9643@uranus.ravnborg.org> <20081129222449.e341f028.h.mitake@gmail.com> <20081129180144.GA15533@uranus.ravnborg.org> <20081130171604.dc3c8715.h.mitake@gmail.com> <20081130083700.GA31644@elte.hu> <20081130092407.GA10802@elte.hu> <20081201002056.d9f9204c.h.mitake@gmail.com> <20081130161504.GA25627@elte.hu> <a6b9f31a0812010551h28c0841fxa2a26af4645df64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46075 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbYLAOAA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Dec 2008 09:00:00 -0500
Content-Disposition: inline
In-Reply-To: <a6b9f31a0812010551h28c0841fxa2a26af4645df64@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hitoshi Mitake <h.mitake@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Hitoshi Mitake <h.mitake@gmail.com> wrote:

> On Mon, Dec 1, 2008 at 01:15, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Hitoshi Mitake <h.mitake@gmail.com> wrote:
> >
> >> On Sun, 30 Nov 2008 10:24:07 +0100
> >> Ingo Molnar <mingo@elte.hu> wrote:
> >>
> >> >
> >> > the 32-bit build broke promptly - readq/writeq is a family of APIs that
> >> > has to be either fully provided or not provided at all. The fix is below.
> >>
> >> Thanks for your fix and adding!
> >> When will this patch be added to mainline?
> >> I want to rewrite x38_edac.c to adapt new APIs.
> >
> > v2.6.29 at the earliest - if there are no regressions. A number of
> > drivers use these APIs and usage is a bit messy - so bugs could be
> > triggered, etc.
> >
> Thanks. What is URL of your repository?
> I want to look your tree and test it.

you can pick up tip/master via:

  http://people.redhat.com/mingo/tip.git/README

	Ingo
