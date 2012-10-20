From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/11] m68k: use asm-generic headers when possible
Date: Sat, 20 Oct 2012 16:46:46 +0200
Message-ID: <CAMuHMdU_=3-_UcWMT2yBif5dX30963sqNz4CV+_KjTSAZwBS9w@mail.gmail.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56813 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab2JTOqs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 20 Oct 2012 10:46:48 -0400
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gerg@snapgear.com
Cc: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org

Hi Greg,

On Mon, Oct 15, 2012 at 8:49 AM,  <gerg@snapgear.com> wrote:
> On Arnd's suggestion I have gone through the m68k asm headers and weeded
> out a bunch that are identical (or near enough) to the asm-generic versions
> of these files.

Thanks, looks great!

(my first thought a few days ago was "Oh no, we're changing to the correct
padding for e.g. time_t", but apparently the asm-generic versions do it wrong
on big endian platforms, too ;-)

Do you plan to resubmit for the uapi header changes I have already queued?
Or shall I try to rebase it myself, using Stephen's fix?
Note that termios.h now needs 2 changes, as it's split in uapi and normal
(kernel use only).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
