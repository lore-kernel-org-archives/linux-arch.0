From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Date: Tue, 25 Sep 2018 14:13:30 +0200
Message-ID: <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs
Content-Type: multipart/mixed; boundary="srBuUoupMQxGmtk16jvc3cOaIRwQCeh4h";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
In-Reply-To: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>

--srBuUoupMQxGmtk16jvc3cOaIRwQCeh4h
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



Am 25.09.2018 um 14:06 schrieb Arnd Bergmann:
> On Tue, Sep 25, 2018 at 1:35 PM Alexander Lochmann
> <alexander.lochmann@tu-dortmund.de> wrote:
>>
>> Hi Arnd,
>>
>> I recently tried to disable the BUG macros on x86-32. I disabled the
>> config item in 'General Setup -> Configure standard kernel features
>> (expert users) -> BUG() support'.
>> However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
>> include/asm-generic/bug.h (line 181) the code checks for the existence=

>> of architecture-specific variants of those macros.
>> Since x86 defines its own version of BUG(), line 182 is *not* used.
>> In the following, the x86 variant of BUG() is then used to define the
>> BUG_ON() macro.
>>
>> I propose a patch that really disables both macros if the developer
>> wants it.
>> It undefines the respective x86 variants, and defines both macros as
>> 'empty' macros.
>=20
> Maybe we should update the documentation instead. Note that the
> generic version is using 'while (1)' rather than 'while (0)', so this i=
s
> not an empty macro but rather one that does more than the
> arch-specific one-instruction version does.
>=20
> We don't really want an empty macro any more, this was used in
> the past, but causes compile-time warnings and undefined behavior
> for no good reason
I see. So the documentation of the CONFIG_BUG option is wrong?
It currently states that 'Disabling this option eliminates support for
BUG and WARN'.
Is the current implemention (an endless loop) desired behavior?

- Alex
>=20
>        Arnd
>=20

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--srBuUoupMQxGmtk16jvc3cOaIRwQCeh4h--

--plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAluqJmoACgkQWT7tBbw+
9v2uLQ//anJDuopN0CqNXjQyuQiVulhUqsDL0zdhMcmJ95dXNkqPiT8gj+tGGbXN
FEqTogl2ixf93cB/f8kprk1E/mB/OBhKr2BU130qVRPS7Vm/JJ+UBTiVFkg2etqT
Ua1lyqBRHXOo93+/t0DWxH1/P4DoDlkblz8/oPO3GKaE9OlXdrU07gCmjlcI4sNN
zFHNMkzNBOHWLDa2HaPRg7rBG+zcELBPDp7Z0Uap8cIKcrARC3QdKGQ5+pnGz64C
4FkHITb2cH2P3O7oo1FgB5iDAv6S/ca6WiDRAZNpLTbzxA9sHtHSocJll4w2T8bN
kMqLUbsg8k5Cf7zh0gVveS2xT7GLW6UmkvCctYS2DjSIiCRAg76OZAwVLpmrDD0E
IX+l4WYs/PHg29aH61LpmNeRwDRxWFehPKrUAjNIUCv/MuFF01rELQTJ+GAQtJzP
WHNGnEC0nN9VokCNjp3LxiGpUvkRRr8nyko/WgPdujAt8n8R5QjmBPTL+nG7XvAV
UEFA/khdyW1piLmgb8LM/Q51c2CGLec9GfRzqx8L9Uv2tdX80bR2vtJf7ebA6UzI
0DTc/2wSen5uVmo5BtRm96QOvlsV+wbF5ziouL0S7GjIAI/4/pEsl1vtscdc2+Rw
a+Ji6s7T6HfMoE0bGb3L0NWgGsdfv+VKoeZyZEYCGX2syGjlIvI=
=KN5L
-----END PGP SIGNATURE-----

--plRjT5M0KG0HWIQBCIifdXzlmUphX7rxs--
