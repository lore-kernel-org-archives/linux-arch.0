From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/3] powerpc: export all symbols from the definition file
Date: Mon, 11 Aug 2008 17:27:07 +0200
Message-ID: <200808111727.07720.arnd@arndb.de>
References: <200808111606.44103.arnd@arndb.de> <200808111617.53305.arnd@arndb.de> <Pine.LNX.4.64.0808111653170.3030@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58183 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbYHKP1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Aug 2008 11:27:23 -0400
In-Reply-To: <Pine.LNX.4.64.0808111653170.3030@vixen.sonytel.be>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@ozlabs.org
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>

On Monday 11 August 2008, Geert Uytterhoeven wrote:
> > =A0drivers/macintosh/adb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 ++=
+++
> > =A0drivers/macintosh/via-cuda.c =A0 =A0 =A0 =A0 | =A0 =A03 +++
>=20
> I think these 2 belong to patch 3?

I tried to come up with other ways of splitting up the patch,
but since these come from ppc_ksyms, it makes sense to keep
them with the rest.

Maybe I could split the exports for C functions from those
in assember files that depend on patch 1.

	Arnd <><
