Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47866 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab2D2I2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 29 Apr 2012 04:28:09 -0400
MIME-Version: 1.0
In-Reply-To: <20120428205919.GC7442@merkur.ravnborg.org>
References: <20120428205651.GA7426@merkur.ravnborg.org>
	<20120428205919.GC7442@merkur.ravnborg.org>
Date: Sun, 29 Apr 2012 10:28:08 +0200
Message-ID: <CAMuHMdUWFFvD26YyVYyyYAAacjwNhZ-pmHe6ap0raPo1jGRB9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
Message-ID: <20120429082808.CT3NqaIBmbPfL-1nhzX9jjyYmuNvaCckgybFRR2jMv0@z>

On Sat, Apr 28, 2012 at 22:59, Sam Ravnborg <sam@ravnborg.org> wrote:
> Move the final link of vmlinux to a script to improve
> readability and maintainability of the code.
> The Makefil fragments used to link vmlinux has over the

Makefile

> years seen far too much changes and the logic was very

... too many ...

> hard to follow.

> "um" has special link requirments - and the
> only was to handle this was to hard-code the linking

only way ...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
