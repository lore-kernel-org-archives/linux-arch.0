From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/2] arm: apply more __ro_after_init
Date: Thu, 11 Aug 2016 00:06:45 +0100
Message-ID: <20160810230645.GP1041@n2100.armlinux.org.uk>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org>
 <20160810094339.GK1041@n2100.armlinux.org.uk>
 <CAGXu5j+9saxwnKTK_vdnLCuXdbvUqQWXkbxOu8QrzB9SHmQGYA@mail.gmail.com>
 <2760702.46Rp2Juk5b@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48236 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcHJXG4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Aug 2016 19:06:56 -0400
Content-Disposition: inline
In-Reply-To: <2760702.46Rp2Juk5b@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>, linux-arch <linux-arch@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Andrew Morton <akpm@linux-foundation.org>, Mathias Krause <minipli@googlemail.com>

On Wed, Aug 10, 2016 at 09:41:23PM +0200, Arnd Bergmann wrote:
> It might be better to start by making the fixed mapping readonly,
> as KASLR doesn't protect that one at all, and change the TLS
> code accordingly.

I think that's impossible, because we gave userspace permission to
read 0xffff0ff0 directly without using __kuser_get_tls.  You're
talking about potentially breaking userspace.

If you disable kuser helpers, then the page becomes read-only and
invisible to userspace anyway.  So, everything is being done there
which can be done - if you have kuser helpers enabled, then you
lose some opportunities for these security improvements.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
