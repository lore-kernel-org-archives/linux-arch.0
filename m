From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] arm: Preserve TPIDRURW on context switch
Date: Mon, 22 Apr 2013 15:36:16 +0100
Message-ID: <20130422143616.GP14496@n2100.arm.linux.org.uk>
References: <517168BB.3070903@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36369 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab3DVOg3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2013 10:36:29 -0400
Content-Disposition: inline
In-Reply-To: <517168BB.3070903@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: linux-arch@vger.kernel.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org

On Fri, Apr 19, 2013 at 05:54:35PM +0200, Andr=E9 Hentschel wrote:
> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Hentschel?=3D <nerv@dawncrow.de>
>=20
> There are more and more applications coming to WinRT, Wine could supp=
ort them,
> but mostly they expect to have the thread environment block (TEB) in =
TPIDRURW.
> This register must be preserved per thread instead of being cleared.
>=20
> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>

This actually makes things less efficient all round, because you
now use the value immediately after loading, which means it will cause
pipeline stalls, certainly on older CPUs.

Could you please rework the patch to try avoiding soo many modification=
s
to the way things have been done here?
