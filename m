Return-Path: <SRS0=kSGY=5J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgCXIj3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 04:39:29 -0400
Subject: Re: [RESEND PATCH v2 6/9] drm/mgag200: Constify ioreadX() iomem
 argument (as in generic implementation)
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-7-krzk@kernel.org>
 <90baef2d-25fe-fac4-6a7e-b103b4b6721e@suse.de>
 <20200314105944.GA16044@kozik-lap>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <b19bd919-3af5-855f-65a7-fa6f16b07b31@suse.de>
Date: Tue, 24 Mar 2020 09:39:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200314105944.GA16044@kozik-lap>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5JHKoPMDjFIljnahlEBkrPhFBMFaUgU8x"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org
Message-ID: <20200324083918.j-Z1umDidw_i_Hk-AcM5S_9ChrEyQHAby4xF64onRPk@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5JHKoPMDjFIljnahlEBkrPhFBMFaUgU8x
Content-Type: multipart/mixed; boundary="hhPGeJseFbtGrgGh6f1kgq7y0jySVSvgE";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby
 <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
 "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org,
 linux-arch@vger.kernel.org
Message-ID: <b19bd919-3af5-855f-65a7-fa6f16b07b31@suse.de>
Subject: Re: [RESEND PATCH v2 6/9] drm/mgag200: Constify ioreadX() iomem
 argument (as in generic implementation)
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-7-krzk@kernel.org>
 <90baef2d-25fe-fac4-6a7e-b103b4b6721e@suse.de>
 <20200314105944.GA16044@kozik-lap>
In-Reply-To: <20200314105944.GA16044@kozik-lap>

--hhPGeJseFbtGrgGh6f1kgq7y0jySVSvgE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 14.03.20 um 11:59 schrieb Krzysztof Kozlowski:
> On Thu, Mar 12, 2020 at 11:49:05AM +0100, Thomas Zimmermann wrote:
>> Hi Krzysztof,
>>
>> I just received a resend email from 3 weeks ago :/
>>
>> Do you want me to merge the mgag200 patch into drm-misc-next?
>=20
> Thanks but it depends on the first patch in the series so either it
> could go with your ack through other tree or I will send it later (once=

> 1st patch gets to mainline).

Ok. You're welcome to send it through any tree that works best for you.
mgag200 sees only little change. I wouldn't expect major merge
conflicts, if any.

Best regards
Thomas

>=20
>=20
> Best regards,
> Krzysztof
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--hhPGeJseFbtGrgGh6f1kgq7y0jySVSvgE--

--5JHKoPMDjFIljnahlEBkrPhFBMFaUgU8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl55xzYACgkQaA3BHVML
eiNG1wgAnt3qyju9VoZCaXPbgeTj4gxLN24UZYPowzBMiEUgsJRz8b2iRuEoEKGb
X+o80inBpVTWe/a+HI6wAQWEwidrIXUquQe1fSSpn2+h69aSApCBWBuxTuKZOLWq
z9ZpyDKo+VD0/zWGgOZttJXPQJYEfckuCoLN9qcVf+CmgXQNC0m6ZVg6kf59xrca
KEMDM4x2XhouIaoAtLYLQpt3U9YKgTphMMisTdha7xJt4h7CVx1uztnUyD2triFq
meU3vxWwePFuQF/1reT0Vr5FU18Z88+wOLZyu3oa+GMA5lp/DKlJJmTGH+VsQA9l
T/IiW9kxcWlBxT0ylEqlmHr82hqCAQ==
=iz+q
-----END PGP SIGNATURE-----

--5JHKoPMDjFIljnahlEBkrPhFBMFaUgU8x--
