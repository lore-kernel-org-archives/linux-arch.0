From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] asm-generic/io.h: Implement read[bwlq]_relaxed()
Date: Tue, 9 Sep 2014 14:31:20 +0200
Message-ID: <CAMuHMdWvyfPxHKWD3MkgDQRaf4xQUzVq561C1BHiNC_stQ-Rqw@mail.gmail.com>
References: <1410264760-29756-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:42482 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbaIIMbW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Sep 2014 08:31:22 -0400
In-Reply-To: <1410264760-29756-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Will Deacon <will.deacon@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Daniel,

On Tue, Sep 9, 2014 at 2:12 PM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> Currently the read[bwlq]_relaxed() family are implemented on every
> architecture except blackfin, m68k[1], metag, openrisc, s390[2] and
> score. Increasingly drivers are being optimized to exploit relaxed
> reads putting these architectures at risk of compilation failures for
> shared drivers.
>
> This patch addresses this by providing implementations of
> read[bwlq]_relaxed() that are identical to the equivalent read[bwlq]().
> All the above architectures include asm-generic/io.h .

m68k does not include asm-generic/io.h.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
