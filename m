Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64183 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3KSMgQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Nov 2013 07:36:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] asm/types.h: Remove include/asm-generic/int-l64.h
Date: Tue, 19 Nov 2013 13:35:40 +0100
References: <1376996476-12027-2-git-send-email-geert@linux-m68k.org> <1384859955-27837-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1384859955-27837-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201311191335.40506.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Randy Dunlap <rdunlap@xenotime.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20131119123540.R9TYwWHgAkeBYuxHoHwEQbNLqGDZtu_-uw1SMaJYgX4@z>

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
