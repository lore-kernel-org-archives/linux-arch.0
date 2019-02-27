From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Date: Wed, 27 Feb 2019 16:06:49 +0000
Message-ID: <65173128-04b3-fd03-247b-d090703244ac@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
 <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
 <alpine.DEB.2.21.1902271640260.26197@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1902271640260.26197@nanos.tec.linutronix.de>
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

On 27/02/2019 15:49, Thomas Gleixner wrote:
> Vincenzo,
> 
> On Wed, 27 Feb 2019, Vincenzo Frascino wrote:
>>
>> The clocksource array has two elements (CLOCKSOURCE_RAW, CLOCKSOURCE_MONO) and
>> the situation with my scheme should be the following:
> 
> Oops. I misread the patch, but still...
> 
>> 	u32		seq:			+    0
>> 	s32		clock_mode;		+    4
>> 	u64		cycle_last;		+    8
>> 	struct vdso_cs	cs[2];			+    16
>> 	struct vdso_ts	basetime[VDSO_BASES];	+    48
>>
>> which I agree makes still things a bit worse.
> 
>>> It's easy enough to benchmark these implementations and without trying I'm
>>> pretty sure that you can see the performance drop nicely. Please do so next
>>> time and provide the numbers in the changelogs.
>>>
>>
>> I did run some benchmarks this morning to quantify the performance impact and
>> seems that using vdsotest[1] the difference in between a stock linux kernel
>> 5.0.0-rc7 and one that has unified vDSO, running on my x86 machine (Xeon Gold
>> 5120T), is below 1%. Please find the results below, I will add them as well to
>> the next changelog.
> 
> I have some doubts about 1%.
> 			    	   NEW	STOCK
> clock-gettime-monotonic:    vdso:  31	 28    ~ 10% slower
> clock-gettime-realtime:     vdso:  32    29    ~ 10% slower
>

Sorry, there was an error in my script that I used to extract percentages. I
agree! Luckily I shared the numbers. Thanks Thomas.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
