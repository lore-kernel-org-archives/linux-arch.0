Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35105 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbcBAKw2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Feb 2016 05:52:28 -0500
MIME-Version: 1.0
In-Reply-To: <1454095114-4128-5-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
	<1454095114-4128-5-git-send-email-viro@ZenIV.linux.org.uk>
Date: Mon, 1 Feb 2016 11:52:27 +0100
Message-ID: <CAMuHMdXTu9t9Jnd4F2X=U16X9psF-_oxj5Oxd6tz9wnK+BY2sQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] m68k: move exports to definitions
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20160201105227.7-TCletHL22WUA4p_RsBAiL34Oes3rVgHCIKQNuKMPY@z>

Hi Al,

On Fri, Jan 29, 2016 at 8:18 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> the rest of architectures should just use generic-y += export.h in
> asm/Kbuild
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good, and (some of, not all) the symbols end up in kstrtab, so

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Note that none of the m68k defconfigs build modules that refer to these
symbols. This changes completely with allmodconfig, which adds lots of
references in many of the same modules.
CONFIG_LBDAF=y is set in the defconfigs.

Unfortunately I haven't managed to boot a kernel that uses these symbols
in modules...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
