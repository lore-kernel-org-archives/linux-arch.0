From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/8] lib: vdso: Build 32 bit specific functions in the right context
Date: Tue, 14 Jan 2020 11:37:57 +0100
Message-ID: <87muaqqq62.fsf@nanos.tec.linutronix.de>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com> <20190830135902.20861-3-vincenzo.frascino@arm.com> <87tv4zq9dc.fsf@nanos.tec.linutronix.de> <87r202qt4x.fsf@nanos.tec.linutronix.de> <d0df0900-5001-540e-e246-c87c8525d0a4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d0df0900-5001-540e-e246-c87c8525d0a4@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
List-Id: linux-arch.vger.kernel.org

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>
> On 14/01/2020 09:33, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> 
> [...]
>
>> 
>> Bah, it's not fixing it. That's what you get when you compile the wrong
>> tree...

This part is required to cover the BUILD_VDSO32 guard, but then when the
fallback thing is removed it fails again because the 32bit fallbacks are
missing.

The patch below makes it build again.

Thanks,

        tglx

8<----------------
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -52,6 +52,24 @@ static __always_inline long clock_gettim
 	return ret;
 }
 
+static __always_inline long clock_gettime32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_gettime;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
 static __always_inline int clock_getres_fallback(
 					clockid_t _clkid,
 					struct __kernel_timespec *_ts)
@@ -63,6 +81,24 @@ static __always_inline int clock_getres_
 
 	asm volatile(
 	"       swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline int clock_getres32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_getres;
+
+	asm volatile(
+	"       swi #0\n"
 	: "=r" (ret)
 	: "r" (clkid), "r" (ts), "r" (nr)
 	: "memory");
