Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 17 Mar 2005 22:57:25 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: Consolidation of asm/unaligned.h
In-Reply-To: <20050317104744.4be7e550.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0503172255380.8760@numbat.sonytel.be>
References: <20050317104744.4be7e550.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 17 Mar 2005, David S. Miller wrote:
> 6) M68K can do unaligned access directly.

Just for the record, this is true for 68020 and later only. I.e. some MMU-less
variants need unaligned support.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
