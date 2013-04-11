From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] m68k: Add -ffreestanding to KBUILD_CFLAGS
Date: Thu, 11 Apr 2013 20:04:31 +0200
Message-ID: <CAMuHMdXJWo=R28rexHJZGof==CgEa0gbC3yr18iPs-tAkv2FZQ@mail.gmail.com>
References: <1365585879-5321-1-git-send-email-geert@linux-m68k.org>
	<51653C5D.4060408@suse.cz>
	<CAMuHMdXEvLMz5rRjQrhENxJ6UHRnPCtzyNg=hqitspuY88G7sA@mail.gmail.com>
	<20130410122611.GB17541@sepie.suse.cz>
	<CAMuHMdUHiiBEZm7eFYtL3PqCXF6PjscbFKjiJ33BEwQ+YLKOXQ@mail.gmail.com>
	<20130410152229.GC17541@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37955 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936017Ab3DKSEc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Apr 2013 14:04:32 -0400
In-Reply-To: <20130410152229.GC17541@sepie.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>

On Wed, Apr 10, 2013 at 5:22 PM, Michal Marek <mmarek@suse.cz> wrote:
> Subject: [PATCH] m68k: Remove inline strlen() implementation
>
> GCC can replace a strncat() call with constant second argument into a
> strlen + store, which results in a link error:
>
> ERROR: "strlen" [net/ipv4/ip_tunnel.ko] undefined!
>
> The inline function is a simple for loop in C. Other architectures
> either use an asm optimized variant, or use the generic function from
> lib/string.c.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Michal Marek <mmarek@suse.cz>

Thanks, this one works. Let me do some measurements...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
