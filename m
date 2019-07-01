From: Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 0/2] clocksource/drivers: Create new Hyper-V clocksource
 driver
Date: Mon, 1 Jul 2019 04:25:41 +0000
Message-ID: <1561955054-1838-1-git-send-email-mikelley@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "shuah@kernel.org" <shuah@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, KY Srinivasan <kys@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, marcelo.cerri@canonical.com
List-Id: linux-arch.vger.kernel.org

This patch series moves Hyper-V clock/timer code to a separate Hyper-V
clocksource driver. Previously, Hyper-V clock/timer code and data
structures were mixed in with other Hyper-V code in the ISA independent
drivers/hv code as well as in ISA dependent code. The new Hyper-V
clocksource driver is ISA agnostic, with a just few dependencies on
ISA specific functions. The patch series does not change any behavior
or functionality -- it only reorganizes the existing code and fixes up
the linkages. A few places outside of Hyper-V code are fixed up to use
the new #include file structure.

This restructuring is in response to Marc Zyngier's review comments
on supporting Hyper-V running on ARM64, and is a good idea in general.
It increases the amount of code shared between the x86 and ARM64
architectures, and reduces the size of the new code for supporting
Hyper-V on ARM64. A new version of the Hyper-V on ARM64 patches will
follow once this clocksource restructuring is accepted.

The code is diff'ed against the upstream tip tree:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso

Changes in v5:
* Revised commit summaries [Thomas Gleixner]
* Removed call to clockevents_unbind_device() [Thomas Gleixner]
* Restructured hv_init_clocksource() [Thomas Gleixner]
* Various other small code cleanups [Thomas Gleixner]

Changes in v4:
* Revised commit messages
* Rebased to upstream tip tree

Changes in v3:
* Removed boolean argument to hv_init_clocksource(). Always call
sched_clock_register, which is needed on ARM64 but a no-op on x86.
* Removed separate cpuhp setup in hv_stimer_alloc() and instead
directly call hv_stimer_init() and hv_stimer_cleanup() from
corresponding VMbus functions.  This more closely matches original
code and avoids clocksource stop/restart problems on ARM64 when
VMbus code denies CPU offlining request.

Changes in v2:
* Revised commit short descriptions so the distinction between
the first and second patches is clearer [GregKH]
* Renamed new clocksource driver files and functions to use
existing "timer" and "stimer" names instead of introducing
"syntimer". [Vitaly Kuznetsov]
* Introduced CONFIG_HYPER_TIMER to fix build problem when
CONFIG_HYPERV=m [Vitaly Kuznetsov]
* Added "Suggested-by: Marc Zyngier"

Michael Kelley (2):
  clocksource/drivers: Make Hyper-V clocksource ISA agnostic
  clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic

 MAINTAINERS                              |   2 +
 arch/x86/entry/vdso/vma.c                |   2 +-
 arch/x86/hyperv/hv_init.c                |  91 +--------
 arch/x86/include/asm/hyperv-tlfs.h       |   6 +
 arch/x86/include/asm/mshyperv.h          |  81 +-------
 arch/x86/include/asm/vdso/gettimeofday.h |   2 +-
 arch/x86/kernel/cpu/mshyperv.c           |   4 +-
 arch/x86/kvm/x86.c                       |   1 +
 drivers/clocksource/Makefile             |   1 +
 drivers/clocksource/hyperv_timer.c       | 339 +++++++++++++++++++++++++++++++
 drivers/hv/Kconfig                       |   3 +
 drivers/hv/hv.c                          | 156 +-------------
 drivers/hv/hv_util.c                     |   1 +
 drivers/hv/hyperv_vmbus.h                |   3 -
 drivers/hv/vmbus_drv.c                   |  42 ++--
 include/clocksource/hyperv_timer.h       | 105 ++++++++++
 16 files changed, 503 insertions(+), 336 deletions(-)
 create mode 100644 drivers/clocksource/hyperv_timer.c
 create mode 100644 include/clocksource/hyperv_timer.h

-- 
1.8.3.1
