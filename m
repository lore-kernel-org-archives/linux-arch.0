Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41196 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab0LWGOV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Dec 2010 01:14:21 -0500
MIME-Version: 1.0
In-Reply-To: <4D127D72.8050303@suse.cz>
References: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
	<1293047849-26078-2-git-send-email-dirk.brandewie@gmail.com>
	<4D127D72.8050303@suse.cz>
Date: Thu, 23 Dec 2010 07:14:20 +0100
Message-ID: <AANLkTik-yqs2Dy+MBAcQ5Gpb9Vcvd80BS=C=fuDe7z-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: Add support for linking device tree blobs into vmlinux
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: dirk.brandewie@gmail.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <20101223061420.bjdIdR7rjIyx8EBcRQaiYdG420XLsRlKdjWQhxw5yNo@z>

2010/12/22 Michal Marek <mmarek@suse.cz>:
> On 22.12.2010 20:57, dirk.brandewie@gmail.com wrote:
>>
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>
>> This patch adds support for linking device tree blob(s) into
>> vmlinux. Modifies asm-generic/vmlinux.lds.h to add linking
>> .dtb sections into vmlinux. To maintain compatiblity with the of/fdt
>> driver code platforms MUST copy the blob to a non-init memory location
>> before the kernel frees the .init.* sections in the image.
>>
>> Modifies scripts/Makefile.lib to add a kbuild command to
>> compile DTS files to device tree blobs and a rule to create objects to
>> wrap the blobs for linking.
>>
>> STRUCT_ALIGNMENT is defined in vmlinux.lds.h for use in the rule to
>> create wrapper objects for the dtb in Makefile.lib.  The
>> STRUCT_ALIGN() macro in vmlinux.lds.h is modified to use the
>> STRUCT_ALIGNMENT definition.
>>
>> The DTB's are placed on 32 byte boundries to allow parsing the blob
>> with driver/of/fdt.c during early boot without having to copy the blob
>> to get the structure alignment GCC expects.
>>
>> A DTB is linked in by adding the DTB object to the list of objects to
>> be linked into vmlinux in the archtecture specific Makefile using
>>    obj-y += foo.dtb.o
>>
>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>
> Hi,
>
> you can add
> Acked-by: Michal Marek <mmarek@suse.cz>
> but I thing this series should go through the tip tree, as your primary
> target seems to be x86 and patch 2/4 depends on the ce4100 code that is only
> in tip.

If the two lines

+# device tree blob
+obj-$(CONFIG_X86_INTEL_CE) += ce4100.dtb.o

are removed, patch 2/4 no longer depends on the ce4100 code.
The summary and description for that patch don't mention anything
about ce4100 anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
