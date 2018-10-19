From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Date: Fri, 19 Oct 2018 12:15:43 +0100
Message-ID: <20181019111542.6wrvjguirglzg7vg@mbp>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <20181005084754.20950-8-kristina.martsenko@arm.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: linux-arch@vger.kernel.org, Jacob Bramley <jacob.bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, Adam Wallis <awallis@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Amit Kachhap <Amit.Kachhap@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 05, 2018 at 09:47:44AM +0100, Kristina Martsenko wrote:
> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> new file mode 100644
> index 000000000000..2aefedc31d9e
> --- /dev/null
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef __ASM_POINTER_AUTH_H
> +#define __ASM_POINTER_AUTH_H
> +
> +#include <linux/random.h>
> +
> +#include <asm/cpufeature.h>
> +#include <asm/sysreg.h>
> +
> +#ifdef CONFIG_ARM64_PTR_AUTH
> +/*
> + * Each key is a 128-bit quantity which is split across a pair of 64-bit
> + * registers (Lo and Hi).
> + */
> +struct ptrauth_key {
> +	unsigned long lo, hi;
> +};
> +
> +/*
> + * We give each process its own instruction A key (APIAKey), which is shared by
> + * all threads. This is inherited upon fork(), and reinitialised upon exec*().
> + * All other keys are currently unused, with APIBKey, APDAKey, and APBAKey
> + * instructions behaving as NOPs.
> + */

I don't remember the past discussions but I assume the tools guys are ok
with a single key shared by multiple threads. Ramana, could you ack this
part, FTR?

(and it would help if someone from the Android and Chrome camps can
confirm)

Thanks.

-- 
Catalin
