Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36877 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGX1F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Oct 2019 19:27:05 -0400
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa7c91aa-ed82-acd4-8835-d2580ee8232c@roeck-us.net>
Date: Mon, 7 Oct 2019 16:27:01 -0700
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgvz6k88hxY_G3=itbQ-iVz7Hc9fbF3kZ_nePA7XgvDTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Michael Cree <mcree@orcon.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191007232701.g0AX0YcCbRUqcYuoleYOhxCxS4bvdgBXHajMZoS6zvs@z>

On 10/7/19 12:21 PM, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 3:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> this patch causes all my sparc64 emulations to stall during boot. It causes
>> all alpha emulations to crash with [1a] and [1b] when booting from a virtual
>> disk, and one of the xtensa emulations to crash with [2].
> 
> So I think your alpha emulation environment may be broken, because
> Michael Cree reports that it works for him on real hardware, but he
> does see the kernel unaligned count being high.
> 
> But regardless, this is my current fairly minimal patch that I think
> should fix the unaligned issue, while still giving the behavior we
> want on x86. I hope Al can do something nicer, but I think this is
> "acceptable".
> 
> I'm running this now on x86, and I verified that x86-32 code
> generation looks sane too, but it woudl be good to verify that this
> makes the alignment issue go away on other architectures.
> 
>                  Linus
> 

Test results look good. Feel free to add
Tested-by: Guenter Roeck <linux@roeck-us.net>
to your patch.

Build results:
	total: 158 pass: 154 fail: 4
Failed builds:
	arm:allmodconfig
	m68k:defconfig
	mips:allmodconfig
	sparc64:allmodconfig
Qemu test results:
	total: 391 pass: 390 fail: 1
Failed tests:
	ppc64:mpc8544ds:ppc64_e5500_defconfig:nosmp:initrd

This is with "regulator: fixed: Prevent NULL pointer dereference when !CONFIG_OF"
applied as well. The other failures are unrelated.

arm:

arch/arm/crypto/aes-ce-core.S:299: Error:
	selected processor does not support `movw ip,:lower16:.Lcts_permute_table' in ARM mode

Fix is pending in crypto tree.

m68k:

c2p_iplan2.c:(.text+0x98): undefined reference to `c2p_unsupported'

I don't know the status.

mips:

drivers/staging/octeon/ethernet-defines.h:30:38: error:
		'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared
and other similar errors. I don't know the status.

ppc64:

powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x18): undefined reference to `node_reclaim_distance'

Reported against offending patch earlier today.

sparc64:

drivers/watchdog/cpwd.c:500:19: error: 'compat_ptr_ioctl' undeclared here

Oops. I'll need to look into that. Looks like the patch to use a new
infrastructure made it into the kernel but the infrastructure itself
didn't make it after all.

Guenter
