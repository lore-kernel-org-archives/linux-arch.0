Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be ([80.88.33.193]:9697 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264948AbUEQJMI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2004 05:12:08 -0400
Date: Mon, 17 May 2004 11:11:59 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
In-Reply-To: <40A60984.1070202@colorfullife.com>
Message-ID: <Pine.GSO.4.58.0405171111300.19405@waterleaf.sonytel.be>
References: <40A60984.1070202@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 15 May 2004, Manfred Spraul wrote:
> The slab allocator keeps track of the free objects in a slab with a
> linked list of integers (typedef'ed to kmem_bufctl_t). Right now
> unsigned int is used for kmem_bufctl_t, i.e. 4 bytes per-object overhead.
> The attached patch allows an arch override for this type: Theoretically,
> unsigned short is sufficient for kmem_bufctl_t and this would reduce the
> per-object overhead to 2 bytes. But some archs cannot operate on 16-bit
> values efficiently, thus it's not possible to switch everyone to ushort.
> The patch switches i386, the port maintainers should switch their arch
> if there are no problems with 16-bit quantities. All accesses to
> kmem_bufctl_t are under a per-cache spinlock and not in the hottest path.

16-bit is no problem for m68k, so feel free to switch it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
