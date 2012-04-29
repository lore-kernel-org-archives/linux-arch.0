Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33691 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2D2I00 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 29 Apr 2012 04:26:26 -0400
MIME-Version: 1.0
In-Reply-To: <20120428205651.GA7426@merkur.ravnborg.org>
References: <20120428205651.GA7426@merkur.ravnborg.org>
Date: Sun, 29 Apr 2012 10:26:25 +0200
Message-ID: <CAMuHMdXsSva4U+-dnyGYOEPGcFWaTSBwkfs_b9JNjW=gxUiQXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kbuild: Move vmlinux link out of top-level Makefile
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
Message-ID: <20120429082625.MMIeDW4skUOY5r6j7mVOUVyWughx3LqJ66eAu0U8wGk@z>

On Sat, Apr 28, 2012 at 22:56, Sam Ravnborg <sam@ravnborg.org> wrote:
> anyway - so there where nothing gained by using

... there was ...

> - We no logner rebuild if one of the .tmp_kallsyms

longer

>  files are deleted.

... is deleted

> - rebuild if options to ld changes (Andi Kleen)

change

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
