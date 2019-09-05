Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr720114.outbound.protection.outlook.com ([40.107.72.114]:24931
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIEWrS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 18:47:18 -0400
From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Date: Thu, 5 Sep 2019 22:47:15 +0000
Message-ID: <1567723581-29088-4-git-send-email-decui@microsoft.com>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Message-ID: <20190905224715._qDIlWZLALFEnZf7B4eTDfHuUkb11C4zOJ2s67flxBE@z>

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's=
.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyper=
v_timer.c
index 726a65e..07f4747 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -237,12 +237,37 @@ static u64 read_hv_sched_clock_tsc(void)
 	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
=20
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr =3D virt_to_phys(&tsc_pg);
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &=3D GENMASK_ULL(11, 0);
+	tsc_msr |=3D BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc =3D {
 	.name	=3D "hyperv_clocksource_tsc_page",
 	.rating	=3D 400,
 	.read	=3D read_hv_clock_tsc,
 	.mask	=3D CLOCKSOURCE_MASK(64),
 	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend=3D suspend_hv_clock_tsc,
+	.resume	=3D resume_hv_clock_tsc,
 };
=20
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
--=20
1.8.3.1
