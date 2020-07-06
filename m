Return-Path: <SRS0=B4xR=AR=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH v6 06/26] mm: Add PG_arch_2 page flag
References: <20200703153718.16973-1-catalin.marinas@arm.com>
 <20200703153718.16973-7-catalin.marinas@arm.com>
 <27fe044a-8315-5394-575e-8f763696b0cd@redhat.com>
 <20200706112057.GA6432@gaia>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2f77487a-e92e-1a38-ffd9-e5506441d25d@redhat.com>
Date: Mon, 6 Jul 2020 14:42:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200706112057.GA6432@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Price <steven.price@arm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200706124259.Q1_UyQ41_CRUxV5TX8inWeMXSkIclHxw_1foGuEonSk@z>

On 06.07.20 13:21, Catalin Marinas wrote:
> On Mon, Jul 06, 2020 at 10:24:04AM +0200, David Hildenbrand wrote:
>> On 03.07.20 17:36, Catalin Marinas wrote:
>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index 6be1aa559b1e..276140c94f4a 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -135,6 +135,9 @@ enum pageflags {
>>>  #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
>>>  	PG_young,
>>>  	PG_idle,
>>> +#endif
>>> +#ifdef CONFIG_64BIT
>>> +	PG_arch_2,
>>>  #endif
>>>  	__NR_PAGEFLAGS,
>>
>> People are usually *very* picky when it comes to new page flags. It
>> somewhat concerns me that we bump up __NR_PAGEFLAGS for any 64bit arch=
.
>> That feels wrong.
>=20
> It was guarded by a specific config option initially but the comments
> suggested that it could be dropped for 64-bit architectures:
>=20
> https://lore.kernel.org/linux-arm-kernel/20200624113307.6165b3db2404c9d=
37b870a90@linux-foundation.org/
>=20
> The page flags is indeed a pretty limited resource as it also includes
> the sparsemem section, node and zone fields. However, on 64-bit this
> should be fine (the sparsemem section is gone with vmemmap support).

Right, so 64bit architectures/configs with SPARSEMEM &&
!SPARSEMEM_VMEMMAP could be affected only. I think mips would be one
example where we don't have VMEMMAP support. For most other 64bit
architectures (x86_64, s390x, powerpc, ...) SPARSEMEM_VMEMMAP should be
the default (although I've seen bug reports/configs where VMEMMAP was
disabled).

--=20
Thanks,

David / dhildenb
