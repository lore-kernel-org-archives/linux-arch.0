Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39253 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab1DTHsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2011 03:48:45 -0400
MIME-Version: 1.0
In-Reply-To: <1303248576.11237.23.camel@mulgrave.site>
References: <1303248576.11237.23.camel@mulgrave.site>
Date: Wed, 20 Apr 2011 09:48:43 +0200
Message-ID: <BANLkTinyvO78OnKZGW3jB_N6uao0tppnAw@mail.gmail.com>
Subject: Re: slub: fix panic with DISCONTIGMEM
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-arch@vger.kernel.org, linux-mm@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, Christoph Lameter <cl@linux.com>, Thorsten Glaser <tg@mirbsd.de>, Michael Schmitz <schmitzmic@googlemail.com>, Linux/m68k <linux-m68k@vger.kernel.org>
Message-ID: <20110420074843.XgzW5_ea7rMbpfc_5znNetLDwJ6J1R4EN3DRv1pMuQY@z>

On Tue, Apr 19, 2011 at 23:29, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Slub makes assumptions about page_to_nid() which are violated by
> DISCONTIGMEM and !NUMA.  This violation results in a panic because
> page_to_nid() can be non-zero for pages in the discontiguous ranges and
> this leads to a null return by get_node().  The assertion by the
> maintainer is that DISCONTIGMEM should only be allowed when NUMA is also
> defined.  However, at least six architectures: alpha, ia64, m32r, m68k,
> mips, parisc violate this.  The panic is a regression against slab, so
> just mark slub broken in the problem configuration to prevent users
> reporting these panics.

How does the problem manifest itself? We're having a problem on m68k, which
seems to go away when switching from SLUB to SLAB, or when reverting a commit
in [2] (probably this was never reported upstream).

References:
[1] http://www.mail-archive.com/linux-m68k@vger.kernel.org/msg02812.html
[2] http://www.spinics.net/lists/linux-m68k/msg03401.html

> Cc: stable@kernel.org
> Signed-off-by: James Bottomley <James.Bottomley@suse.de>
>
> ---
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 56240e7..a7ad8fb 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1226,6 +1226,7 @@ config SLAB
>          per cpu and per node queues.
>
>  config SLUB
> +       depends on BROKEN || NUMA || !DISCONTIGMEM
>        bool "SLUB (Unqueued Allocator)"
>        help
>           SLUB is a slab allocator that minimizes cache line usage

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
