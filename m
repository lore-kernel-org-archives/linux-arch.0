From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
Date: Mon, 14 Jan 2019 10:21:22 +0100
Message-ID: <a734e605-3e1e-1e14-de6f-cb59cbb17291@monstr.eu>
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
 <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
 <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
 <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f
Content-Type: multipart/mixed; boundary="pggHkskJhx44hcO1obsKlFZfDZW0lcmKP";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <a734e605-3e1e-1e14-de6f-cb59cbb17291@monstr.eu>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
 <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
 <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
 <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
In-Reply-To: <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>

--pggHkskJhx44hcO1obsKlFZfDZW0lcmKP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14. 01. 19 9:03, Firoz Khan wrote:
> Hi Michal,
>=20
> On Thu, 3 Jan 2019 at 18:39, Firoz Khan <firoz.khan@linaro.org> wrote:
>>> Looks good. Will keep this in my queue till depending patch is applie=
d.
>>
>> Thanks for the feedback. As Geert shared few feedback while m68k revie=
w,
>> Hopefully, I may have to include those changes here also.
>=20
> FYI, I'm going to abandon this patch series (for other 9 architecture
> also) and planning to come up with asm-generic support along with\
> this one. That can be single patch series and everything can be landed
> in upstream in the same time.

ok. Thanks for letting me know.
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--pggHkskJhx44hcO1obsKlFZfDZW0lcmKP--

--sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlw8VJIACgkQykllyylKDCGg4gCfb383L1CrtKZdwuQOWEBWKqGg
oDUAn3hHnqiRNbPS9LNxDL7VkHMTttjF
=cAJS
-----END PGP SIGNATURE-----

--sfwDWT7OSH4wy7qjfPu0BCkBuHRAYje9f--
