From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 01/24] kernel: Standardize vdso_datapage
Date: Tue, 15 Jan 2019 15:57:30 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <20190115135539.24762-2-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190115135539.24762-2-vincenzo.frascino@arm.com>
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

On Tue, 15 Jan 2019, Vincenzo Frascino wrote:

> +/*
> + * There is one vdso_timestamp object in vvar for each vDSO-accelerated
> + * clock_id. For high-resolution clocks, this encodes the time
> + * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
> + * the actual time.
> + *
> + * To be noticed that nsec is left-shifted by vdso_data.shift.

This is only true for highres clocks. For coarse the nsec value is not
shifted.

> + */
> +struct vdso_timestamp {
> +	u64 sec;
> +	u64 nsec;
> +};
> +
> +/*
> + * vdso_data will be accessed by 32 and 64 bit code at the same time
> + * so we should be careful before modifying this structure.
> + */
> +struct vdso_data {
> +	u32 seq;		/* Timebase sequence counter */
> +
> +	s32 clock_mode;
> +	u64 cycle_last;		/* Timebase at clocksource init */
> +	u64 mask;		/* Clocksource mask (mono = raw) */

mono = raw? This is broken. The VDSO cannot define time different from the
regular syscall interfaces.

Thanks,

	tglx
