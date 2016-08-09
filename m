From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: c6x linker issue on linux-next-20160808 + some linker table work
Date: Tue, 9 Aug 2016 06:37:13 -0700
Message-ID: <741c0f4d-bd9c-f28a-12d1-64bb483c6998@roeck-us.net>
References: <CAB=NE6Xqah+dnk68v3+de=CrHOxHvAqK7G=UX_hoCAmvA9zo5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56509 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257AbcHINhP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2016 09:37:15 -0400
In-Reply-To: <CAB=NE6Xqah+dnk68v3+de=CrHOxHvAqK7G=UX_hoCAmvA9zo5g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>

On 08/09/2016 01:11 AM, Luis R. Rodriguez wrote:
> Mark, Aurelien,
>
> I've run into a linker (ld) issue caused by the linker table work I've
> been working on [0]. I looked into this and for the life of me, I
> cannot comprehend what the problem is, so was hoping you folks might
> be able to chime in.
>

For reference, the error is

c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined
c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined

Toolchain used is:

c6x-elf-gcc (GCC) 5.2.0
GNU ld (GNU Binutils) 2.25

Guenter

> A snapshot you can use is available here:
>
> https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160808-linker-table-v4
>
> The commit that causes the issue is "firmware: port built-in section
> to linker table":
>
> https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/commit/?h=20160808-linker-table-v4&id=2f4516be8c89b3ca008962798d44b54751e62844
>
> its the first use of linker tables in the kernel, but I can't figure
> out why this error comes up, nor how to fix it. Any ideas?
>
> [0] lkml.kernel.org/r/1469222687-1600-1-git-send-email-mcgrof@kernel.org
>
>   Luis
>
