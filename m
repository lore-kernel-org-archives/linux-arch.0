From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on
 context switch and fork in compat mode
Date: Tue, 5 May 2015 11:51:11 +0100
Message-ID: <20150505105111.GB1550@arm.com>
References: <55464BB2.7030401@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44373 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400AbbEEKvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 May 2015 06:51:17 -0400
Content-Disposition: inline
In-Reply-To: <55464BB2.7030401@dawncrow.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>

On Sun, May 03, 2015 at 05:24:18PM +0100, Andr=E9 Hentschel wrote:
> From: Andr=E9 Hentschel <nerv@dawncrow.de>
>=20
> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writea=
ble TLS
> register on ARM is preserved per thread.
>=20
> This patch does it analogous to the ARM patch, but for compat mode on=
 ARM64.
>=20
> Signed-off-by: Andr=E9 Hentschel <nerv@dawncrow.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jonathan Austin <jonathan.austin@arm.com>=20
>=20
> ---
> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641e=
fa74a031)

Curious, but why do you need this? iirc, we added this for arch/arm/ be=
cause
of some windows rt (?) emulation in wine. Is that still the case here a=
nd is
anybody actually using that?

Will
