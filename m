From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Date: Mon, 24 Jun 2019 16:18:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
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
Cc: Andy Lutomirski <luto@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Michael Kelley <mikelley@microsoft.com>, Peter Collingbourne <pcc@google.com>, LAK <linux-arm-kernel@lists.infradead.org>, Andrei Vagin <avagin@openvz.org>, Huw Davies <huw@codeweavers.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Shijith
List-Id: linux-arch.vger.kernel.org

Vincenzo,

On Mon, 24 Jun 2019, Thomas Gleixner wrote:

> I did not merge the ARM and MIPS parts as they lack any form of
> acknowlegment from their maintainers. Please talk to those folks. If they
> ack/review the changes then I can pick them up and they go into 5.3 or they
> have to go in a later cycle. Nevertheless it was well worth the trouble to
> have those conversions done to confirm that the new common library fits a
> bunch of different architectures.

I talked to Russell King and he suggested to file the ARM parts into his
patch system and he'll pick them up after 5.3-rc1.

   https://www.arm.linux.org.uk/developer/patches/

I paged out how to deal with it, but you'll surely manage :)

Thanks,

	tglx
