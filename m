From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 09:57:20 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0812110956410.7310@anakin>
References: <cover.1228966585.git.kyle@mcmartin.ca> <cover.1228966585.git.kyle@mcmartin.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yorgi.telenet-ops.be ([195.130.133.69]:60262 "EHLO
	yorgi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYLKI5y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 03:57:54 -0500
Received: from nelson.telenet-ops.be (nelson.telenet-ops.be [195.130.133.66])
	by yorgi.telenet-ops.be (Postfix) with ESMTP id 393D0680507
	for <linux-arch@vger.kernel.org>; Thu, 11 Dec 2008 09:57:53 +0100 (CET)
In-Reply-To: <cover.1228966585.git.kyle@mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org

On Thu, 11 Dec 2008, Kyle McMartin wrote:
> Create a common kernel/init_task.c, and convert low hanging fruit to
> use it. Architecture maintainers will need to ensure that I didn't
> break anything before applying the init_task removal patch to their
> arch.
> 
> A few architectures appear to possibly rely on link-ordering (with
> an extra-y makefile rule) and may need additional linker script rules.
> 
> Unconverted architectures so far are m68k (because it doesn't use an explicit
> init_task.c), ia64 (because it faffs about with init_thread_union), and
> sparc{,64} (which appear to rely on some magic.)

m68k just has the same code as anyone else embedded in
arch/m68k/kernel/process.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
