From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 3/3] microblaze: generate uapi header and system call
 table files
Date: Thu, 8 Nov 2018 14:50:15 +0100
Message-ID: <fdbc804d-ecf7-4277-31f6-f45d05c2295a@monstr.eu>
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
 <1540530552-3652-4-git-send-email-firoz.khan@linaro.org>
 <a04a6d10-d6d7-3ead-3b1e-68d87e1ea931@monstr.eu>
 <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
 <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc: gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW
Content-Type: multipart/mixed; boundary="uDZve51gLKziK3cpsalbKpnaVvLnhVV32";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc: gregkh <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <fdbc804d-ecf7-4277-31f6-f45d05c2295a@monstr.eu>
Subject: Re: [PATCH v3 3/3] microblaze: generate uapi header and system call
 table files
References: <1540530552-3652-1-git-send-email-firoz.khan@linaro.org>
 <1540530552-3652-4-git-send-email-firoz.khan@linaro.org>
 <a04a6d10-d6d7-3ead-3b1e-68d87e1ea931@monstr.eu>
 <CALxhOnjWHVfVVi5aN5OAr4AN13NfktNVOarvnoAAWYgj9fYr6g@mail.gmail.com>
 <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>
In-Reply-To: <CAK8P3a2h1sdM62r6TjwWf9E-h9A4pUNR69XbbGbPSpPaub7DVg@mail.gmail.com>

--uDZve51gLKziK3cpsalbKpnaVvLnhVV32
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08. 11. 18 14:44, Arnd Bergmann wrote:
> On Mon, Nov 5, 2018 at 11:26 AM Firoz Khan <firoz.khan@linaro.org> wrot=
e:
>> On Mon, 5 Nov 2018 at 14:46, Michal Simek <monstr@monstr.eu> wrote:
>>> On 26. 10. 18 7:09, Firoz Khan wrote:
>=20
>>>> -     .long sys_rseq
>>>> +#include <asm/syscall_table.h>
>>>> +#undef __SYSCALL
>>>>
>>>
>>> I still don't think this is correct.
>>>
>>> I have done these steps
>>>
>>> make mrproper
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>> Applied 1/3
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>> Applied 2/3
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>> Applied 3/3
>>> make ARCH=3Dmicroblaze headers_install INSTALL_HDR_PATH=3D/tmp/ && mo=
ve
>>>
>>> And compare all these versions. Till 2/3 all is fine but when 3/3 is
>>> applied
>>>
>>> include/asm/unistd.h contains
>>> #include <asm/unistd_32.h>
>>>
>>> Then include/asm/unistd_32.h contains
>>> #include <asm-generic/unistd_32.h>
>>> which is different syscalls table.
>>>
>>> I didn't play with it for a long time but removing generic unistd_32.=
h
>>> is fixing it. Please take a look.
>>
>> Sure, I'll check and update you ASAP.
>>
>>>
>>> diff --git a/arch/microblaze/include/uapi/asm/Kbuild
>>> b/arch/microblaze/include/uapi/asm/Kbuild
>>> index cda864f4b62e..2c6a6bffea32 100644
>>> --- a/arch/microblaze/include/uapi/asm/Kbuild
>>> +++ b/arch/microblaze/include/uapi/asm/Kbuild
>>> @@ -28,4 +28,3 @@ generic-y +=3D termbits.h
>>>  generic-y +=3D termios.h
>>>  generic-y +=3D types.h
>>>  generic-y +=3D ucontext.h
>>> -generic-y +=3D unistd_32.h
>>
>> AFAIK, If I apply the above fix; the generated file - unistd_32.h will=

>> get removed.
>> No longer present in arch/microblaze/include/generated/uapi/asm.
>=20
> It certainly must be 'generated-y', not 'generic-y', since you are
> generating an architecture specific file, not taking the one
> from asm-generic. I think this was correct in an earlier version.

yep. It was correct in v1. It has changed in v2.

I have retested and it looks good with that.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--uDZve51gLKziK3cpsalbKpnaVvLnhVV32--

--tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlvkPxcACgkQykllyylKDCFdIgCcCsKaEPsvueRfy+fm0ZIPS/sk
JNwAni9w/jKcUrvC34RftpffS3unNnpf
=lgFx
-----END PGP SIGNATURE-----

--tRrjEZXu1k8fcGaS9MXYcwQYxLQlzNZzW--
