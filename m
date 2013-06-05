From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch/*/asm/include/bitops.h: api issue, find_*_bit()
 defination are different with each other
Date: Wed, 05 Jun 2013 19:34:50 +0800
Message-ID: <51AF225A.5020703@asianux.com>
References: <51AE8FEF.1020809@asianux.com> <51AE903C.6010806@asianux.com> <51AE909D.9080006@asianux.com> <20130605071915.GK23140@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:22511 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab3FELfs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jun 2013 07:35:48 -0400
In-Reply-To: <20130605071915.GK23140@pengutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 06/05/2013 03:19 PM, Uwe =EF=BF=BD wrote:
> Hello,
>=20
> On Wed, Jun 05, 2013 at 09:13:01AM +0800, Chen Gang wrote:
>>
>> For arm and m68k, they customize find_*_bit(), but the API is differ=
ent
>> with 'generic'.
>>
>> avr32, s390, and unicore32 also customize find_*_bit(), but the API =
is
>> the same with 'generic', and the left architectures all use 'generic=
'.
>>
>> So need change arm and m68k related API to match the 'generic', then
>> all another modules can face same public API for various architectur=
es.
>>
>> Also beautify code and comments to pass "./scripts/checkpatch.pl"
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/include/asm/bitops.h  |   26 ++++++++++++++++++--------
>>  arch/arm/lib/findbit.S         |   14 ++++++++++----
>>  arch/m68k/include/asm/bitops.h |   25 ++++++++++++++-----------
>>  3 files changed, 42 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bi=
tops.h
>> index e691ec9..10566c8 100644
>> --- a/arch/arm/include/asm/bitops.h
>> +++ b/arch/arm/include/asm/bitops.h
>> @@ -161,18 +161,28 @@ extern int _test_and_change_bit(int nr, volati=
le unsigned long * p);
>>  /*
>>   * Little endian assembly bitops.  nr =3D 0 -> byte 0 bit 0.
>>   */
>> -extern int _find_first_zero_bit_le(const void * p, unsigned size);
>> -extern int _find_next_zero_bit_le(const void * p, int size, int off=
set);
>> -extern int _find_first_bit_le(const unsigned long *p, unsigned size=
);
>> -extern int _find_next_bit_le(const unsigned long *p, int size, int =
offset);
>> +extern unsigned long  _find_first_zero_bit_le(const void *p,
> doesn't checkpatch critizise the double space in the line above?
>=20

Thank you very much for your carefully checking (could you tell me how
do you find it ?)  :-)

I need wait for a day at least, if no another suggestions or
completions, I should send patch v3.


>> +						unsigned long size);
>> +extern unsigned long _find_next_zero_bit_le(const void *p, unsigned=
 long size,
>> +						unsigned long offset);
>> +extern unsigned long _find_first_bit_le(const unsigned long *p,
>> +						unsigned long size);
>> +extern unsigned long _find_next_bit_le(const unsigned long *p,
>> +						unsigned long size,
>> +						unsigned long offset);
>> =20
>>  /*
>>   * Big endian assembly bitops.  nr =3D 0 -> byte 3 bit 0.
>>   */
>> -extern int _find_first_zero_bit_be(const void * p, unsigned size);
>> -extern int _find_next_zero_bit_be(const void * p, int size, int off=
set);
>> -extern int _find_first_bit_be(const unsigned long *p, unsigned size=
);
>> -extern int _find_next_bit_be(const unsigned long *p, int size, int =
offset);
>> +extern unsigned long _find_first_zero_bit_be(const void *p,
>> +						unsigned long size);
>> +extern unsigned long _find_next_zero_bit_be(const void *p, unsigned=
 long size,
>> +						unsigned long offset);
>> +extern unsigned long _find_first_bit_be(const unsigned long *p,
>> +						unsigned long size);
>> +extern unsigned long _find_next_bit_be(const unsigned long *p,
>> +						unsigned long size,
>> +						unsigned long offset);
>> =20
>>  #ifndef CONFIG_SMP
>>  /*
>> diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
>> index 64f6bc1..9e3263a 100644
>> --- a/arch/arm/lib/findbit.S
>> +++ b/arch/arm/lib/findbit.S
>> @@ -19,7 +19,8 @@
>> =20
>>  /*
>>   * Purpose  : Find a 'zero' bit
>> - * Prototype: int find_first_zero_bit(void *addr, unsigned int maxb=
it);
>> + * Prototype: unsigned long  find_first_zero_bit(const void *p,
> here is another one.
>=20

Thanks.


--=20
Chen Gang

Asianux Corporation
