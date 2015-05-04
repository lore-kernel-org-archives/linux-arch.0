From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 01/10] m68k: use for_each_sg()
Date: Mon, 4 May 2015 11:04:31 +0200
Message-ID: <CAMuHMdVT6wMjj3kf64T12KiVXYwET3LySNbmbgUyOXX3UpO1oQ@mail.gmail.com>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33478 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbEDJEb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 05:04:31 -0400
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, May 1, 2015 at 3:56 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> This replaces the plain loop over the sglist array with for_each_sg()
> macro which consists of sg_next() function calls.  Since m68k doesn't
> select ARCH_HAS_SG_CHAIN, it is not necessary to use for_each_sg() in
> order to loop over each sg element.  But this can help find problems
> with drivers that do not properly initialize their sg tables when
> CONFIG_DEBUG_SG is enabled.
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-arch@vger.kernel.org
> ---
> * Changes from v1
> - Update commit log

Thanks, applied, and queued for v4.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
