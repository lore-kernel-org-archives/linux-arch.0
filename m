From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/15] m68k: add renameat2 syscall
Date: Mon, 21 Apr 2014 10:10:29 +0200
Message-ID: <CAMuHMdUtPucUNXDt=o_avzSCMvL9bwn-A6WH5dY4ZazGPj2QnA@mail.gmail.com>
References: <1397211951-20549-1-git-send-email-miklos@szeredi.hu>
	<1397211951-20549-7-git-send-email-miklos@szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:40065 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaDUIKb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Apr 2014 04:10:31 -0400
In-Reply-To: <1397211951-20549-7-git-send-email-miklos@szeredi.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miklos Szeredi <mszeredi@suse.cz>

Hi Miklos,

On Fri, Apr 11, 2014 at 12:25 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> --- a/arch/m68k/kernel/syscalltable.S
> +++ b/arch/m68k/kernel/syscalltable.S
> @@ -371,4 +371,5 @@ ENTRY(sys_call_table)
>         .long sys_finit_module
>         .long sys_sched_setattr
>         .long sys_sched_getattr         /* 350 */
> +       .long sys_sched_renameat2

"sys_renameat2", please.

Sorry for not noticing before I threw it at the compiler.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
