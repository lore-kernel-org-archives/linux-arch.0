From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 03/28] kernel: Add International Atomic Time support
Date: Thu, 29 Nov 2018 17:05:05 +0000
Message-ID: <20181129170530.37789-4-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

Currently, datapage.h has no support for CLOCK_TAI.
CLOCK_TAI is similar to CLOCK_REALTIME, but uses the International
Atomic Time (TAI) reference instead of UTC to avoid jumping on leap
second updates.

This patch adds CLOCK_TAI (tai_sec) support to datapage.h.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/datapage.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 52189c21d422..d50a108afaed 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -33,6 +33,7 @@ struct vdso_data {
 	__u64 wtm_clock_sec;	/* Wall to monotonic time */
 	__u64 wtm_clock_nsec;
 	__u64 btm_nsec;		/* Monotonic to boot time */
+	__u64 tai_sec;		/* International Atomic Time */
 	__u32 tb_seq_count;	/* Timebase sequence counter */
 	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
 	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
-- 
2.19.2
