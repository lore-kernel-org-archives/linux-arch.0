Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575958;
	b=d0SV9sY3QE4U8DiqrA7xZL1Cn7a211oJ7CzLPgO08h4Ikx1t6/Hw8CHbRGLfrEJzibK6
	 iDCTB7J96ijSSk9ya3G6HNo1BHmtJzDioCbnyrUxSBIk0CqY65zKvsmFezNs0VcvfRhSq
	 9rx4qMrb1nYbzK0egW3Qk69mFEs8h0P+DHUkB1dryLlVXEGLDbWB6wO5Ctc+OlNVLmTuT
	 ckksJCfLz0cvvyOR01rMQcQ6boajoTagZhehRvW+km5TrLJQq5Cn8bT8M8dYAGoBMp0d+
	 PLeJAJku/UcCOtTcC2/YYLJF2FFVSHhSw2hWNo4t64vq7Et2Q/Toc5QdtQ/SbnYbrjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575958;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fqjA7d9oxPlvdGR3cNqFBxqIEuFEPoAWBVhZCbSck08=;
	b=M9uqzbUMDF0eJXP0WWgnxdYThtwkFx1mKGyKnd6hLWic8vlUdKXkC3IGyhUQGKz+TIqW
	 csl/xYBVBaQaDhASxetbKaceNdksuYWDDjJu4I+Rxw0BKlmAQOgUzTmJz79V2oYPPuI5n
	 jOM5RZ6rAU8gjqLX6Z+2ZfpeX8tQCjwxrBuIqOGZvqcOo9S9C3clmV0OAdRjbBhfBF5uQ
	 1lPNCDw3nquVjMfVKpx1nvqKaf2mqlJ51DZOTZRwCNCqGauilIckqOE4VUMdMDZGSAayB
	 kkfj2myEDdWmNW/tVNZbdMh6IptXNyt+LbvC2ytQvrNZqjL4OxKUld3BeD1u7K3r0zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=s6kK13es;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85B60A262B;
	Fri, 13 Nov 2026 13:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D85B60A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=s6kK13es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575949;
	bh=fqjA7d9oxPlvdGR3cNqFBxqIEuFEPoAWBVhZCbSck08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6kK13esQe/3Dn823GifDE9YUBWlaKce/VmCWiLQ321jSAlDZzngdBqaA7Z1qxE5C
	 1whHJR1cZuzdUENomlJDksKPvI8B8+TKPbapRpahpsvcVZ34+5mnagsV1VplU/jlFp
	 5OOWfMg8+VBVCs9eVc+brs/jfyKM976DDqW7G5I5ZhFG3+GWQz5t9lYT0zMzjU+oTj
	 wud8MxwH1cCwX3De6qSdGsLiraDSdF9rp2pE0dvf/M5yJmuCc10gg+fym24Og6+mpp
	 jj72LqbVMYZfYph9MOs3pAzIRK+wwJvE/bNawaS0fVmndeXcbCHtRy4z0jrI+uiuTD
	 tyVxSGVFPUbDA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWx19bkzPtp;
	Fri, 13 Nov 2026 08:19:09 -0500 (EST)
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
Subject: [RFC PATCH 03/16] selftests/membarrier: Rebuild the tests when their header changes
Date: Fri, 13 Nov 2026 08:18:50 -0500
Message-Id: <20261113131903.157186-4-mathieu.desnoyers@efficios.com>
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

membarrier_test_impl.h holds the test code of
membarrier_test_single_thread and membarrier_test_multi_thread. The
Makefile does not list it as a prerequisite. A change to the header
does not rebuild the two tests, and a stale binary is run.

Add the header to LOCAL_HDRS. lib.mk makes each test depend on these
headers and keeps them out of the compiler command line.

Also add membarrier_rseq_stress to .gitignore.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/membarrier/.gitignore | 1 +
 tools/testing/selftests/membarrier/Makefile   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/membarrier/.gitignore b/tools/testing/selftests/membarrier/.gitignore
index f2fbba178601..031920478205 100644
--- a/tools/testing/selftests/membarrier/.gitignore
+++ b/tools/testing/selftests/membarrier/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 membarrier_test_multi_thread
 membarrier_test_single_thread
+membarrier_rseq_stress
diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
index 829f95c83515..20bb66380090 100644
--- a/tools/testing/selftests/membarrier/Makefile
+++ b/tools/testing/selftests/membarrier/Makefile
@@ -6,4 +6,6 @@ TEST_GEN_PROGS := membarrier_test_single_thread \
 		membarrier_test_multi_thread \
 		membarrier_rseq_stress
 
+LOCAL_HDRS += membarrier_test_impl.h
+
 include ../lib.mk
-- 
2.47.3

