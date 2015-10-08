From: yalin wang <yalin.wang2010@gmail.com>
Subject: Re: [PATCH V4 2/3] arm64: support initrd outside kernel linear map
Date: Thu, 8 Oct 2015 17:18:14 +0800
Message-ID: <FC378C09-F140-4A62-9FFA-09293E65E866@gmail.com>
References: <1439830867-14935-1-git-send-email-msalter@redhat.com> <1439830867-14935-3-git-send-email-msalter@redhat.com> <20150908113113.GA20562@leverpostej> <20151006171140.GE26433@leverpostej> <1444151812.10788.14.camel@redhat.com> <20151008084953.GA20114@cbox>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20151008084953.GA20114@cbox>
Sender: owner-linux-mm@kvack.org
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Mark Salter <msalter@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org


> On Oct 8, 2015, at 16:49, Christoffer Dall =
<christoffer.dall@linaro.org> wrote:
>=20
> On Tue, Oct 06, 2015 at 01:16:52PM -0400, Mark Salter wrote:
>> On Tue, 2015-10-06 at 18:11 +0100, Mark Rutland wrote:
>>> On Tue, Sep 08, 2015 at 12:31:13PM +0100, Mark Rutland wrote:
>>>> Hi Mark,
>>>>=20
>>>> On Mon, Aug 17, 2015 at 06:01:06PM +0100, Mark Salter wrote:
>>>>> The use of mem=3D could leave part or all of the initrd outside of
>>>>> the kernel linear map. This will lead to an error when unpacking
>>>>> the initrd and a probable failure to boot. This patch catches that
>>>>> situation and relocates the initrd to be fully within the linear
>>>>> map.
>>>>=20
>>>> With next-20150908, this patch results in a confusing message at =
boot when not
>>>> using an initrd:
>>>>=20
>>>> Moving initrd from [4080000000-407fffffff] to [9fff49000-9fff48fff]
>>>>=20
>>>> I think that can be solved by folding in the diff below.
>>>=20
>>> Mark, it looks like this fell by the wayside.
>>>=20
>>> Do you have any objection to this? I'll promote this to it's own =
patch
>>> if not.
>>>=20
>>> Mark.
>>>=20
>>>>=20
>>>> Thanks,
>>>> Mark.
>>>>=20
>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>> index 6bab21f..2322479 100644
>>>> --- a/arch/arm64/kernel/setup.c
>>>> +++ b/arch/arm64/kernel/setup.c
>>>> @@ -364,6 +364,8 @@ static void __init relocate_initrd(void)
>>>>                to_free =3D ram_end - orig_start;
>>>>=20
>>>>        size =3D orig_end - orig_start;
>>>> +       if (!size)
>>>> +               return;
>>>>=20
>>>>        /* initrd needs to be relocated completely inside linear =
mapping */
>>>>        new_start =3D memblock_find_in_range(0, PFN_PHYS(max_pfn),
>>=20
>> Sorry, no. That looks perfectly good to me.
>>=20
is it also possible to implement it on ARM platforms?
ARM64 platform don=E2=80=99t have HIGH_MEM zone .
but ARM platform have .
i remember boot loader must put init rd  into low memory region,
so if some boot loader put init rd into HIGH men zone
we can also relocate it to low men region ?
then boot loader don=E2=80=99t need care about this ,
and since vmalloc=3D boot option will change HIGH mem region size,
if we can relocate init rd , boot loader don=E2=80=99t need care about =
init rd load address,
when change vmalloc=3D boot options .


Thanks









--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
