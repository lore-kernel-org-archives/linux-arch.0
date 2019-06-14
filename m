From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Fri, 14 Jun 2019 13:15:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Kelley <mikelley@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Salyzyn <salyzyn@android.com>, Huw Davies <huw@codeweavers.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, Dmitry Safonov <0x7f454c46@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.inf>
List-Id: linux-arch.vger.kernel.org

On Thu, 30 May 2019, Michael Kelley wrote:
> Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
> I have that moves all of the Hyper-V clock/timer code into a separate
> clocksource driver in drivers/clocksource, with an include file in
> includes/clocksource.  That new include file should be able to work
> instead of your new mshyperv-tsc.h.  It also has the benefit of being
> ISA neutral, so it will work with my in-progress patch set to support
> Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
> for the new clocksource driver patch set.

Grrr. That's queued in hyperv-next for whatever reasons.

Sasha, can you please provide me the branch to pull from so I can have a
common base for all the various changes floating around?

Thanks,

	tglx
