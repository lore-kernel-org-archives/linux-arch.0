From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: request_mem_region() for noPCI devices
Date: Fri, 18 Jan 2013 17:04:36 +0100
Message-ID: <CAMuHMdUbTVMpYGrweXjXQrhd4U6yyGGRHmzZHBL2v_GbHRHF6w@mail.gmail.com>
References: <CAHTX3dJ2Qqs6QxJEcd24KW5y2DSumLy82jvVUxBjjMWQULrxdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:45062 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab3ARQEh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 11:04:37 -0500
In-Reply-To: <CAHTX3dJ2Qqs6QxJEcd24KW5y2DSumLy82jvVUxBjjMWQULrxdQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Fri, Jan 18, 2013 at 3:46 PM, Michal Simek <monstr@monstr.eu> wrote:
> just want to check with you usage of request_mem_region for noPCI devices.
> kernel/resource.c suggests that it should be used just for PCI iomem
> (iomem_resource uses name PCI mem).
>
> If I grep architectures I see several usage for noPCI devices.
>
> Does it mean that request_mem_region should be used for all devices
> which request io memory? Or just for PCI iomem?

It's meant for all types of memory mapped I/O.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
