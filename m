From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/24] Unify integer type definitions, and add fixed type
 constructor macros
Date: Fri, 25 Apr 2008 09:17:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804250915030.21224@anakin>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759274AbYDYHRq@vger.kernel.org>
In-Reply-To: <1209078352-7593-1-git-send-email-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 24 Apr 2008, H. Peter Anvin wrote:
> This patchset unifies the integer definitions across all the
> <asm-*/types.h> files, replacing them with two asm-generic files, one
> for the LL64 model (all 32-bit architectures plus x86-64) and one for
> the L64 model (all other 64-bit architectures.)

Just a minor nitpick, what about calling them LP32 and LP64, like
everybody else does?
I.e. asm-generic/types-lp{32,64}.h?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
