Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:45280 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729320AbfAHVUB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jan 2019 16:20:01 -0500
From: Yuri Norov <ynorov@marvell.com>
Subject: [PATCH] arm64: introduce AUDIT_ARCH_AARCH64ILP32 for ilp32
Date: Tue, 8 Jan 2019 21:18:56 +0000
Message-ID: <20190108211840.GA13838@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20190107155028.GA25178@yury-thinkpad>
In-Reply-To: <20190107155028.GA25178@yury-thinkpad>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECFB331D797AC1488D832907AB4C052F@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Andreas Schwab <schwab@suse.de>, Andrew Pinski <pinskia@gmail.com>, Bamvor Zhangjian <bamv2005@gmail.com>, Chris Metcalf <cmetcalf@mellanox.com>, Christoph Muellner <christoph.muellner@theobroma-systems.com>, Dave Martin <Dave.Martin@arm.com>, "David S . Miller" <davem@davemloft.net>, Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, James Morse <james.morse@arm.com>, Joseph Myers <joseph@codesourcery.com>, Lin Yongting <linyongting@huawei.com>, Manuel Montezelo <manuel.montezelo@gmail.com>, Mark Brown <broonie@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Steve Ellcey <sellcey@caviumnetworks.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, "yury.norov@gmail.com" <yury.norov@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Message-ID: <20190108211856.1VHXuU2bt9SPZKxs3VAKW_lEZLUO7R8gmdN6xGSQJWc@z>

Make syscall_get_arch() distinguish arm64 and arm64/ilp32 by adding
AUDIT_ARCH_AARCH64ILP32.

Sugested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 arch/arm64/include/asm/syscall.h | 3 +++
 include/uapi/linux/audit.h       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/sysc=
all.h
index 73fbe08763b0..77578d703cb1 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -126,6 +126,9 @@ static inline int syscall_get_arch(void)
 	if (is_a32_compat_task())
 		return AUDIT_ARCH_ARM;
=20
+	if (is_ilp32_compat_task())
+		return AUDIT_ARCH_AARCH64ILP32;
+
 	return AUDIT_ARCH_AARCH64;
 }
=20
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 818ae690ab79..624127147404 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -374,6 +374,7 @@ enum {
 #define __AUDIT_ARCH_LE	   0x40000000
=20
 #define AUDIT_ARCH_AARCH64	(EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_AARCH64ILP32	(EM_AARCH64|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ALPHA	(EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARM		(EM_ARM|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_ARMEB	(EM_ARM)
--=20
2.17.1
