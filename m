From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 9/9] RISC-V: Build Infastructure
Date: Wed, 28 Jun 2017 22:25:00 +0100
Message-ID: <20170628212500.GN6973@jhogan-linux.le.imgtec.org>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-10-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VpRFFy90J6DTn7yH"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:3391 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751526AbdF1VZC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 17:25:02 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-10-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

--VpRFFy90J6DTn7yH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Palmer,

On Wed, Jun 28, 2017 at 11:55:38AM -0700, Palmer Dabbelt wrote:
> +	select SYSRISCV_ATOMIC if !ISA_A
...
> +config SYSRISCV_ATOMIC
> +	bool "Include support for atomic operation syscalls"
> +	default !ISA_A
> +	help
> +	  If atomic memory instructions are present, i.e.,
> +	  CONFIG_ISA_A, this includes support for the syscall that
> +	  provides atomic accesses.  This is only useful to run
> +	  binaries that require atomic access but were compiled with
> +	  -mno-atomic.
> +
> +	  If CONFIG_ISA_A is unset, this option is mandatory.
> +
> +	  If you don't know what to do here, say N.

Can this be removed now that you mentioned the atomics syscall being
mandatory? I can't find any other references to it.

Cheers
James

--VpRFFy90J6DTn7yH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllUHpcACgkQbAtpk944
dnocwA//X8ELwdxtCUCVeAsO7/aD0IZDlYq94atznAELV6tkReS1EUV6ALY0/k8L
NfWfEY4nrR1k0qREj/GX6RSWpOFiCMuhpQX760UWQM9fOgUG+goO9lZbJIFyKNI+
GV7/dFjPt24N/b1bBVNj4jKzsgSoduMWWWuyWteiqY32K22HHtklqcU93efSZqSi
tgxoe+MuwISJmyd9zX4VoArmRLU09EdVzspthKNLw4uNVx/2rvC8eNLRfmVRlk1R
l64P4Rounzd5rB47JWDuryJueFQBUYx5eb3+IC3rhkp7ZkNnWuUkNShmkAEmFzSy
WV4A/CYi1Z2Rvhq060KPqymiZD6XpaUm+h5GnvijGpT0WlaS7a08bXwXjHVby7LZ
2Zqon7hEwhlY2DssEQNtXBmx05Ey47UtLmc/dq/1BTe5BBCBacq5lMlbhC4LNiPE
bXM1p51m8m+68WGg12shZBQXO7dHOzHjK0/BNZ0NbkCAOIYIM02zgMZncemdYOW1
Co+vyF/RWxTX3mCyrIfHBqti4N44huGA6U9Sk6DUDQoMJPdzI04OaJD2vUrQJgFK
/XgAPSRl36N+bHcHhRcNrXsSuLHPUp+tcocbMRbZbYQiixM53AgU0OpOS6h7T9Z9
HEsHMaza7p/b2FwPFqbe0TZCgh2uIi7fyUshw7ZmQ7Ju2K/9IcY=
=RZZS
-----END PGP SIGNATURE-----

--VpRFFy90J6DTn7yH--
