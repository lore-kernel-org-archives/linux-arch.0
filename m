From: Chen Gang <chengang@emindsoft.com.cn>
Subject: Re: [PATCH trivial] include: asm-generic: Notice about 80 columns
 in pgtable-no*.h
Date: Wed, 16 Dec 2015 05:57:03 +0800
Message-ID: <56708CAF.10007@emindsoft.com.cn>
References: <201512152302.Zy0UpM2T%fengguang.wu@intel.com> <8033721.mSphpqy3yk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out114-136.biz.mail.alibaba.com ([205.204.114.136]:48585 "EHLO
	out21.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753575AbbLOWAY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2015 17:00:24 -0500
In-Reply-To: <8033721.mSphpqy3yk@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, trivial@kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/15/15 23:50, Arnd Bergmann wrote:
> On Tuesday 15 December 2015 23:47:28 kbuild test robot wrote:
>>                     from include/linux/mm.h:55,
>>                     from arch/arm/mm/fault.c:13:
>>    arch/arm/mm/fault.c: In function 'do_translation_fault':
>>>> arch/arm/include/asm/pgtable-2level.h:187:27: error: expected expr=
ession before 'do'
>>     #define set_pud(pud,pudp) do { } while (0)
>>                               ^
>>    include/asm-generic/pgtable-nopud.h:36:36: note: in expansion of =
macro 'set_pud'
>>     #define set_pgd(pgdptr, pgdval)   (set_pud((pud_t *)(pgdptr), \
>>
>=20
> This is a result of the added braces, please redo the patch.
>=20

OK, thanks.

--=20
Chen Gang (=E9=99=88=E5=88=9A)

Open, share, and attitude like air, water, and life which God blessed
