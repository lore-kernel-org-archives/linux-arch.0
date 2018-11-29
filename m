From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 04/28] kernel: Add masks support for Raw and NTP
 time
Date: Thu, 29 Nov 2018 23:41:03 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1811292339240.1657@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-5-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129170530.37789-5-vincenzo.frascino@arm.com>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, 29 Nov 2018, Vincenzo Frascino wrote:

> Depending on the clocksource selected there can be supported a
> different resolution hence we require a mask to be applied to the
> time calculation.
> 
> This patch exposes the mask in the datapage for Raw and NTP adjusted
> clock.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/vdso/datapage.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index d50a108afaed..0a7bdccf5773 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -34,6 +34,8 @@ struct vdso_data {
>  	__u64 wtm_clock_nsec;
>  	__u64 btm_nsec;		/* Monotonic to boot time */
>  	__u64 tai_sec;		/* International Atomic Time */
> +	__u64 cs_mono_mask;	/* NTP-adjusted clocksource mask */
> +	__u64 cs_raw_mask;	/* Raw clocksource mask */

And why would they be different? The core timekeeper has them duplicated
purely for access pattern optimization and simplicity.

Thanks,

	tglx
