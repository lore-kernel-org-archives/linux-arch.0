From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARC: add negative dependency for VGA_CONSOLE
Date: Wed, 26 Aug 2015 14:34:00 +0300
Message-ID: <55DDA428.1020509@ti.com>
References: <1439826777-11489-1-git-send-email-yuriy.kolerov@synopsys.com> <CAMuHMdW0hzGN74pCRhCUwJ0Ua3YN94csFfu3Mb-STeCuLosoGw@mail.gmail.com> <C2D7FE5348E1B147BCA15975FBA23075CFB85748@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pO597gJbjtr5TQ2tXf98PMkVqR3SUouhL"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075CFB85748@IN01WEMBXB.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "Anton.Kolesov@synopsys.com" <Anton.Kolesov@synopsys.com>, Francois Bedard <Francois.Bedard@synopsys.com>
List-Id: linux-arch.vger.kernel.org

--pO597gJbjtr5TQ2tXf98PMkVqR3SUouhL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/08/15 10:47, Vineet Gupta wrote:
> On Monday 17 August 2015 09:51 PM, Geert Uytterhoeven wrote:
>> On Mon, Aug 17, 2015 at 5:52 PM, Yuriy Kolerov
>> <yuriy.kolerov@synopsys.com> wrote:
>>> Architectures which support VGA console must define screen_info
>>> structurture from "uapi/linux/screen_info.h". Otherwise undefined
>>> symbol error occurs. Usually it's defined in "setup.c" for each
>>> architecture.
>>>
>>> If an architecture does not support VGA console (ARC's case)
>>> there are 2 ways: define a dummy instance of screen_info or add
>>> a negative dependency for VGA_CONSOLE in to prevent selecting
>>> this option.
>>>
>>> I've implemented the second way. However the best solution is to
>>> add HAVE_VGA_CONSOLE option for targets which support VGA
>>> console. Then turn off VGA_CONSOLE by default and add dependency
>>> to HAVE_VGA_CONSOLE. But right now it's better to just add a
>>> negative dependency for ARC and then consider how to collaborate
>>> about this issue with maintainers of other architectures.
>> +1
>>
>>> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Hi Tomi,
>=20
> Is anything else needed for this to be merged.

This is already in linux-next, merged by Andrew Morton.

 Tomi


--pO597gJbjtr5TQ2tXf98PMkVqR3SUouhL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3aQoAAoJEPo9qoy8lh71ekgQAII7Jofzf90mgYWLxyiGcCxL
rzkurPMzuF9gfLiqkGCgPhUlnl0aEpqW85NNsX+zls3aU5eqg94okcPCFeaXtmg2
RTdqO16NJWyynVYoRzH3zWiH/aKG2MBc0NGaIE9zd8uowxxNnNB5KBKKiytndcUz
SvYx/zpV+JDKOb4RoC/475UAflkn8Geetj/414YuZWU9HOitsrmHFUaefzoTHFnS
nVWeupR8j//2MPWKBm8uIQprYDaNxMnjwlxcZa1MDjhxde0DTq4IV3MsYT0Qn/UI
xImImOtlR5Qx2Jdf165vUx6xkmYHE/7ZvywBd2skgI+WZ4fj2qY/Z6fQF9FfbWF0
iUb8hd4ZWx0y+7d7Hvl/YvPZ9uDo+TXgePQwcK7Q/bU+0BSMvpLbomzrbIAjGjCE
6Um6o4mkwzWl6Zql8iQP5GDN+PSzAggpf9gGZ2JaURPzApnIzqPURZzk33ABVnhu
FAeTUTHKDl3i3PhreGwm0EKtj1XAuPkHXMDQhD6Tw/8ZmGNMWVTAy9ndPLRDRl/p
NJt0F+9d/gFlbwJW1ISkPlfphcTADC6/IR8pKWGl/utYPJ2tpJh5wkip53B16S1G
1m8QnR3MHOPYL56D2lS9NJqFbMAWWLrLLVJ6IF1i8YvtwbNgwwtbvqCXVpeZD7cg
Pbm3tytZABcDblQ417hA
=JDdC
-----END PGP SIGNATURE-----

--pO597gJbjtr5TQ2tXf98PMkVqR3SUouhL--
