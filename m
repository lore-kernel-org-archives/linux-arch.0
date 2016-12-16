From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Fri, 16 Dec 2016 20:55:07 +0100
Message-ID: <7212667f-f508-2b41-a380-8f736814d8cc@suse.cz>
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161017100130.GA16013@angband.pl>
Sender: linux-kbuild-owner@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 10/17/2016, 12:01 PM, Adam Borowski wrote:
> Anyway, here's my stab at x86:

Hi,

what happened to this? I had to apply this to fix 4.9-pae kernel here.

> From db746df65b920591606398b4b244f5b6dc9eea04 Mon Sep 17 00:00:00 2001
> From: Adam Borowski <kilobyte@angband.pl>
> Date: Mon, 17 Oct 2016 11:42:35 +0200
> Subject: [PATCH] kbuild: provide include/asm/asm-prototypes.h for x86
> 
> Nicholas Piggin wrote:
>> Architectures will need to have an include/asm/asm-prototypes.h that
>> defines or #include<>s C-style prototypes for exported asm functions.
>> We can do an asm-generic version for the common ones like memset so
>> there's not a lot of pointless duplication there.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  arch/x86/include/asm/asm-prototypes.h | 13 +++++++++++++
>  include/asm-generic/asm-prototypes.h  |  7 +++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 arch/x86/include/asm/asm-prototypes.h
>  create mode 100644 include/asm-generic/asm-prototypes.h
> 
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
> new file mode 100644
> index 0000000..072c97c
> --- /dev/null
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -0,0 +1,13 @@
> +#include <asm/ftrace.h>
> +#include <asm/uaccess.h>
> +#include <asm/uaccess.h>
> +#include <asm/string.h>
> +#include <asm/page.h>
> +#include <asm/checksum.h>
> +
> +#include <asm-generic/asm-prototypes.h>
> +
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/special_insns.h>
> +#include <asm/preempt.h>
> diff --git a/include/asm-generic/asm-prototypes.h b/include/asm-generic/asm-prototypes.h
> new file mode 100644
> index 0000000..df13637
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
> 

thanks,
-- 
js
suse labs
