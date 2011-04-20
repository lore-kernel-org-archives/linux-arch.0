From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: slub: fix panic with DISCONTIGMEM
Date: Wed, 20 Apr 2011 09:48:43 +0200
Message-ID: <BANLkTinyvO78OnKZGW3jB_N6uao0tppnAw@mail.gmail.com>
References: <1303248576.11237.23.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303248576.11237.23.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-arch@vger.kernel.org, linux-mm@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, Christoph Lameter <cl@linux.com>, Thorsten Glaser <tg@mirbsd.de>, Michael Schmitz <schmitzmic@googlemail.com>, Linux/m68k <linux-m68k@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 19, 2011 at 23:29, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Slub makes assumptions about page_to_nid() which are violated by
> DISCONTIGMEM and !NUMA. =C2=A0This violation results in a panic becau=
se
> page_to_nid() can be non-zero for pages in the discontiguous ranges a=
nd
> this leads to a null return by get_node(). =C2=A0The assertion by the
> maintainer is that DISCONTIGMEM should only be allowed when NUMA is a=
lso
> defined. =C2=A0However, at least six architectures: alpha, ia64, m32r=
, m68k,
> mips, parisc violate this. =C2=A0The panic is a regression against sl=
ab, so
> just mark slub broken in the problem configuration to prevent users
> reporting these panics.

How does the problem manifest itself? We're having a problem on m68k, w=
hich
seems to go away when switching from SLUB to SLAB, or when reverting a =
commit
in [2] (probably this was never reported upstream).

References:
[1] http://www.mail-archive.com/linux-m68k@vger.kernel.org/msg02812.htm=
l
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
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0per cpu and per node queues.
>
> =C2=A0config SLUB
> + =C2=A0 =C2=A0 =C2=A0 depends on BROKEN || NUMA || !DISCONTIGMEM
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "SLUB (Unqueued Allocator)"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SLUB is a slab allocator that mini=
mizes cache line usage

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
