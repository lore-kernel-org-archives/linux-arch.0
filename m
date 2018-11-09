From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/27] arm64: compat: Add vDSO
Date: Fri, 9 Nov 2018 17:23:45 +0100
Message-ID: <CAK8P3a3SHU7S0Ro-N2c-boOF=6W6WZLS7kBS2UXAUyV0VtaTOg@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-17-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181109123730.8743-17-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vincenzo.frascino@arm.com
Cc: linux-arch <linux-arch@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, salyzyn@android.com, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, pcc@google.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 9, 2018 at 1:38 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +
> +static __always_inline notrace int gettimeofday_fallback(struct timeval *_tv,
> +                                                        struct timezone *_tz)

Corresponding to what I said about the native syscalls, this should
eventually use 'old_timeval32' here.

> +static __always_inline notrace long clock_gettime_fallback(clockid_t _clkid,
> +                                                          struct timespec *_ts)

and 'old_timespec32' here.

We could do those changes as a follow-up, but since you change that code
already, we could just as well do it now.

Then there is the question about the replacement. I don't see a need for
64-bit versions of time, gettimeofday or clock_getres, but we definitely want
a new clock_gettime. This probably has to wait until we have assigned a
syscall number (for the fallback implementation), just mentioning it now
so we keep it in mind.

      Arnd
