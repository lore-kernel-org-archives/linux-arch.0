Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51843 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbcHJVpi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2016 17:45:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arm: apply more __ro_after_init
Date: Wed, 10 Aug 2016 12:00:53 +0200
Message-ID: <2342289.4RWg0SWI3A@wuerfel>
In-Reply-To: <20160810094339.GK1041@n2100.armlinux.org.uk>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org> <1464979224-2085-3-git-send-email-keescook@chromium.org> <20160810094339.GK1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, Andrew Morton <akpm@linux-foundation.org>, Mathias Krause <minipli@googlemail.com>
Message-ID: <20160810100053.wEJ1GbQ__9LyxTq5p0q-zelUKLFu2XaxpIbyH1h1lxw@z>

On Wednesday, August 10, 2016 10:43:39 AM CEST Russell King - ARM Linux wrote:
> On Fri, Jun 03, 2016 at 11:40:24AM -0700, Kees Cook wrote:
> > @@ -1309,16 +1309,11 @@ void __init arm_mm_memblock_reserve(void)
> >   * Any other function or debugging method which may touch any device _will_
> >   * crash the kernel.
> >   */
> > +static char vectors[PAGE_SIZE * 2] __ro_after_init __aligned(PAGE_SIZE);
> >  static void __init devicemaps_init(const struct machine_desc *mdesc)
> >  {
> >       struct map_desc map;
> >       unsigned long addr;
> > -     void *vectors;
> > -
> > -     /*
> > -      * Allocate the vector page early.
> > -      */
> > -     vectors = early_alloc(PAGE_SIZE * 2);
> 
> This one is not appropriate.  We _do_ write to these pages after init
> for FIQ handler updates.  See set_fiq_handler().

Is that the only thing that modifies the page? If we think this is a
valuable change, we could make it depend on the absence of FIQ
support, as very few platforms (rpc, omap1, s3c24xx and possibly
imx) seem to even use it.

	Arnd
