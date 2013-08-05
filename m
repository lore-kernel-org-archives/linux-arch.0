From: Chen Gang F T <chen.gang.flying.transformer@gmail.com>
Subject: Re: [PATCH] arch: m68k: include: asm: define 'VM_DATA_DEFAULT_FLAGS'
 no matter whether has 'NOMMU' or not.
Date: Mon, 05 Aug 2013 10:21:14 +0800
Message-ID: <51FF0C1A.3020907@gmail.com>
References: <51C548E2.1060104@asianux.com> <51D0ECC2.3020101@asianux.com> <51FF01E7.5020105@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <51FF01E7.5020105@uclinux.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Greg Ungerer <gerg@uclinux.org>
Cc: Chen Gang <gang.chen@asianux.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "dhowells@redhat.com" <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, davej@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 08/05/2013 09:37 AM, Greg Ungerer wrote:
> Hi Chen Gang,
>=20
> On 01/07/13 12:43, Chen Gang wrote:
>> Hello Maintainers:
>>
>> Please help check the patch whether OK or not, when you have time.
>>
>> Thanks.
>>
>> On 06/22/2013 02:49 PM, Chen Gang wrote:
>>>
>>> Define 'VM_DATA_DEFAULT_FLAGS' when 'NOMMU' to pass compiling.
>>>
>>> So move it from "include/asm/page_mm.h to "include/asm/page.h"
>>>
>>> The related make:
>>>
>>>   make ARCH=3Dm68k randconfig
>>>   make ARCH=3Dm68k menuconfig
>>>     choose cross compiler
>>>     disable MMU support
>>>   make ARCH=3Dm68k V=3D1 EXTRA_CFLAGS=3D-W
>>>
>>> The related error:
>>>
>>>   security/selinux/hooks.c: In function =E2=80=98selinux_init=E2=80=
=99:
>>>   security/selinux/hooks.c:5821:21: error: =E2=80=98VM_DATA_DEFAULT=
_FLAGS=E2=80=99 undeclared (first use in this function)
>>>
>>> (the attachment is the related .config file)
>>>
>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>=20
> I am fine with this:
>=20
> Acked-by: Greg Ungerer <gerg@uclinux.org>
>=20

Thank you very much.

> Do you want me to add this to the m68knommu git tree, and push to
> Linus?
>=20

Yeah, thank you.

:-)

> Regards
> Greg
>=20
>=20
>>> ---
>>>  arch/m68k/include/asm/page.h    |    3 +++
>>>  arch/m68k/include/asm/page_mm.h |    3 ---
>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/p=
age.h
>>> index 7c360da..38b024a 100644
>>> --- a/arch/m68k/include/asm/page.h
>>> +++ b/arch/m68k/include/asm/page.h
>>> @@ -48,6 +48,9 @@ extern unsigned long _ramend;
>>>  #include <asm/page_no.h>
>>>  #endif
>>> =20
>>> +#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>>> +				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>>> +
>>>  #include <asm-generic/getorder.h>
>>> =20
>>>  #endif /* _M68K_PAGE_H */
>>> diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/as=
m/page_mm.h
>>> index 89f2014..5029f73 100644
>>> --- a/arch/m68k/include/asm/page_mm.h
>>> +++ b/arch/m68k/include/asm/page_mm.h
>>> @@ -173,7 +173,4 @@ static inline __attribute_const__ int __virt_to=
_node_shift(void)
>>> =20
>>>  #endif /* __ASSEMBLY__ */
>>> =20
>>> -#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
>>> -				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>>> -
>>>  #endif /* _M68K_PAGE_MM_H */
>>>
>>
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


--=20
Chen Gang
