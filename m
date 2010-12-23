From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] of: Add support for linking device tree blobs into vmlinux
Date: Thu, 23 Dec 2010 07:14:20 +0100
Message-ID: <AANLkTik-yqs2Dy+MBAcQ5Gpb9Vcvd80BS=C=fuDe7z-A@mail.gmail.com>
References: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
	<1293047849-26078-2-git-send-email-dirk.brandewie@gmail.com>
	<4D127D72.8050303@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <4D127D72.8050303@suse.cz>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: dirk.brandewie@gmail.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

2010/12/22 Michal Marek <mmarek@suse.cz>:
> On 22.12.2010 20:57, dirk.brandewie@gmail.com wrote:
>>
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>
>> This patch adds support for linking device tree blob(s) into
>> vmlinux. Modifies asm-generic/vmlinux.lds.h to add linking
>> .dtb sections into vmlinux. To maintain compatiblity with the of/fdt
>> driver code platforms MUST copy the blob to a non-init memory locati=
on
>> before the kernel frees the .init.* sections in the image.
>>
>> Modifies scripts/Makefile.lib to add a kbuild command to
>> compile DTS files to device tree blobs and a rule to create objects =
to
>> wrap the blobs for linking.
>>
>> STRUCT_ALIGNMENT is defined in vmlinux.lds.h for use in the rule to
>> create wrapper objects for the dtb in Makefile.lib. =C2=A0The
>> STRUCT_ALIGN() macro in vmlinux.lds.h is modified to use the
>> STRUCT_ALIGNMENT definition.
>>
>> The DTB's are placed on 32 byte boundries to allow parsing the blob
>> with driver/of/fdt.c during early boot without having to copy the bl=
ob
>> to get the structure alignment GCC expects.
>>
>> A DTB is linked in by adding the DTB object to the list of objects t=
o
>> be linked into vmlinux in the archtecture specific Makefile using
>> =C2=A0 =C2=A0obj-y +=3D foo.dtb.o
>>
>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>
> Hi,
>
> you can add
> Acked-by: Michal Marek <mmarek@suse.cz>
> but I thing this series should go through the tip tree, as your prima=
ry
> target seems to be x86 and patch 2/4 depends on the ce4100 code that =
is only
> in tip.

If the two lines

+# device tree blob
+obj-$(CONFIG_X86_INTEL_CE) +=3D ce4100.dtb.o

are removed, patch 2/4 no longer depends on the ce4100 code.
The summary and description for that patch don't mention anything
about ce4100 anyway.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
