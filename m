Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575959;
	b=S8k8N/Asj1FYLhGnW9RmFECkIzQP/BTHQXaKUJuCDl9bZG1Ouat81uXXS7J1p7wCJnL+
	 Epnwj8mhhyoebf3t+uqtISGRMpIBuUgMwOT3GHS6tWtkZI8m8rasKk7l9S74Qw/UavEco
	 331B3TdpahipBciKOEUcpkzpzgALhCAF67l5fDwNouz9IkI0pzVTWoUkN+sxK86zqyR1i
	 O7ByUuTW9hfeKIUI8SKLNc4xhHjRW+Ukc55An5GlxVxTF2hLHdapXORErJfSZPPG8Sfol
	 2SLV48NALehntJ9AcM9wpGqHeNqp9kLtapKJnI3POJWrS9aaqnCzUr2piczPstmL58g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575959;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6kRCE4e9B1yAdG4N0ntHe8x6Dfjo7HptYTW2o7NmsLw=;
	b=CyKlwaszAMnjI8M5XjVNohhPXisQdgZ6yevoC8hNj0urQcfcc5heQCawfyLgyI76mv4L
	 uqBU45ThP8uMEia6NIvIzE/hoGctexEaoI42R9767ag6x2vzj7wO8R9sma78d6tk3KV3B
	 caJYOPcKSoB9iscZPlHL7e1umZKAx9T0Y2wspZhqpSu4bY8mu7GiAZUleKEcb48Wg/xaV
	 /8/I7nlc5+ofZTwEVLmSy11UC+CzKKLRDIj1XC8RNVwENzoihuInpUQzY5aayYZhvSm2V
	 vVz5A7ddEGkTPWb7rD7Npk1VgF7IetikPT0I2MZtuZNCisOyQW8xlQgZEmhiugH7IXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rXc0LWC5;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8F60A2604;
	Fri, 13 Nov 2026 13:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C8F60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rXc0LWC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575951;
	bh=6kRCE4e9B1yAdG4N0ntHe8x6Dfjo7HptYTW2o7NmsLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXc0LWC55m33lD2R0r5M3n76HjAex1pHw8WVeP9ZTm0ZhX1+MYDwsJIN0gfNK2UhW
	 TRR7QBdncW81mang3ROWagbQDWFPh38fmGx+Xhp+V8QoVSwRa1nPkTlOcIr5AeaGJZ
	 0KarrrJqY278HYhS13nTHDyfKcK5s1ZxOwgDoVE+dHlq/UDu4TkX+WuuryJR8jXNIq
	 S0O337gRdeP1p9eiWO89AeBPsQpRgble7/QlS4rO3hDJWIqsV8y/chXBRoV9UVDsue
	 4grM0bb2TyUs+fCHvavwyM6je6duJxKnC0GOeLqXDdPQT99AYTROVrBkQXsygqRNtt
	 LLVzbj4Bk5yfA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWz22Z0zQ2l;
	Fri, 13 Nov 2026 08:19:11 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Aniket Gattani <aniketgattani@google.com>,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Gellermann <christian.gellermann@codasip.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>,
	linux-parisc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-arch@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Lutomirski <luto@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	lkmm@lists.linux.dev,
	bpf@vger.kernel.org,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 11/16] Documentation/features: Update the membarrier sync core requirements
Date: Fri, 13 Nov 2026 08:18:58 -0500
Message-Id: <20261113131903.157186-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
References: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 text says that the return from interrupt uses IRET, which
serializes the core after the IPI. This is not what the code relies
on, and it is not always true:

 - Since commit a493d1ca1a03 ("x86/membarrier: Get rid of a dubious
   optimization"), the IPI handler issues a core serializing
   instruction right away. The interrupted thread can be rescheduled
   before the return from interrupt, and another thread of the mm can
   then return to user-space through SYSRET.

 - With FRED, the kernel returns through ERETS and ERETU. The Intel
   SDM does not list them as serializing instructions. It states that
   ERETU has the instruction ordering guarantees of SYSRET.
   The AMD APM does not describe these two instructions.

Describe what x86 relies on instead: sync_core_before_usermode() and
the writes to CR3.

On arm64 with FEAT_ExS, an exception return is a context
synchronization event only when SCTLR_ELx.EOS is set. The kernel sets
it. Document that the sync core command depends on it.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../membarrier-sync-core/arch-support.txt     | 35 +++++++++++++------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 7425d2b994a3..2782b0d25f43 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -10,6 +10,10 @@
 # Rely on implicit context synchronization as a result of exception return
 # when returning from IPI handler, and when returning to user-space.
 #
+# On arm64 with FEAT_ExS, an exception return is a context synchronization
+# event only when SCTLR_ELx.EOS is set. The kernel sets it, cf.
+# SCTLR_EL1_EOS in INIT_SCTLR_EL1_MMU_ON. It must stay set.
+#
 # * riscv
 #
 # riscv uses xRET as return from interrupt and to return to user-space.
@@ -28,19 +32,28 @@
 #
 # * x86
 #
-# x86-32 uses IRET as return from interrupt, which takes care of the IPI.
-# However, it uses both IRET and SYSEXIT to go back to user-space. The IRET
-# instruction is core serializing, but not SYSEXIT.
+# x86-32 returns to user-space through either IRET or SYSEXIT. x86-64 returns
+# to user-space through either SYSRETL (compat code), SYSRETQ or IRET, or
+# through ERETU when FRED is enabled. It returns from interrupt through IRET,
+# or through ERETS or ERETU when FRED is enabled.
+#
+# The IRET instruction is core serializing. SYSRET{L,Q}, SYSEXIT, ERETS and
+# ERETU are not. Therefore x86 does not rely on the return instruction:
+#
+#  - the IPI handler calls sync_core_before_usermode(), which issues a core
+#    serializing instruction right away (cf. ipi_sync_core()). The thread may
+#    otherwise be rescheduled before the return from interrupt, and a thread
+#    of the same mm may return to user-space through SYSRET,
+#
+#  - write_cr3() performed by switch_mm() provides core serialization after
+#    changing the current mm,
 #
-# x86-64 uses IRET as return from interrupt, which takes care of the IPI.
-# However, it can return to user-space through either SYSRETL (compat code),
-# SYSRETQ, or IRET.
+#  - the special case of kthread -> uthread (temporarily keeping current mm
+#    into active_mm) issues a sync_core_before_usermode().
 #
-# Given that neither SYSRET{L,Q}, nor SYSEXIT, are core serializing, we rely
-# instead on write_cr3() performed by switch_mm() to provide core serialization
-# after changing the current mm, and deal with the special case of kthread ->
-# uthread (temporarily keeping current mm into active_mm) by issuing a
-# sync_core_before_usermode() in that specific case.
+# With page table isolation, sync_core_before_usermode() does nothing: each
+# return to user-space writes to CR3, which is core serializing. Page table
+# isolation and FRED are mutually exclusive.
 #
     -----------------------
     |         arch |status|
-- 
2.47.3

