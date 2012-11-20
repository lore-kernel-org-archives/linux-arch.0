From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Tue, 20 Nov 2012 16:01:56 +0000
Message-ID: <50ABA974.9050606@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091446.28068.arnd@arndb.de> <50AB9C76.1010107@imgtec.com> <201211201543.15837.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54506 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab2KTQCx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Nov 2012 11:02:53 -0500
In-Reply-To: <201211201543.15837.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On 20/11/12 15:43, Arnd Bergmann wrote:
> On Tuesday 20 November 2012, James Hogan wrote:
>> On 09/11/12 14:46, Arnd Bergmann wrote:
>>> On Wednesday 31 October 2012, James Hogan wrote:
>>>> +
>>>> +define archhelp
>>>> +  echo  '* vmlinux.bin      - Binary kernel image (arch/$(ARCH)/boot/vmlinux.bin)'
>>>> +  @echo '  uImage   - Alias to bootable U-Boot image'
>>>> +  @echo '  uImage.bin       - Kernel-only image for U-Boot (bin)'
>>>> +  @echo '  uImage.gz        - Kernel-only image for U-Boot (gzip)'
>>>> +  @echo '  uImage.bz2       - Kernel-only image for U-Boot (bzip2)'
>>>> +  @echo '  uImage.lzma      - Kernel-only image for U-Boot (lzma)'
>>>> +  @echo '  uImage.xz        - Kernel-only image for U-Boot (xz)'
>>>> +  @echo '  uImage.lzo       - Kernel-only image for U-Boot (lzo)'
>>>> +endef
>>>
>>> The uImage format is causing some trouble on ARM because it requires knowing
>>> the load address at boot time, so we try to move people towards using just
>>> zImage files there. You might want to consider the same.
>>
>> Could you point me at some info about this problem? I'm not clear why
>> needing to know the load address at boot is a problem, or how zImage
>> helps. Does this presume that the bootloader starts the kernel with the
>> MMU bypassed?
> 
> A lot of architectures don't have a fixed location for the start of
> physical RAM, so the arguments to u-boot mkimage are configuration
> dependent. If you want to build a kernel that runs on multiple
> systems with a conflicting requirements, you can't put the load address
> into a u-boot header.

Right okay. We have a similar situation for physical RAM addresses, but
at the moment the MMU is turned on before the main bootloader, so it's
always loaded at the same address the kernel runs at. I'll certainly
bear that in mind though if we move MMU init into the kernel.

>>> It's probably not necessary to have both lzma and xz formats since they
>>> are the same algorithm with different headers afaik.
>>
>> This was copied from arch/sh/boot/Makefile if I remember right. Is
>> either of them preferred?
> 
> xz is the one that most people use today.

Thanks
James
