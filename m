Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:47074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbfGZQaB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 12:30:01 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 0/2] mips: vdso: Fix Makefile
Date: Fri, 26 Jul 2019 17:29:42 +0100
Message-ID: <20190726162944.12149-1-vincenzo.frascino@arm.com>
In-Reply-To: <MWHPR2201MB1277C33D971A9C8945812CFCC1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <MWHPR2201MB1277C33D971A9C8945812CFCC1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org
Message-ID: <20190726162942.b7F-KIyMOt9YUwKTHEMvdwtiDr9jNTZXhKpUG-NgIJk@z>

Consequently to the unified vDSO transition of the MIPS architecture few
compilation issues appeared due to:
 - A wrong source path for the configuration environment settings for
   the O32 and N32 vDSO library generation.
 - A flip/flop vDSO building bug that would cause to rebuild the vDSO
   library every second time.

This patch series addresses both the issues providing the respective
fixes.

This patchset is rebased on top of mips-next.

Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (2):
  mips: vdso: Fix source path
  mips: vdso: Fix flip/flop vdso building bug

 arch/mips/vdso/Makefile | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.22.0
