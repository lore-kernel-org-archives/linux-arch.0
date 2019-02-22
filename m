From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
Date: Fri, 22 Feb 2019 12:58:13 +0000
Message-ID: <20190222125812.GF42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-2-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-2-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Vincenzo,

On Fri, Feb 22, 2019 at 12:24:08PM +0000, Vincenzo Frascino wrote:
> +#ifdef __KERNEL__

I believe that __KERNEL__ guards haven't been necessary (in non-UAPI
headers) since the UAPI split, and can be removed.

[...]

> +#include <linux/bits.h>
> +#include <linux/types.h>
> +#include <linux/time.h>

Nit: could we please keep these in alphabetical order?

> +/*
> + * There is one vdso_timestamp object in vvar for each vDSO-accelerated
> + * clock_id. For high-resolution clocks, this encodes the time
> + * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
> + * the actual time.
> + *
> + * To be noticed that for highres clocks nsec is left-shifted by
> + * vdso_data.cs[x].shift.

Nit: this would read better as:

	Note that for highres clocks nsec is left-shifted by
	vdso_data.cs[x].shift.

[...]

> +/*
> + * vdso_data will be accessed by 32 and 64 bit code at the same time
> + * so we should be careful before modifying this structure.
> + */

Perhaps:

/*
 * This structure will be accessed by native and compat vDSOs, so we
 * need to ensure the layout is identical for native and compat code.
 */

... which I think is what you're trrying to say?

Thanks,
Mark.
