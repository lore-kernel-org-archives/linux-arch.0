From: =?gbk?B?WHVldGFvIEd1YW4g?= <gxt@pku.edu.cn>
Subject: =?gbk?B?UmU6IFtQQVRDSF0gdW5pY29yZTMyOiBSZW1vdmUgdW5uZWVkZWQgS2NvbmZpZyBlbnRyeSBOT19JT1BPUlRfTUFQ?=
Date: Sun, 28 Sep 2014 09:49:29 +0800 (CST)
Message-ID: <1373895763.5110.1411868969556.JavaMail.root@bj-mail03.pku.edu.cn>
References: <1411586033.19525.34.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411586033.19525.34.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Sorry for late reply.

I checked this config, and it's only used for HAS_IOPORT_MAP in lib/Kco=
nfig
Sure, removing it means no different for .config file.
I think a better way is reserving it or moving it into arch/Kconfig

Cc: linux-arch@vger.kernel.org

Xuetao Guan

----- Paul Bolle <pebolle@tiscali.nl> =E5=86=99=E9=81=93=EF=BC=9A
> Architectures only need a Kconfig entry for NO_IOPORT_MAP if it is
> possible that its value will be 'y'. For unicore32 its value will alw=
ays
> be 'n', making it pointless. Remove it.
>=20
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Tested by playing with arch/unicore32/configs/unicore32_defconfig. Th=
is
> patch made no difference whatsoever to the generated .config file.
> Please note that it has
>     CONFIG_HAS_IOPORT_MAP=3Dy
>=20
> set after invoking "make oldconfig" both before and after this patch.
>=20
>  arch/unicore32/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index 928237a7b9ca..2322cc87e7cb 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -27,9 +27,6 @@ config UNICORE32
>  config GENERIC_CSUM
>  	def_bool y
> =20
> -config NO_IOPORT_MAP
> -	bool
> -
>  config STACKTRACE_SUPPORT
>  	def_bool y
> =20
> --=20
> 1.9.3
>=20
