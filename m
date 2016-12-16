Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35097 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbcLPQDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 11:03:43 -0500
MIME-Version: 1.0
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Dec 2016 16:54:33 +0100
Message-ID: <CAMuHMdUa4j8nxrW=fSJQZok3=mW-FWZWHR=cYS2R0gQUeGHgmQ@mail.gmail.com>
Subject: Re: [RFC] minimum gcc version for kernel: raise to gcc-4.3 or 4.6?
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu
Message-ID: <20161216155433.0oZ1YhjbXk_PAuiq-FMEzrwNfRlK3m7pDbR9IXaayW0@z>

Hi Arnd,

On Fri, Dec 16, 2016 at 11:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Specifically on ARM, going further makes things rather useless especially
> for build testing: with gcc-4.2, we lose support for ARMv7, EABI, and
> effectively ARMv6 (as it relies on EABI for building reliably). Also,
> the number of false-positive build warnings is so high that it is useless
> for finding actual bugs from the warnings.

If you start with that activity now, there's indeed a massive amount of
warnings to look into.
However, I've been build testing various configs with m68k-linux-gnu-gcc-4.1.2
and looking at the compiler warnings for years, so I only have to look
at new warnings.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
