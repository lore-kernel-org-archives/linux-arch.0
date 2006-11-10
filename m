Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:51912 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1946549AbWKJMsE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Nov 2006 07:48:04 -0500
Date: Fri, 10 Nov 2006 23:47:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] Add arch specific dev_sysdata to struct device
Message-Id: <20061110234757.27677dcd.sfr@canb.auug.org.au>
In-Reply-To: <1163141930.4982.143.camel@localhost.localdomain>
References: <1163141930.4982.143.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__10_Nov_2006_23_47_57_+1100_ogplGm7VC7tMfJ4O"
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

--Signature=_Fri__10_Nov_2006_23_47_57_+1100_ogplGm7VC7tMfJ4O
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2006 17:58:50 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Adds an arch specific struct dev_sysdata to struct device. This enables
> architecture to add specific fields to every device in the system, like
> DMA operation pointers, NUMA node ID, firmware specific data, etc...
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I would have done this by creating a single line asm-xxx/device.h containing

#include <asm-generic/device.h>

(except for asm-generic, of course)  and then as each architecture implements
its own dev_sysdata, it can flesh out its asm/device.h.

Also, I would use _ASM_<ARCH>_DEVICE_H, but thats just my preference.

Just suggestions.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__10_Nov_2006_23_47_57_+1100_ogplGm7VC7tMfJ4O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVHUHFdBgD/zoJvwRAvVvAJwNxavZbJxtB06bOsfHemseDYYFnACfYqf8
2kBB1hCP2Dy5lG8vIeQyCX4=
=eH8y
-----END PGP SIGNATURE-----

--Signature=_Fri__10_Nov_2006_23_47_57_+1100_ogplGm7VC7tMfJ4O--
