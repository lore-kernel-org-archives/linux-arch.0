From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 12/27] asm-generic: add a NOMMU uaccess.h
Date: Mon, 4 May 2009 09:24:19 +0200
Message-ID: <10f740e80905040024w65493f4cvb0fa0f0bbd432e65@mail.gmail.com>
References: <cover.1241105648.git.arnd@arndb.de>
	 <45b4644e80c27b9d042b3960e3d99f0d444e0d92.1241105648.git.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:61347 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZEDHYU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2009 03:24:20 -0400
In-Reply-To: <45b4644e80c27b9d042b3960e3d99f0d444e0d92.1241105648.git.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Thu, Nov 6, 2008 at 17:31, Arnd Bergmann <arnd@arndb.de> wrote:
> index 549cb3a..ebeacd9 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h

> +/*
> + * User space memory access functions, these should work
> + * on a ny machine that has kernel and user data in the same
         any

> + * address space, e.g. all NOMMU machines.
> + */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
