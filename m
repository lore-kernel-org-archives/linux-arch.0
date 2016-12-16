Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759275AbcLPWAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 17:00:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] minimum gcc version for kernel: raise to gcc-4.3 or 4.6?
Date: Fri, 16 Dec 2016 23:00:27 +0100
Message-ID: <2778134.jZdhGefl4B@wuerfel>
In-Reply-To: <20161216170043.taaanbg5objnxjlh@breakpoint.cc>
References: <20161216105634.235457-1-arnd@arndb.de> <20161216170043.taaanbg5objnxjlh@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20161216220027.lEECZtmxLZGuUceEIdP-wzBBecX_cFm5SsF-3SPLj2k@z>

On Friday, December 16, 2016 6:00:43 PM CET Sebastian Andrzej Siewior wrote:
> On 2016-12-16 11:56:21 [+0100], Arnd Bergmann wrote:
> > The original gcc-4.3 release was in early 2008. If we decide to still
> > support that, we probably want the first 10 quirks in this series,
> > while gcc-4.6 (released in 2011) requires none of them.
> 
> It this min gcc thingy ARM only?

This is part of the question that I'm trying to figure out myself.

Clearly having the same minimum version across all architectures simplifies
things a lot, because many of the bugs in old versions are architecture
independent. Then again, some architectures implicitly require a new version
because an old one never existed (e.g. arm64 or risc-v), while some other
architectures may require an old version.

	Arnd
