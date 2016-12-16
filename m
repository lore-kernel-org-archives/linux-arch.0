Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:59816 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761577AbcLPT6S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 14:58:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] minimum gcc version for kernel: raise to gcc-4.3 or 4.6?
Date: Fri, 16 Dec 2016 20:58:08 +0100
Message-ID: <3679707.TKdvBNIRe2@wuerfel>
In-Reply-To: <CAMuHMdUa4j8nxrW=fSJQZok3=mW-FWZWHR=cYS2R0gQUeGHgmQ@mail.gmail.com>
References: <20161216105634.235457-1-arnd@arndb.de> <CAMuHMdUa4j8nxrW=fSJQZok3=mW-FWZWHR=cYS2R0gQUeGHgmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu
Message-ID: <20161216195808.BR00k5X_yHQKbmuaFYbPcjw7oAPW0BjJOZOqBDhx0qc@z>

On Friday, December 16, 2016 4:54:33 PM CET Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Fri, Dec 16, 2016 at 11:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Specifically on ARM, going further makes things rather useless especially
> > for build testing: with gcc-4.2, we lose support for ARMv7, EABI, and
> > effectively ARMv6 (as it relies on EABI for building reliably). Also,
> > the number of false-positive build warnings is so high that it is useless
> > for finding actual bugs from the warnings.
> 
> If you start with that activity now, there's indeed a massive amount of
> warnings to look into.
> However, I've been build testing various configs with m68k-linux-gnu-gcc-4.1.2
> and looking at the compiler warnings for years, so I only have to look
> at new warnings.

What's the reason for sticking with gcc-4.1? Does this actually work better
for you than a more recent version, or is it just whatever you installed
when you started the build testing?

	Arnd
