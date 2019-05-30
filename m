Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3GoZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 May 2019 02:44:25 -0400
Date: Thu, 30 May 2019 09:44:21 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] elf: align AT_RANDOM bytes
Message-ID: <20190530064421.GA5148@avx2>
References: <20190529213708.GA10729@avx2>
 <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>
Message-ID: <20190530064421.NsdFsm_c2-CbqxlkKjHKBfEt5Y4uF4gXUbnJlhOYaE0@z>

On Wed, May 29, 2019 at 03:20:20PM -0700, Andrew Morton wrote:
> On Thu, 30 May 2019 00:37:08 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > AT_RANDOM content is always misaligned on x86_64:
> > 
> > 	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
> > 	AT_RANDOM:       0x7fff02101019
> > 
> > glibc copies first few bytes for stack protector stuff, aligned
> > access should be slightly faster.
> 
> I just don't understand the implications of this.  Is there
> (badly-behaved) userspace out there which makes assumptions about the
> current alignment?

I don't think so: glibc has getauxval(AT_RANDOM) and userspace should
use whatever it returns as "char[16]" base pointer;

> How much faster, anyway?  How frequently is the AT_RANDOM record
> accessed?

I don't think it is measureable :-\

It is accessed twice per execve: first by the kernel putting data there,
second by glibc fetching first sizeof(uintptr_t) bytes for stack canary.

Here is stack layout at the beginning of execution:

....10  e8 03 00 00 00 00 00 00  17 00 00 00 00 00 00 00  |................|
....20  00 00 00 00 00 00 00 00  19 00 00 00 00 00 00 00  |................|
				 AT_RANDOM=25
....30  79 dd ff ff ff 7f 00 00  1a 00 00 00 00 00 00 00  |y...............|
	AT_RANDOM pointer
....40  00 00 00 00 00 00 00 00  1f 00 00 00 00 00 00 00  |................|
....50  e2 ef ff ff ff 7f 00 00  0f 00 00 00 00 00 00 00  |................|
....60  89 dd ff ff ff 7f 00 00  00 00 00 00 00 00 00 00  |................|
				    AT_RANDOM bytes (misaligned)
....70  00 00 00 00 00 00 00 00  00|a2 ef 76 37 0c 0c 69  |...........v7..i|
....80  04 32 68 e4 68 2d 53 cf  a5|78 38 36 5f 36 34 00  |.2h.h-S..x86_64.|
	AT_RANDOM------------------|"x86_64" (misaligned)

		 argv[0], envp[0]
....90  00 00 00|2f 68 6f 6d 65  2f 61 64 2f 73 2d 74 65  |.../home/ad/s-te|
....a0  73 74 2f 61 2e 6f 75 74  00 47 53 5f 4c 49 42 3d  |st/a.out.GS_LIB=|

> I often have questions such as these about your performance/space
> tweaks :(.  Please try to address them as a matter of course when
> preparing changelogs?

OK.
