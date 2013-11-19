From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] asm/types.h: Remove include/asm-generic/int-l64.h
Date: Tue, 19 Nov 2013 13:35:40 +0100
Message-ID: <201311191335.40506.arnd@arndb.de>
References: <1376996476-12027-2-git-send-email-geert@linux-m68k.org> <1384859955-27837-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384859955-27837-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Randy Dunlap <rdunlap@xenotime.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 19 November 2013, Geert Uytterhoeven wrote:
> Now all 64-bit architectures have been converted to int-ll64.h, we can
> remove int-l64.h in kernelspace.
> 
> For backwards compatibility, alpha, ia64, mips64, and powerpc64 still use
> int-l64.h in userspace.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks for following up with this.

> ---
> This is the (reworked for UAPI) non-documentation part of more than two
> year old "asm/types.h: All architectures use int-ll64.h in kernelspace"
> (https://lkml.org/lkml/2011/8/13/104)
> 
> Since <asm/types.h> (from include/uapi/asm-generic/types.h) is used for
> both kernel and user space, include/asm-generic/int-ll64.h cannot just
> become include/asm-generic/types.h, as Arnd suggested.

I'm pretty sure you are right with this, but I don't remember at all
what I suggested and don't understand what the problem (if any) is.
Can you remind me?

	Arnd
