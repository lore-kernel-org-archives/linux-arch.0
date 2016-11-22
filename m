Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33857 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbcKVQok (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2016 11:44:40 -0500
Received: by mail-qt0-f173.google.com with SMTP id n6so15710745qtd.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Nov 2016 08:43:42 -0800 (PST)
Date: Tue, 22 Nov 2016 11:34:48 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for
 ARM
In-Reply-To: <20161122110557.1533467-1-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr>
References: <20161122110557.1533467-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1586173819-1479832489=:1814"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>, linux-arm-kernel@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, linux-kernel@vger.kernel.org
Message-ID: <20161122163448.23-q5XQJrArKQqkMLnRUOyIorAezW2IHfYt7OY1FFCA@z>

--8323328-1586173819-1479832489=:1814
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 22 Nov 2016, Arnd Bergmann wrote:

> This adds an asm/asm-prototypes.h header for ARM to fix the broken symbol
> versioning for symbols exported from assembler files.
> 
> I couldn't find the correct prototypes for the compiler builtins,
> so I went with the fake 'void f(void)' prototypes that we had
> before, restoring the state before they were moved.
> 
> Originally I assumed that the problem was just a harmless warning
> in unusual configurations, but as Uwe found, we actually need this
> to load most modules when symbol versioning is enabled, as it is
> in many distro kernels.
> 
> Cc: Uwe Kleine-König <uwe@kleine-koenig.org>
> Fixes: 4dd1837d7589 ("arm: move exports to definitions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Compared to the earlier version, I dropped the changes to the
> csumpartial files, which now get handled correctly by Kbuild
> even when the export comes from a macro, and I also dropped the
> changes to the bitops files, which were already fixed in a
> patch from Nico.
> 
> The patch applies cleanly on top of the rmk/fixes tree but has
> no effect there, as it also needs 4efca4ed05cb ("kbuild: modversions
> for EXPORT_SYMBOL() for asm") and cc6acc11cad1 ("kbuild: be more
> careful about matching preprocessed asm ___EXPORT_SYMBOL").
> 
> With the combination of rmk/fixes, torvalds/master and these two
> patches, symbol versioning works again on ARM. As it is still
> broken on almost all other architectures (powerpc is fixed,
> x86 has a patch), I wonder if we should make CONFIG_MODVERSIONS
> as broken for everything else.

I'm not sure I like this at all.

The goal for moving EXPORT_SYMBOL() to assembly code where symbols were 
defined is to make things close together and avoid those centralized 
list of symbols that you can easily miss when modifying the actual code.

This series is therefore bringing back a centralized list of symbols in 
a slightly different form, nullifying the advantages from having moved 
EXPORT_SYMBOL() to asm code.  To me this looks like a big step backward.

Why not simply extending the original idea of keeping exports close to 
the actual code by _also_ having a macro that provides the function 
prototype alongside the EXPORT_SYMBOL() instance?  That could even be 
expressed with some EXPORT_SYMBOL_PROTO(ret, sym, arg...) macro that 
does it all.


Nicolas
--8323328-1586173819-1479832489=:1814--
