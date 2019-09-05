From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 0/3] Enhance Hyper-V for hibernation
Date: Thu, 5 Sep 2019 22:47:03 +0000
Message-ID: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
List-Id: linux-arch.vger.kernel.org

This patchset (consisting of 3 patches) was part of the v4 patchset (consis=
ting
of 12 patches):
    https://lkml.org/lkml/2019/9/2/894

I realized these 3 patches must go through the tip.git tree, because I have
to rebase 2 of the 3 patches due to recent changes from others in the tip
tree.

All the 3 patches are now rebased to the tip tree's timers/core branch:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dtimers=
/core
, and all the 3 patches have Michael Kelley's Signed-off-by's.

Please review.

Thanks!
Dexuan

Dexuan Cui (3):
  x86/hyper-v: Suspend/resume the hypercall page for hibernation
  x86/hyper-v: Implement hv_is_hibernation_supported()
  clocksource/drivers: Suspend/resume Hyper-V clocksource for
    hibernation

 arch/x86/hyperv/hv_init.c          | 40 ++++++++++++++++++++++++++++++++++=
++++
 drivers/clocksource/hyperv_timer.c | 25 ++++++++++++++++++++++++
 include/asm-generic/mshyperv.h     |  2 ++
 3 files changed, 67 insertions(+)

--=20
1.8.3.1
