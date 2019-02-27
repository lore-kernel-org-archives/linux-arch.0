From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
Date: Wed, 27 Feb 2019 14:23:02 +0000
Message-ID: <3f7238b5-3357-3635-38f4-9eaa14e400c9@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 23/02/2019 16:51, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>> +/*
>> + * There is one vdso_clocksource object in vvar for each vDSO clocksource
>> + * (mono, raw). This struct is designed to keep vdso_data "cache-line friendly"
>> + * and optimal in terms of access pattern.
>> + *
>> + * Note that mask and shift are the same for mono and raw.
>> + */
>> +struct vdso_clocksource {
>> +	u64 mask;		/* Clocksource mask */
>> +	u32 mult;		/* Clocksource multiplier */
>> +	u32 shift;		/* Clocksource shift */
> 
> Can you please get rid of the tail comments and use proper kerneldoc
> format?
>

I will fix it in v6, thanks.

>> +/*
>> + * vdso_data will be accessed by 32 and 64 bit code at the same time
>> + * so we should be careful before modifying this structure.
>> + */
>> +struct vdso_data {
>> +	u32 seq;		/* Timebase sequence counter */
>> +
>> +	s32 clock_mode;
>> +	u64 cycle_last;		/* Timebase at clocksource init */
>> +
>> +	struct vdso_clocksource cs[CLOCKSOURCE_BASES];
> 
> Why would you need different clocksource parameters? That really bloats the
> data structure and makes the cache access pattern worse. Also the vdso
> update needs to copy the same data over and over for no value.
> 
> The only clock ID which needs a different mult/shift would be
> MONOTONIC_RAW, but if we expose that through the VDSO then we really can be
> smarter than this. See incomplete and uncompilable patch below for
> reference. You get the idea.
> 

Ok, thank you for providing the reference code. I will update my patches in v6
accordingly.

...

-- 
Regards,
Vincenzo
