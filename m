Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:37792 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbeEJFII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2018 01:08:08 -0400
Date: Thu, 10 May 2018 07:08:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 5/8] export.h: remove code for prefixing symbols with
 underscore
Message-ID: <20180510050803.GA19160@ravnborg.org>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
 <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com>
 <20180509160727.GA7459@ravnborg.org>
 <CAK7LNATojTR5QbWNS2LCeRXTX-8Rj3P2VoZaYZQhY5Kb0fv1Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATojTR5QbWNS2LCeRXTX-8Rj3P2VoZaYZQhY5Kb0fv1Mg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180510050803.Co1YJJrDasSVO6N2dCATMGcvOZtr-FDZJmwU1dvEqbg@z>

Hi Mashahiro

> Anyway VMLINUX_SYMBOL(), VMLINUX_SYMBOL_STR() will not live long.
> I need some cycles for tree-wide cleaning, though.

Fine, then there is no need to discuss the details of their
current definition.

	Sam
