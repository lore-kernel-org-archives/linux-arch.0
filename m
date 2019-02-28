From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] vdso: use fixed-size time types
Date: Thu, 28 Feb 2019 14:42:41 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1902281440340.1821@nanos.tec.linutronix.de>
References: <CAK8P3a2D44CDXbcKB-WtphYY9E74ovFPs+e4Ti3fUqRL77AYhw@mail.gmail.com>
 <20190228115855.610027-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190228115855.610027-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, 28 Feb 2019, Arnd Bergmann wrote:

> Hi Vincento,
> 
> I've implemented now what I tried to explain earlier.  This moves the
> implementation of clock_gettime() and clock_getres() over to 64-bit
> __kernel_timespec, with a conversion in the end for architectures that
> actually use the 32-bit calls.
> 
> The vdso/types.h file is now obsolete, but we do need to duplicate
> a few functions on mips32 and x86-32. It may be possible to fold those
> into the generic lib/vdso/gettimeofday.c file as another step.
> 
> If there are no objections, please fold these changes into your
> series.

Please write the new generic code in that way and apply the architecture
changes when converting them over.

Thanks,

	tglx
