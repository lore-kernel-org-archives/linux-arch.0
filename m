Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34170 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933470AbcJQLMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 07:12:08 -0400
MIME-Version: 1.0
In-Reply-To: <20161017100130.GA16013@angband.pl>
References: <20161017065131.GA27863@angband.pl> <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl>
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Mon, 17 Oct 2016 14:12:06 +0300
Message-ID: <CACVxJT88NHrm56XyvYgaYqW1zDjoxdPWQmMzHZ7g2MDRQSSkaQ@mail.gmail.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, linux-kbuild@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20161017111206.2gvFGI9thvnQXRpTnwvL6_gr4ONmxzm-tNEAMsh8Cis@z>

On Mon, Oct 17, 2016 at 1:01 PM, Adam Borowski <kilobyte@angband.pl> wrote:
> On Mon, Oct 17, 2016 at 05:59:51PM +1100, Nicholas Piggin wrote:
>> On Mon, 17 Oct 2016 08:51:31 +0200
>> Adam Borowski <kilobyte@angband.pl> wrote:

> --- /dev/null
> +++ b/include/asm-generic/asm-prototypes.h
> @@ -0,0 +1,7 @@
> +#include <linux/bitops.h>
> +extern void *__memset(void *, int, __kernel_size_t);
> +extern void *__memcpy(void *, const void *, __kernel_size_t);
> +extern void *__memmove(void *, const void *, __kernel_size_t);
> +extern void *memset(void *, int, __kernel_size_t);
> +extern void *memcpy(void *, const void *, __kernel_size_t);
> +extern void *memmove(void *, const void *, __kernel_size_t);

Before too late, those extern keywords aren't needed and
only slowdown compilation.
