From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/27] kernel: Define gettimeofday vdso common code
Date: Sat, 10 Nov 2018 17:18:03 +0100
Message-ID: <CAK8P3a0QSfzsM-h9Kf36Pzr2WvXbyi0_RQG0+Nsp+1RoTRq7Ww@mail.gmail.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
 <20181109123730.8743-7-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181109123730.8743-7-vincenzo.frascino@arm.com>
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
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 11/9/18, Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> In the last few years we assisted to an explosion of vdso
> implementations that mostly share similar code.
>
> This patch tries to unify the gettimeofday vdso implementation
> introducing lib/vdso. The code contained in this library can
> ideally be reused by all the architectures avoiding, where
> possible, code duplication.
>
> In doing so, tries to maintain the performances using inlining as much
> as possible and consequently reduces the surface for ROP type of attacks.
>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

I just noticed that this new version misses some of the cleanups
that Thomas recently did in the x86 version, e.g. f3e839384164
("x86/vdso: Replace the clockid switch case").

I haven't looked at all the details, but I'd suggest using the latest
x86 code as a base.

        Arnd
