From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] include: asm-generic: page.h: Remove useless
 get_user_page and free_user_page
Date: Thu, 19 Nov 2015 00:11:26 +0000
Message-ID: <20151119001126.GT8644@n2100.arm.linux.org.uk>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:38733 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbbKSALv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2015 19:11:51 -0500
Content-Disposition: inline
In-Reply-To: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <xili_gchen_5257@hotmail.com>
Cc: "vgupta@synopsys.com" <vgupta@synopsys.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "gerg@uclinux.org" <gerg@uclinux.org>, "jonas@southpole.se" <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>, "abrodkin@synopsys.com" <abrodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, kernel mailing list <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux@lists.openrisc.net

On Thu, Nov 19, 2015 at 03:40:25AM +0800, Chen Gang wrote:
> >From ba7c00c4cb976109b6a35812ce9649aaeda81e2d Mon Sep 17 00:00:00 20=
01
> From: Chen Gang <gang.chen.5i5j@gmail.com>
> Date: Thu, 19 Nov 2015 03:24:42 +0800
> Subject: [PATCH] include: asm-generic: page.h: Remove useless get_use=
r_page and free_user_page
>=20
> They are not symmetric with each other, neither are used in real worl=
d
> (can not be found by grep command in source code root directory), so
> remove them.
>=20
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

=46or:
> =A0arch/arm/include/asm/page-nommu.h | 3 ---

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

--=20
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
