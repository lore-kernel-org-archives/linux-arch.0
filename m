From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH 0/6] make memtest a generic kernel feature
Date: Tue, 17 Mar 2015 17:20:31 +0000
Message-ID: <5508625F.6060600@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com> <20150317171822.GW8399@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150317171822.GW8399@arm.com>
Sender: owner-linux-mm@kvack.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "baruch@tkos.co.il" <baruch@tkos.co.il>, "rdunlap@infradead.org" <rdunlap@infradead.org>
List-Id: linux-arch.vger.kernel.org

On 17/03/15 17:18, Will Deacon wrote:
> On Mon, Mar 09, 2015 at 10:27:04AM +0000, Vladimir Murzin wrote:
>> Memtest is a simple feature which fills the memory with a given set of
>> patterns and validates memory contents, if bad memory regions is detecte=
d it
>> reserves them via memblock API. Since memblock API is widely used by oth=
er
>> architectures this feature can be enabled outside of x86 world.
>>
>> This patch set promotes memtest to live under generic mm umbrella and en=
ables
>> memtest feature for arm/arm64.
>>
>> It was reported that this patch set was useful for tracking down an issu=
e with
>> some errant DMA on an arm64 platform.
>>
>> Since it touches x86 and mm bits it'd be great to get ACK/NAK for these =
bits.
>=20
> Is your intention for akpm to merge this? I don't mind how it goes upstre=
am,
> but that seems like a sensible route to me.
>=20

It is already in -mm tree.

Vladimir

> Will
>=20
>> Changelog:
>>
>>     RFC -> v1
>>         - updated kernel-parameters.txt for memtest entry
>>         - updated number of test patterns in Kconfig menu
>>         - added Acked/Tested tags for arm64 bits
>>         - rebased on v4.0-rc3
>>
>> Vladimir Murzin (6):
>>   mm: move memtest under /mm
>>   memtest: use phys_addr_t for physical addresses
>>   arm64: add support for memtest
>>   arm: add support for memtest
>>   Kconfig: memtest: update number of test patterns up to 17
>>   Documentation: update arch list in the 'memtest' entry
>>
>>  Documentation/kernel-parameters.txt |    2 +-
>>  arch/arm/mm/init.c                  |    3 +
>>  arch/arm64/mm/init.c                |    2 +
>>  arch/x86/Kconfig                    |   11 ----
>>  arch/x86/include/asm/e820.h         |    8 ---
>>  arch/x86/mm/Makefile                |    2 -
>>  arch/x86/mm/memtest.c               |  118 ----------------------------=
-------
>>  include/linux/memblock.h            |    8 +++
>>  lib/Kconfig.debug                   |   11 ++++
>>  mm/Makefile                         |    1 +
>>  mm/memtest.c                        |  118 ++++++++++++++++++++++++++++=
+++++++
>>  11 files changed, 144 insertions(+), 140 deletions(-)
>>  delete mode 100644 arch/x86/mm/memtest.c
>>  create mode 100644 mm/memtest.c
>>
>> --=20
>> 1.7.9.5
>>
>=20
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
>=20
>=20
>=20


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
