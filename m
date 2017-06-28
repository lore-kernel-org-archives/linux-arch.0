From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 7/9] RISC-V: Paging and MMU
Date: Thu, 29 Jun 2017 00:09:59 +0100
Message-ID: <20170628230959.GQ6973@jhogan-linux.le.imgtec.org>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-8-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jIondxHzhZPVGMQ8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:50408 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751626AbdF1XKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 19:10:01 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-8-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

--jIondxHzhZPVGMQ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jun 28, 2017 at 11:55:36AM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> new file mode 100644
> index 000000000000..e1491c20d6fd
> --- /dev/null
> +++ b/arch/riscv/include/asm/page.h
...
> +#ifdef __KERNEL__

I think thats a given outside of uapi.

Cheers
James

--jIondxHzhZPVGMQ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllUN0YACgkQbAtpk944
dnouJA/9GBZL35M0IBpXfOkH2ElZ6qc4D+MNvgLe7igdMvuehdJcCxeQr+rK132p
5xudh3iesBVhT0oIN+Pmu84ePwp6t8/+MiMPVbcFYfEvXHqGVnbD27mN1N2b/sdU
LqP6DCS/YjqfY2VU2yNRhkCXKALvyRDgM120eb8XbNk8l+NEtS/8mqM5OXfwFc5w
Ka7W7Mv2I3nT/2SnpN+6cWqAVRRtYwQwm+smyIgcQGzsSwCI6WOQv6LMQz3ekL2K
sthKKVpqhCVCJi7DFUlS13trjBT0wacnbekzi/S3k/QwMtfFCbdUpFl3YilX58xp
xwPzD6YTH3CgjM4NhN/PGhytebiUwwQuMOxWKhwb/JO2A+9lryeGAGmvSorVTPJy
vxJD7ukAcB0JCwe6X4fHxAweSyI3GRX5T/NPNYWRwsl6N3YN/5IxmmubsEKOSPGh
LzbLsDvcEsluq3TtUlYnc7kNKX+IgjGMJb3Fya/cOqTtChV3sR4A508GYlQTx+yB
+1z/E64vFvcah3fQl6OYNsfSmiEPO6+kBxqEYCceWu5Y+ClGSjPvQOZcQEBOGuzw
qu7CE5KB6V7+CJKG0wqUC88bn7RUlZqgQWh55ENVe6BiZ8q8JmVH19ryhS5Siqfe
MfoUU8OwaicwGToclokxaSB0mepAadHONPDoh8XDUYwB1TMejNI=
=gMO6
-----END PGP SIGNATURE-----

--jIondxHzhZPVGMQ8--
