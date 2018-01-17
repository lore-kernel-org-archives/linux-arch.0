From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/2] microblaze: fix endian handling
Date: Wed, 17 Jan 2018 13:57:51 +0100
Message-ID: <ffc7b253-bc9e-c098-fe02-707709d5acfe@monstr.eu>
References: <20180102114720.3408356-1-arnd@arndb.de>
 <201801140858.DQC0KW38%fengguang.wu@intel.com>
 <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com>
 <ed24b2c4-c5d0-057c-49c3-57f50c5946b4@monstr.eu>
 <CAK8P3a1zr_9Oy-neCndUgFd1q0pyT07VKbJe2ezw3x6psfut3A@mail.gmail.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="c7sZuhtBot5q01YeubbfUlm6aECVm88ny"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1zr_9Oy-neCndUgFd1q0pyT07VKbJe2ezw3x6psfut3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Babu Moger <babu.moger@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c7sZuhtBot5q01YeubbfUlm6aECVm88ny
Content-Type: multipart/mixed; boundary="YaTN1kN57NviEAqoV3UbPbsJrFj0wVWbF";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>, Babu Moger <babu.moger@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <ffc7b253-bc9e-c098-fe02-707709d5acfe@monstr.eu>
Subject: Re: [PATCH 1/2] microblaze: fix endian handling
References: <20180102114720.3408356-1-arnd@arndb.de>
 <201801140858.DQC0KW38%fengguang.wu@intel.com>
 <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com>
 <ed24b2c4-c5d0-057c-49c3-57f50c5946b4@monstr.eu>
 <CAK8P3a1zr_9Oy-neCndUgFd1q0pyT07VKbJe2ezw3x6psfut3A@mail.gmail.com>
In-Reply-To: <CAK8P3a1zr_9Oy-neCndUgFd1q0pyT07VKbJe2ezw3x6psfut3A@mail.gmail.com>

--YaTN1kN57NviEAqoV3UbPbsJrFj0wVWbF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.1.2018 11:19, Arnd Bergmann wrote:
> On Mon, Jan 15, 2018 at 11:14 AM, Michal Simek <monstr@monstr.eu> wrote=
:
>> On 15.1.2018 10:29, Arnd Bergmann wrote:
>>> On Sun, Jan 14, 2018 at 2:01 AM, kbuild test robot <lkp@intel.com> wr=
ote:
>>>> Hi Arnd,
>>>>
>>>> I love your patch! Yet something to improve:
>>>>
>>>> [auto build test ERROR on linus/master]
>>>> [also build test ERROR on v4.15-rc7 next-20180112]
>>>> [if your patch is applied to the wrong git tree, please drop us a no=
te to help improve the system]
>>>>
>>>> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/micro=
blaze-fix-endian-handling/20180105-120705
>>>> config: microblaze-mmu_defconfig (attached as .config)
>>>> compiler: microblaze-linux-gcc (GCC) 7.2.0
>>>> reproduce:
>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/maste=
r/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         # save the attached .config to linux build tree
>>>>         make.cross ARCH=3Dmicroblaze
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> arch/microblaze/lib/fastcopy.S:33:2: error: #error Microblaze LE n=
ot support ASM optimized lib func. Disable OPT_LIB_ASM.
>>>>     #error Microblaze LE not support ASM optimized lib func. Disable=
 OPT_LIB_ASM.
>>>>      ^~~~~
>>>>
>>>> vim +33 arch/microblaze/lib/fastcopy.S
>>>>
>>>
>>> This seems to be a result of fixing one bug so we run into one that w=
e didn't
>>> get to earlier. I still assume my patch is correct.
>>
>> I will look at this later this week. Xilinx toolchain which I use
>> normally are microblaze for BE or microblazeel that's why proper flags=

>> are default options already that's why I didn't see any issue.
>>
>> Did you take toolchain from kernel.org?
>> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/
>=20
> I used a gcc-7.2.1 that I built myself for all architectures in order t=
o debug
> a gcc issue that appeared in gcc-7.2.
>=20
> The patch that got tested was my workaround for an obviously broken
> allmodconfig build.

ok.

Applied both.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--YaTN1kN57NviEAqoV3UbPbsJrFj0wVWbF--

--c7sZuhtBot5q01YeubbfUlm6aECVm88ny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlpfSFMACgkQykllyylKDCHKSgCggAha5MH8wqSHcYXcuH+aqQOA
Rz4AnjBrl+mVVxTrKj4JujYrVINAH7sm
=B+Qg
-----END PGP SIGNATURE-----

--c7sZuhtBot5q01YeubbfUlm6aECVm88ny--
