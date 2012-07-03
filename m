From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] clkdev: Add default clkdev.h
Date: Tue, 3 Jul 2012 12:00:59 +1000
Message-ID: <20120703120059.f153bd696269528be2baa1bc@canb.auug.org.au>
References: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__3_Jul_2012_12_00_59_+1000_tbGYG/EGtljIZqld"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from haggis.pcug.org.au ([203.10.76.10]:46205 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2GCCBI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jul 2012 22:01:08 -0400
In-Reply-To: <1341252250-26476-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, mturquette@ti.com, Russell King <linux@arm.linux.org.uk>

--Signature=_Tue__3_Jul_2012_12_00_59_+1000_tbGYG/EGtljIZqld
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon,  2 Jul 2012 19:04:10 +0100 Mark Brown <broonie@opensource.wolfsonmi=
cro.com> wrote:
>
> diff --git a/include/asm-generic/clkdev.h b/include/asm-generic/clkdev.h
> new file mode 100644
> index 0000000..c362a9d
> --- /dev/null
> +++ b/include/asm-generic/clkdev.h
> @@ -0,0 +1,26 @@
> +/*
> + *  include/asm-generic/clkdev.h
> + *
> + * Based on the ARM clkdev.h:
> + *  Copyright (C) 2008 Russell King.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Helper for the clk API to assist looking up a struct clk.
> + */
> +#ifndef __ASM_CLKDEV_H
> +#define __ASM_CLKDEV_H
> +
> +#include <linux/slab.h>
> +
> +#define __clk_get(clk)	({ 1; })
> +#define __clk_put(clk)	do { } while (0)

So why not:

struct clk;

static inline int __clk_get(struct clk *clk) { return 1; }
static inline void __clk_put(struct clk *clk) ( )

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__3_Jul_2012_12_00_59_+1000_tbGYG/EGtljIZqld
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP8lJbAAoJEECxmPOUX5FERD0P/jY9Jmbo6Lv3Z/XLqd2td2K7
gpu+3rJpBRRmdvayST1u3O1J5Rp8CZ6BChMQhyixRmXQ3giDex352NMW6pVJ9zi2
jAiy+sbGDyJwtElcKjgZ7nDuQydp5cMd97u2YNoqW/dnzKVRd+3HVspYqmfWb7px
5zkFkT+50U6rg1pAMcku9dtTbWznSSRMLoGN83DTJac0iUBZQYaRZyEhHikOSoMq
Al59eHi/UCfOMBgUNuF7WrJY2tKCBRU/ufjOIqA6E+PbkMwgGn35d4JMxXD5dimJ
7vxDzsOryOGWinKx9+d7LndviDA0//Q37EP+54rNOHA2v/UCYtdlriSkPl3rZez6
20fvHP4sI0xbP0MG2RBsoEQ5Ctr/R0cakrpq1cuu1w0Ykv+OXwIjclEP8u8irfIv
Powjwp5JjChYRhBhlGWkweBLgH9LafRmF/3KYLokUp6QzT+MCsxzbYSfdZv+Wsuk
Lz6nDPJl27Pkz3iVVlvOhZa3CuDOrmK0PkFmWajILWVzeoSRNcWP3CgpXDh7MaSu
LWp3cNVb7spB+JrOSWm7h9Ne//z6HCkaTAf4M3FdeWQuse+0miWZ1uXO2PHTe8Ub
Ze+5loGz8hpuiHYl6X/lv/pCOKc5yxbzvu7j2JjV0g23JezcOj7iaGK6HYAXMkQ1
EugfOvJzXO7P7VPHuHCE
=5s1b
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Jul_2012_12_00_59_+1000_tbGYG/EGtljIZqld--
