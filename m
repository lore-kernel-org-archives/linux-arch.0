From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/18] m68k: io: implement dummy relaxed accessor macros
 for writes
Date: Thu, 17 Apr 2014 18:07:28 +0200
Message-ID: <CAMuHMdV15kdRincp9EbVhEUDSp4GzP86BLRFV8X_Zbhq+hwX0g@mail.gmail.com>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
	<1397742261-15621-11-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:61720 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaDQQHa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 12:07:30 -0400
In-Reply-To: <1397742261-15621-11-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Mark Brown <broonie@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Thu, Apr 17, 2014 at 3:44 PM, Will Deacon <will.deacon@arm.com> wrote:
> write{b,w,l}_relaxed are implemented by some architectures in order to
> permit memory-mapped I/O accesses with weaker barrier semantics than the
> non-relaxed variants.
>
> This patch adds dummy macros for the write accessors to m68k, in the
> same vein as the dummy definitions for the relaxed read accessors.
> Additionally, the existing relaxed read accessors are moved into
> asm/io.h, so that they can be used by m68k targets with an MMU.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
