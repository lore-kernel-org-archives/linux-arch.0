From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: tile: include: asm: add cmpxchg64() definition
Date: Mon, 01 Jul 2013 10:08:51 +0800
Message-ID: <51D0E4B3.6080402@asianux.com>
References: <51CA6D21.3090901@asianux.com> <51CC492C.1040105@tilera.com> <51CCD891.8000806@asianux.com> <51CCEC27.8050508@asianux.com> <20130628150941.GA22767@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130628150941.GA22767@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: =?UTF-8?B?SsO2cm4gRW5nZWw=?= <joern@logfs.org>, Chris Metcalf <cmetcalf@tilera.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-arch.vger.kernel.org


=46irstly thank you very much for replying quickly with details.

On 06/28/2013 11:09 PM, Ralf Baechle wrote:
> On Fri, Jun 28, 2013 at 09:51:35AM +0800, Chen Gang wrote:
>=20
>> Need add cmpxchg64(), or will cause compiling issue.
>>
>> Just define it as cmpxchg(), since cmpxchg() can support 8 bytes.
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
>> ---
>>  arch/tile/include/asm/cmpxchg.h |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/tile/include/asm/cmpxchg.h b/arch/tile/include/asm=
/cmpxchg.h
>> index 276f067..7688c28 100644
>> --- a/arch/tile/include/asm/cmpxchg.h
>> +++ b/arch/tile/include/asm/cmpxchg.h
>> @@ -68,6 +68,8 @@ extern unsigned long __cmpxchg_called_with_bad_poi=
nter(void);
>> =20
>>  #define tas(ptr) (xchg((ptr), 1))
>> =20
>> +#define cmpxchg64(ptr, o, n)		cmpxchg((ptr), (o), (n))
>=20
> that's broken.  cmpxchg64 is suposed to work on 64 bit operands ONLY.=
  This
> definition (used by MIPS and Alpha) will work properly:
>=20

Oh, really it is. thanks.

> #define cmpxchg64(ptr, o, n)                                         =
   \
> ({                                                                   =
   \
> 	BUILD_BUG_ON(sizeof(*(ptr)) !=3D 8);                              \
> 	cmpxchg((ptr), (o), (n));                                       \
> })
>=20

I should follow it to send patch v2, thanks.

> This should cure blockconsole on Tile but not on MIPS.
>=20
> struct blockconsole {
> ..
>            u64 console_bytes;
> ..
> };
>=20
> static void bcon_advance_console_bytes(struct blockconsole *bc, int b=
ytes)
> {
> 	u64 old, new;
> 	...
> 	} while (cmpxchg64(&bc->console_bytes, old, new) !=3D old);
> }
>=20
> So it's using cmpxchg64() to operate on 64 bit objects - but that's n=
ot
> going to work on every architecture.  Many 32 bit architectures only
> provide atomic operations that operate on 32 bit quantities.
>=20

I guess your meaning is:

  cmpxchg64() should be an atomic operation.
  but on some of 32-bit architectures, they don't implement it as atomi=
c
    (no lock protected, at least).
  it may cause issue on these 32-bit architectures.

Is it correct ?

If it is correct, I should continue to try to fix it.


Thanks.
--=20
Chen Gang
