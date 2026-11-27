Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805907;
	b=HBDUGzEMe3iw7etkWTPnYTl2fLxNU4uCT4RVQwg2xz+Xo8eFSoT+Vh25K07Jd5j/sItC
	 UMicEu9qjsLiPuaGihaAGL32qNkp3imf+HWX3G3md9wmEy5J87/ASYhhLUStTEDKwjsdN
	 8QgT1gT5pmCNU3DgkYyALASlXU8ZeLGm2kJsFQQ8EgZSebqUHN21PiAOn66pIDEsaE6Eu
	 ZP8qKil5q9lTu+Uo1TPB1VlzcMpjNCjO/O4OiJKbDv69FBfdv7hZvsYtWR6ErKY9M+VF+
	 HHZ/OCEjA9VCMVEfOBVcoGOJPEiWguF/mDkyLhzZDMIBYGz9WmTwpi1qIdYKHBtoF5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805907;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6kRCE4e9B1yAdG4N0ntHe8x6Dfjo7HptYTW2o7NmsLw=;
	b=yLFfCVUE8oTV1cRqcmOqGiO9BHdh7xbZkZgH6tLV+hS35/rl8/NSd4wWU6kI04YQJDYS
	 Ykg6TX4SqPwU5vJVwdf7XCvErNjVb03AatMibBCHWbLGkGz2H4fFop76ZconQPlXLFOeK
	 4dSV++ZiVVES11bSRnx2eVerfC54mv5Cf08NmRfIudSAKn4Y8JalNiEpcR8ekUdUjyXSX
	 uZkTqoDxIWpxvng4PB9ce5pytj5yFU9OZsgDuwIBYL4C0iFWs+wUMvrEG16Lbg8Ya/Aww
	 cM3P/3DYgBmME+tjcSESxI2Sj0dFXcP8rbUYWRMv+UEfeGR3VdlTjNWfnMtk8Gh9YYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rL8GBQQS;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB895606A696;
	Fri, 27 Nov 2026 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB895606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=rL8GBQQS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795805905;
	bh=6kRCE4e9B1yAdG4N0ntHe8x6Dfjo7HptYTW2o7NmsLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rL8GBQQSZjalsn/InH7Bc1MLMqUaDyz2qxXxFvsPdenZHQPpjgSZefwOfT6xqrBro
	 sx1aV/sEKfVyzGA5YeOzMrdVMfMNm4Ne/4FJHM9FOe1qdHYENl8bRsUkLUezNp0asq
	 QGEVnUoNwbFdwTyXbckAd6MPX/2ge5KKAjyDpNbdfeQHvQRp7iU3pTnfkA1/36af+Q
	 bzyTCiO8/oxl36QoaEIfcPbUkZnmeLNTjmcBDjBAmiwidN9o0jAIJD6vCJgcvuXfdL
	 Cxe3HiXcCJBI44VahI72vNA0IwGjatFQt41hEuKn8+rxGiyB9fUJbgK/Bz9sgTNkVP
	 temPGQlzAVaKw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbjNx0KdszXX0;
	Fri, 27 Nov 2026 13:58:25 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/16] Documentation/features: Update the membarrier sync core requirements
Date: Fri, 27 Nov 2026 13:58:16 -0500
Message-ID: <20261127185822.158216-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
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

