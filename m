Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 1 Nov 2005 08:50:43 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
In-Reply-To: <20051101065327.GP22601@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0511010850190.2739@numbat.sonytel.be>
References: <14.196662837@selenic.com> <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be>
 <20051031211422.GC4367@waste.org> <20051101065327.GP22601@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Willy Tarreau <willy@w.ods.org>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 1 Nov 2005, Willy Tarreau wrote:
> But if it's a pointer why don't you declare them unsigned long then ?
> C defines the long as the integer the right size to store a pointer.
  ^
Is it C?

Since on Wintendo P64 it's not true...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
