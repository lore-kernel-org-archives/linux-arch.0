From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: tile: include: asm: add cmpxchg64() definition
Date: Thu, 18 Jul 2013 08:02:04 +0800
Message-ID: <51E7307C.50505@asianux.com>
References: <51CA6D21.3090901@asianux.com> <51CC492C.1040105@tilera.com> <51CCD891.8000806@asianux.com> <51CCEC27.8050508@asianux.com> <20130628150941.GA22767@linux-mips.org> <51D0E4B3.6080402@asianux.com> <51D0E7BF.9030206@asianux.com> <51E6CA5B.6030501@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:21455 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab3GRADI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2013 20:03:08 -0400
In-Reply-To: <51E6CA5B.6030501@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@logfs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>

On 07/18/2013 12:46 AM, Chris Metcalf wrote:
> On 6/30/2013 10:21 PM, Chen Gang wrote:
>> Need add cmpxchg64(), or will cause compiling issue.
>>
>> Need define it as cmpxchg() only for 64-bit operation, since cmpxchg=
()
>> can support 8 bytes.
>>
>> The related error (with allmodconfig):
>>
>>   drivers/block/blockconsole.c: In function =E2=80=98bcon_advance_co=
nsole_bytes=E2=80=99:
>>   drivers/block/blockconsole.c:164:2: error: implicit declaration of=
 function =E2=80=98cmpxchg64=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>=20
> Thanks, taken into the tile tree.
>=20

Thank you too.

:-)

--=20
Chen Gang
