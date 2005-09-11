Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 11 Sep 2005 09:50:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: [RFC] killing linux/irq.h
In-Reply-To: <20050909184254.GT9623@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0509110949390.30752@numbat.sonytel.be>
References: <20050909184254.GT9623@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: viro@ZenIV.linux.org.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 	We get regular portability bugs when somebody decides to include
> linux/irq.h into a driver instead of asm/irq.h.  It's almost always a
> wrong thing to do and, in fact, causes immediate breakage on e.g. arm.

Wouldn't it be more logical to make linux/irq.h the preferred include?
Usually the linux/* versions are preferred over the asm/* versions.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
