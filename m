From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Mon, 17 Oct 2016 13:17:33 +0200
Message-ID: <CAMuHMdXxZ+jVt-ev5zJ7VhhC7viyEfZzW+d3NyCgq02vpZg0ew@mail.gmail.com>
References: <20161017065131.GA27863@angband.pl> <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl> <CACVxJT88NHrm56XyvYgaYqW1zDjoxdPWQmMzHZ7g2MDRQSSkaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34909 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbcJQLRf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 07:17:35 -0400
In-Reply-To: <CACVxJT88NHrm56XyvYgaYqW1zDjoxdPWQmMzHZ7g2MDRQSSkaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, linux-kbuild <linux-kbuild@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Alexey,

On Mon, Oct 17, 2016 at 1:12 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Mon, Oct 17, 2016 at 1:01 PM, Adam Borowski <kilobyte@angband.pl> wrote:
>> On Mon, Oct 17, 2016 at 05:59:51PM +1100, Nicholas Piggin wrote:
>>> On Mon, 17 Oct 2016 08:51:31 +0200
>>> Adam Borowski <kilobyte@angband.pl> wrote:
>
>> --- /dev/null
>> +++ b/include/asm-generic/asm-prototypes.h
>> @@ -0,0 +1,7 @@
>> +#include <linux/bitops.h>
>> +extern void *__memset(void *, int, __kernel_size_t);
>> +extern void *__memcpy(void *, const void *, __kernel_size_t);
>> +extern void *__memmove(void *, const void *, __kernel_size_t);
>> +extern void *memset(void *, int, __kernel_size_t);
>> +extern void *memcpy(void *, const void *, __kernel_size_t);
>> +extern void *memmove(void *, const void *, __kernel_size_t);
>
> Before too late, those extern keywords aren't needed and
> only slowdown compilation.

Do you have any profiling data backing this?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
