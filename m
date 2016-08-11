Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64158 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395AbcHKQDB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2016 12:03:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] arm: apply more __ro_after_init
Date: Thu, 11 Aug 2016 18:02:15 +0200
Message-ID: <28485373.pjx0rukqdF@wuerfel>
In-Reply-To: <20160810230242.GO1041@n2100.armlinux.org.uk>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org> <2096112.OBiRuggdEi@wuerfel> <20160810230242.GO1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, Andrew Morton <akpm@linux-foundation.org>, Mathias Krause <minipli@googlemail.com>, Mark Brown <broonie@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <20160811160215.5r6Sw9cBNiJu6o70Welnr7zCC5q2pUm1Sq4UCX9DJVU@z>

On Thursday, August 11, 2016 12:02:42 AM CEST Russell King - ARM Linux wrote:
> On Wed, Aug 10, 2016 at 09:31:05PM +0200, Arnd Bergmann wrote:
> > On Wednesday, August 10, 2016 11:12:53 AM CEST Russell King - ARM Linux wrote:
> > > There's the TLS emulation too, but that writes via the vectors mapping
> > > at 0xffff0ff0.
> > 
> > Ok, so that should be safe. Can we change the fiq code to also use the
> > high mapping and then take the __ro_after_init patch on top?
> 
> We can't - if the kernel is configured without the kuser helpers in
> the vectors page, it's mapped read-only. I'm not sure what the
> intersection is between platforms that can have FIQs and platforms
> that can disable the kuser helpers.
