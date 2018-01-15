From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH 1/2] microblaze: fix endian handling
Date: Mon, 15 Jan 2018 11:14:51 +0100
Message-ID: <ed24b2c4-c5d0-057c-49c3-57f50c5946b4@monstr.eu>
References: <20180102114720.3408356-1-arnd@arndb.de>
 <201801140858.DQC0KW38%fengguang.wu@intel.com>
 <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bKXyVH4U3hKTcIAPIP1oEwXUTAoNosVf2"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39127 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933588AbeAOKPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 05:15:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id i11so719492wmf.4
        for <linux-arch@vger.kernel.org>; Mon, 15 Jan 2018 02:15:02 -0800 (PST)
In-Reply-To: <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Babu Moger <babu.moger@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bKXyVH4U3hKTcIAPIP1oEwXUTAoNosVf2
Content-Type: multipart/mixed; boundary="CPo6w7s2BsT1xtqDW0Z0jFLCftdo0giFa";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arch <linux-arch@vger.kernel.org>, Babu Moger <babu.moger@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <ed24b2c4-c5d0-057c-49c3-57f50c5946b4@monstr.eu>
Subject: Re: [PATCH 1/2] microblaze: fix endian handling
References: <20180102114720.3408356-1-arnd@arndb.de>
 <201801140858.DQC0KW38%fengguang.wu@intel.com>
 <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com>
In-Reply-To: <CAK8P3a1X1Pw65gX7Pn+672yux26oMzWidmN7onX94uESY547Eg@mail.gmail.com>

--CPo6w7s2BsT1xtqDW0Z0jFLCftdo0giFa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.1.2018 10:29, Arnd Bergmann wrote:
> On Sun, Jan 14, 2018 at 2:01 AM, kbuild test robot <lkp@intel.com> wrot=
e:
>> Hi Arnd,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v4.15-rc7 next-20180112]
>> [if your patch is applied to the wrong git tree, please drop us a note=
 to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/microbl=
aze-fix-endian-handling/20180105-120705
>> config: microblaze-mmu_defconfig (attached as .config)
>> compiler: microblaze-linux-gcc (GCC) 7.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=3Dmicroblaze
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/microblaze/lib/fastcopy.S:33:2: error: #error Microblaze LE not=
 support ASM optimized lib func. Disable OPT_LIB_ASM.
>>     #error Microblaze LE not support ASM optimized lib func. Disable O=
PT_LIB_ASM.
>>      ^~~~~
>>
>> vim +33 arch/microblaze/lib/fastcopy.S
>>
>=20
> This seems to be a result of fixing one bug so we run into one that we =
didn't
> get to earlier. I still assume my patch is correct.

I will look at this later this week. Xilinx toolchain which I use
normally are microblaze for BE or microblazeel that's why proper flags
are default options already that's why I didn't see any issue.

Did you take toolchain from kernel.org?
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--CPo6w7s2BsT1xtqDW0Z0jFLCftdo0giFa--

--bKXyVH4U3hKTcIAPIP1oEwXUTAoNosVf2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlpcfx8ACgkQykllyylKDCHsjACeMjRXmexAFo5K9euK1C2aC2mR
BucAnRwozC4HzgA57LkunkqQLgNLLcOc
=Y6Lh
-----END PGP SIGNATURE-----

--bKXyVH4U3hKTcIAPIP1oEwXUTAoNosVf2--
