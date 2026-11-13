Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575958;
	b=3Nw9RKyAaXDQQsWiamnKB50S2Gak2nWuDmR7YP8RhVN4MYQBQ78zUEazqJk2LRXewtte
	 BGpABWGlSOZas+OOtQ112bch6xHt6DCXvvCGbPgQPkuFCR9bdM7pQRYo/So/ykTznfsGE
	 Qi+UCUo79Yv594J5uqHGv59LkvU8BvQ+kPjauKC4QtioRNpNIGU8ZneLw6KtWCRGXQEsS
	 li13yAoLH2+yv9RjNeY1yTq5locHfXhbFKSbCPJAjTudRHYUY4cUJXEb7NPiu4F6qHLc2
	 nRbmJ3N2497b39uwi1lmyTHiBRl0ZRDGxiVOm+gEft0iO+xPJ6d8+xxwAhaprG8hurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575958;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IUEMjQyKvdg75ReLfe0GUIqEXU/84tt1/W6uEXFVIFk=;
	b=QN5KBwgtxvjSjoBPqbwTOtL9ovuN0XOmpNm54TjuuVvG4gCNv8YdK78+XinXx7hXxces
	 yFVh3ZZmlF4IkIO/cnlYC7VTERM/K+Cx/D+QnWFcMGlxPD2YXE87+iPvVT/kmMUedwgu8
	 D/FJOIJiRvE1DicVPjYjKVdOI1x/Qgx7c7QIFpnhJzJ7mHmFNzA2sYK907C6dftj+0cej
	 8I7CmR2i1U5UF/tyeO8sRbimpmcQiLG1TfLdUxv21CmqDF6PxLXHVI56Z2apy0aJwsnw6
	 BhONLgtHFDrlU31RiLTec5MxRlngxrF5b5d+if9IT08QsehzRM8zUD4Ejrq1QXUlsUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=dSDjxoaJ;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9C60A263A;
	Fri, 13 Nov 2026 13:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B9C60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=dSDjxoaJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575949;
	bh=IUEMjQyKvdg75ReLfe0GUIqEXU/84tt1/W6uEXFVIFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSDjxoaJDUtaYxgBtv1axfv9TiwhU3Kz4TiFYqtzCcvUt4wk1OfNjGMVl2MOLGXtO
	 KpvFCgxE7HHsgfIZ4T2z3dCLqZwa4/1o0xn3QzEIb4ZKovuHEEGdAFCge26ASjLeko
	 pvf1pZAhPXsjEkfmWwhEdsUU0AQJSWb0K3IRL1/1kQzAEzESW+6GY/yDpdrPTPlxlQ
	 oqrMII91zxG1FCdb1zsPSgICx8HwZ6lkKzy5FynmnUU/IYMR+ghV6LVAa4Eou3wZzF
	 +wlkSRBsq6uj4ojKGkiqMGQ91+G7HkLV+4xYqTgh/AKWbEBPiZs0na/xgBUFOiIdFy
	 BRHjuuWfVaXHg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWx53cRzPxL;
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
Subject: [RFC PATCH 05/16] selftests/membarrier: Run the tests on nohz_full kernels
Date: Fri, 13 Nov 2026 08:18:52 -0500
Message-Id: <20261113131903.157186-6-mathieu.desnoyers@efficios.com>
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

A nohz_full kernel does not provide MEMBARRIER_CMD_GLOBAL. The tests
skip everything when the query mask lacks this command. The other
commands are available on such a kernel and are never tested there.

Skip only the MEMBARRIER_CMD_GLOBAL test.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../selftests/membarrier/membarrier_test_impl.h        | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index 4b9d1771916e..49f5fdb56dab 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -97,6 +97,13 @@ static int test_membarrier_global_success(void)
 	int cmd = MEMBARRIER_CMD_GLOBAL, flags = 0;
 	const char *test_name = "sys membarrier MEMBARRIER_CMD_GLOBAL";
 
+	/* A nohz_full kernel does not provide MEMBARRIER_CMD_GLOBAL. */
+	if (!(sys_membarrier(MEMBARRIER_CMD_QUERY, 0) & cmd)) {
+		ksft_test_result_skip("%s test: Command not available\n",
+				      test_name);
+		return 0;
+	}
+
 	if (sys_membarrier(cmd, flags) != 0) {
 		ksft_exit_fail_msg(
 			"%s test: flags = %d, errno = %d\n",
@@ -356,9 +363,6 @@ static int test_membarrier_query(void)
 		}
 		ksft_exit_fail_msg("sys_membarrier() failed\n");
 	}
-	if (!(ret & MEMBARRIER_CMD_GLOBAL))
-		ksft_exit_skip(
-			"sys_membarrier unsupported: CMD_GLOBAL not found.\n");
 
 	ksft_test_result_pass("sys_membarrier available\n");
 	return 0;
-- 
2.47.3

