From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] include/asm-generic/io.h: add 'UML' case just like 'no-MMU'
Date: Wed, 26 Jun 2013 09:38:48 +0200
Message-ID: <CAMuHMdU-eWL-PtR64pdXw3mpjHxdx7Geym29E5KpATSe5QvBEg@mail.gmail.com>
References: <51CA8AB8.7080504@asianux.com>
	<51CA900E.9020407@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:39270 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab3FZHit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 03:38:49 -0400
In-Reply-To: <51CA900E.9020407@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Chen Gang <gang.chen@asianux.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, David Sharp <dhsharp@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Wed, Jun 26, 2013 at 8:54 AM, Richard Weinberger <richard@nod.at> wrote:
>> -#ifndef CONFIG_MMU
>> +#if !CONFIG_MMU || CONFIG_UML

FWIW, the above syntax is not correct, it should be

#if !defined(CONFIG_MMU) || defined(CONFIG_UML)

> UML has no io memory but a MMU, so I'd argue that you better fix drivers/ptp/ptp_pch.c dependencies.
> _If_ ptp_pch.c really works without real io memory, you can look what I did in my GENERIC_IO series[1]
> to make nandsim work on UML. Maybe this helps.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
