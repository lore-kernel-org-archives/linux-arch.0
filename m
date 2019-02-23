From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 22/23] x86: Add support for generic vDSO
Date: Sat, 23 Feb 2019 11:45:15 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1902231138130.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-23-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190222122430.21180-23-vincenzo.frascino@arm.com>
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>  void update_vsyscall_tz(void)
>  {
> -	vsyscall_gtod_data.tz_minuteswest = sys_tz.tz_minuteswest;
> -	vsyscall_gtod_data.tz_dsttime = sys_tz.tz_dsttime;
> +	vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
> +	vdso_data.tz_dsttime = sys_tz.tz_dsttime;
>  }
>  
>  void update_vsyscall(struct timekeeper *tk)
>  {
>  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
> -	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
> -	struct vgtod_ts *base;
> +	struct vdso_data *vdata = &vdso_data;
> +	struct vdso_timestamp *vdso_ts;
>  	u64 nsec;
>  
>  	/* Mark the new vclock used. */
>  	BUILD_BUG_ON(VCLOCK_MAX >= 32);
>  	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
>  
> -	gtod_write_begin(vdata);
> +	vdso_write_begin(vdata);

This begs the question why this update code is still architecture
specific. The vdso data is now generic, so the whole update can be generic
as well. The only x86 specific thing is this perhaps:

  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;

	vdata->clock_mode	= vclock_mode;

But either than can be made generic and mandatory or easily resolved with a
trivial arch_update_vsyscall() inline.

Thanks,

	tglx
