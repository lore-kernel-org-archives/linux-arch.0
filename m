From: Mark Salter <msalter@redhat.com>
Subject: Re: c6x linker issue on linux-next-20160808 + some linker table work
Date: Tue, 09 Aug 2016 13:04:00 -0400
Message-ID: <1470762240.3551.42.camel@redhat.com>
References: <CAB=NE6Xqah+dnk68v3+de=CrHOxHvAqK7G=UX_hoCAmvA9zo5g@mail.gmail.com>
	 <741c0f4d-bd9c-f28a-12d1-64bb483c6998@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302AbcHIRED (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Aug 2016 13:04:03 -0400
In-Reply-To: <741c0f4d-bd9c-f28a-12d1-64bb483c6998@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Aurelien Jacquiot <a-jacquiot@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>

On Tue, 2016-08-09 at 06:37 -0700, Guenter Roeck wrote:
> On 08/09/2016 01:11 AM, Luis R. Rodriguez wrote:
> > 
> > Mark, Aurelien,
> > 
> > I've run into a linker (ld) issue caused by the linker table work I've
> > been working on [0]. I looked into this and for the life of me, I
> > cannot comprehend what the problem is, so was hoping you folks might
> > be able to chime in.
> > 
> For reference, the error is
> 
> c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined
> c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined

DSBT is a reference to the no-MMU userspace ABI used by c6x. The kernel shouldn't
be referencing DSBT base. The -mno-dsbt gcc flag should prevent it.

> 
> Toolchain used is:
> 
> c6x-elf-gcc (GCC) 5.2.0
> GNU ld (GNU Binutils) 2.25
> 
> Guenter
> 
> > 
> > A snapshot you can use is available here:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/log/?h=20160808-linker-table-v4
> > 
> > The commit that causes the issue is "firmware: port built-in section
> > to linker table":
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/mcgrof/linux-next.git/commit/?h=20160808-linker-table-v4&id=2f4516be8c89b3ca008962798d44b54751e62844
> > 
> > its the first use of linker tables in the kernel, but I can't figure
> > out why this error comes up, nor how to fix it. Any ideas?
> > 
> > [0] lkml.kernel.org/r/1469222687-1600-1-git-send-email-mcgrof@kernel.org
> > 
> >   Luis
> > 
