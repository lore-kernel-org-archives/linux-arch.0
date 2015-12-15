From: Chen Gang <chengang@emindsoft.com.cn>
Subject: Re: [PATCH trivial] include: asm-generic: Notice about 80 columns
 in pgtable-no*.h
Date: Wed, 16 Dec 2015 06:06:12 +0800
Message-ID: <56708ED4.30403@emindsoft.com.cn>
References: <56702088.9080605@emindsoft.com.cn> <1450211204.4142.30.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail113-251.mail.alibaba.com ([205.204.113.251]:32933 "EHLO
	us-alimail-mta2.hst.scl.en.alidc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752144AbbLOWEF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Dec 2015 17:04:05 -0500
In-Reply-To: <1450211204.4142.30.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>, trivial@kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


On 12/16/15 04:26, Joe Perches wrote:
> On Tue, 2015-12-15 at 22:15 +0800, Chen Gang wrote:
>> It is a trivial patch.
> []
>> diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-gener=
ic/pgtable-nopmd.h
> []
>> @@ -38,7 +38,8 @@ static inline void pud_clear(pud_t *pud)	{ }
>>   * (pmds are folded into puds so this doesn't get actually called,
>>   * but the define is needed for a generic inline function.)
>>   */
>> -#define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t=
) { pudval })
>> +#define set_pud(pudptr, pudval)			(set_pmd((pmd_t *)(pudptr), \
>> +							(pmd_t) { pudval }))
>=20
> Not quite so trivial.
>=20
> If you _really_ want to break this up for 80 columns,
> and I don't think it's necessary, it might be better
> to use something like:
>=20
> #define set_pud(pudptr, pudval)					\
> 	set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
>

OK, thanks. For me, it is better.=20

--=20
Chen Gang (=E9=99=88=E5=88=9A)

Open, share, and attitude like air, water, and life which God blessed
