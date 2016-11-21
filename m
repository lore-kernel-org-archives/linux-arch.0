From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH reworded] x86/kbuild: enable modversions for symbols
 exported from asm
Date: Mon, 21 Nov 2016 17:49:41 +0100
Message-ID: <fc83bd60-3298-7001-92ed-972b77ca8ea3@hartkopp.net>
References: <20161121182714.2cd5da75@roar.ozlabs.ibm.com>
 <20161121145220.10430-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161121145220.10430-1-kilobyte@angband.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>, Peter Wu <peter@lekensteyn.nl>, Vince Weaver <vincent.weaver@maine.edu>, Michal Marek <mmarek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info
List-Id: linux-arch.vger.kernel.org



On 11/21/2016 03:52 PM, Adam Borowski wrote:
> Commit 4efca4ed ("kbuild: modversions for EXPORT_SYMBOL() for asm") adds
> modversion support for symbols exported from asm files. Architectures
> must include C-style declarations for those symbols in asm/asm-prototypes.h
> in order for them to be versioned.
>
> Add these declarations for x86, and an architecture-independent file that
> can be used for common symbols.
>
> User impact: kernels may fail to load modules at all when
> CONFIG_MODVERSIONS=y.

late but great :-)

Thanks for fixing this!

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

(if you like)

Regards,
Oliver

>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> Tested-by: Kalle Valo <kvalo@codeaurora.org>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Tested-by: Peter Wu <oeter@lekensteyn.nl>
> ---
>  arch/x86/include/asm/asm-prototypes.h | 12 ++++++++++++
>  include/asm-generic/asm-prototypes.h  |  7 +++++++
>  2 files changed, 19 insertions(+)
>  create mode 100644 arch/x86/include/asm/asm-prototypes.h
>  create mode 100644 include/asm-generic/asm-prototypes.h
>
> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
> new file mode 100644
> index 0000000..ae87224
> --- /dev/null
> +++ b/arch/x86/include/asm/asm-prototypes.h
> @@ -0,0 +1,12 @@
> +#include <asm/ftrace.h>
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
