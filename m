Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575960;
	b=E5wobEVBHUgJ6PYPoFYa7ApzVKg6rzuAUUYv1sowSxIWGIOI4IYkbXnAY61gYMD4odks
	 9+JC4T5HRm88X9655KIlUO5fCrdJpKqdGV3H0UIdgDnY3zBKNcnQ7sFkv+iFRnCMdcF4m
	 DB80EUMn72ziY9gy3MYS0arNUDP4gKKcxpGD5B4rYw+OlnlkQyEQrQmr3EyRBeVSuRn0R
	 xeuNMMfTjBJToQkN8OA+aZE29iFjE+E4PGXkIOW3ET9lrywrjx+0rcAObd+GsDN0AzToS
	 LOE8DWica8VgL0GLLDlC9XgLnoBjmXszMjknAFtwTLyh8wgXf5Auz02gOh0ZrqkePqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575960;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uKCrPR60jaWb2Zhk534ZCZD0Kw22aJy6wHHdu9KIW1I=;
	b=zXDPfj5mk5nFrs9PbSNGudQamiODQsBXStLRlPNwMpmgp91pp3n4fULEipbOPzL4w6+u
	 snQAe7mJHzCQuxB03E/RGDp5TDGkGvt57oncTgaz+4OgX10VH/jwVZhsw5smBMwRDfQ31
	 stZadGSDNqHHs9b0BAiSYT2BBtjZBEDu68SMJF7IYeU4SqOtByDJzIrhvWxB8Iu77rDwi
	 5MQdeVNG4xuFq/YOu9IeiLCU8VUUqcTeQ7y/vAkd2WmtzHajqc76MF5xgQyTOF9daRdue
	 HD9FVwe1pZ3LhgDffHksOYNFnZ9bqcFHY6OEdX4Uqdhgb32zDLVplSsTmTdHYjCsHXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="ZKjZ1/DZ";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828B606BC26;
	Fri, 13 Nov 2026 13:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4828B606BC26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ZKjZ1/DZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575951;
	bh=uKCrPR60jaWb2Zhk534ZCZD0Kw22aJy6wHHdu9KIW1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKjZ1/DZ+BbeqkXr02agu+P8pZdpihHKuQ0XAT1QoQwv8CcTezyVrjKPoNObytxzg
	 ns09pwr2kdmkE3cdfcO60ogsBCpDXvl3CTO+i5kEh8WsasY9QeuWFW4r9+IBTX3c7o
	 /gthaseC16IfnekPSSS9mO0ZQKu+j2xBewoW1tMjb4uSQSHhiW9JJu/weuCT0PjpK3
	 rYOVYQuuQK29EbONku9W21tZ9NTcyx1UAUzi4/f/vQKf5yAXXYzSsAktQAPAHe9Swl
	 r86jY3miUpVYBwYe2XD6xMO9kvo3JTK+G24t7AYcCvdlG7y2pJtCPY0dAqoiChFvVE
	 4cEP7H5ydYEIg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWz3y7FzQ2m;
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
Subject: [RFC PATCH 12/16] x86/entry: Remove stale membarrier sync core comments
Date: Fri, 13 Nov 2026 08:18:59 -0500
Message-Id: <20261113131903.157186-13-mathieu.desnoyers@efficios.com>
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

Two comments state that the membarrier sync core command relies on
the IRET which returns from the IPI handler. This is no longer true
since commit a493d1ca1a03 ("x86/membarrier: Get rid of a dubious
optimization"): sync_core_before_usermode() serializes the core in
the IPI handler.

Remove both comments.

The comment of sync_core_before_usermode() lists the instructions
which return to user-space without serializing the core. Fix a typo
in it ("sysrel") and add ERETU, which FRED uses.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 arch/x86/entry/entry_32.S        | 5 -----
 arch/x86/entry/entry_64.S        | 4 ----
 arch/x86/include/asm/sync_core.h | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 92c0b4a94e0a..d47bb08afb24 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -954,11 +954,6 @@ restore_all_switch_stack:
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
 	CLEAR_CPU_BUFFERS
 .Lirq_return:
-	/*
-	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
-	 * when returning from IPI handler and when returning from
-	 * scheduler to user-space.
-	 */
 	iret
 
 .Lasm_iret_error:
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 253f0a585927..b8661064232c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -626,10 +626,6 @@ SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 #endif
 	POP_REGS
 	addq	$8, %rsp	/* skip regs->orig_ax */
-	/*
-	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
-	 * when returning from IPI handler.
-	 */
 #ifdef CONFIG_XEN_PV
 SYM_INNER_LABEL(early_xen_iret_patch, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index df22113db9cd..0ab91f7e2020 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -91,7 +91,7 @@ static __always_inline void sync_core(void)
 /*
  * Ensure that a core serializing instruction is issued before returning
  * to user-mode. x86 implements return to user-space through sysexit,
- * sysrel, and sysretq, which are not core serializing.
+ * sysretl, sysretq and eretu, which are not core serializing.
  */
 static inline void sync_core_before_usermode(void)
 {
-- 
2.47.3

