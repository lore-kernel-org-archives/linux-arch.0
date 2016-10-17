From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Mon, 17 Oct 2016 14:12:06 +0300
Message-ID: <CACVxJT88NHrm56XyvYgaYqW1zDjoxdPWQmMzHZ7g2MDRQSSkaQ@mail.gmail.com>
References: <20161017065131.GA27863@angband.pl> <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161017100130.GA16013@angband.pl>
Sender: linux-kbuild-owner@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, linux-kbuild@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
