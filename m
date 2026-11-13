Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575959;
	b=Iq8Y/HxWV4aeoHlMTLtxmM83GaPU6yex3p4whP0GXUKs8B102sinHxch+vuNXCT/uYnK
	 RpLrVbq/uM9LFo2TWx01gz4zOEo+Z36X5ytwDGW5/NlGsZkRJLHnB3YT4cmV3aBezKAkY
	 +7YysYq/izZ86+bd3h9HKCV8TO0HwWUNZzBjXfKodp/6ibCpXM0SVltwioXwQ5/a4ENVy
	 QmenOjpbvb1OHM9BBBx+1C90RgGb9dOBG3CFn8i1CtwA8ZBgm5ziPBpKXBSZWcMAfvFMV
	 7dCJa/4kaYb3H54gu0vc21pTdI8QV1oA5NFj10pQLO+vznOefW7BUDb11RT6AOrV8NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575959;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rF8sHZW1cTd+n7KcEI4fz6GZGwqe6JLJYuwVImB7MOs=;
	b=WUu/PErKJsITwxYhPiOZskwIgpQ4aDZ6oeXzy8I4fkRYrb7JTOsvmtisBkel+BzrRQg7
	 CCznAPSbrCXMzzMxL36LSbqo9mYqHn6WJQhv08Vj6ARLmha3WfjdC9Q2I8MpdNCHV+9YX
	 0RrRN2qdeTjTJXBpfLVf0XD7vq2iO6hChfXRqhktEMvrl1Xl83loZ3HgNFV9P8GwpsNnM
	 2eEwAvhK7lZ+YEdm8oHcS3LhbzyxpNJh8QL+v4s28vmth5wLuP9FhVmYcTV46GsHcXtRy
	 li+P1CQLFhTWJvvon5vuN0urZkD7xcD5EQGSnqOzYKgry+7QDx35GAPIkalepdQF9eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="ke/WldX3";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51A60A3833;
	Fri, 13 Nov 2026 13:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE51A60A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ke/WldX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575951;
	bh=rF8sHZW1cTd+n7KcEI4fz6GZGwqe6JLJYuwVImB7MOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ke/WldX3JBgxKcwhYBb3NTyi/mUvQ9ZayfSipdAFZc8OgdnL8D0WmUuxiHAcl8Zee
	 bFTp2OfOxExpfd0RtnJpw41k2jY6AInGEyd03eZqQ/DZv4AlV1FBy+XC5DKrndK0Db
	 Wi2AJkE1kO9d9JhYHs2eh/oiRoiCgfz3PBac1PLEYh38VgVO3oEFl31sppyj0y+1Q0
	 lVvMfSJvX1Ma55UDCcyOz6RoLpxwCsP3dRIbJ4iLFdpjMhk1AqkzCHp2sW7e1szloA
	 q6TBmCvblSnU04VymINRWRm2J84VnBJnbKc1aeCV0xBfRiAEa2lWv60nniww+z9eez
	 l0Udy70JVCr7g==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWz0DbJzPtq;
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
Subject: [RFC PATCH 10/16] Documentation/membarrier: Update the per-architecture barrier list
Date: Fri, 13 Nov 2026 08:18:57 -0500
Message-Id: <20261113131903.157186-11-mathieu.desnoyers@efficios.com>
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

membarrier.rst lists how each architecture provides the full memory
barrier after the store to rq->curr. The list misses several SMP
architectures.

Add csky, openrisc, sh and xtensa. They use the generic
smp_store_release(). It issues smp_mb() before the store.
finish_task() uses it.

LoongArch and parisc now provide the barrier with
membarrier_arch_switch_mm(). Add them next to powerpc and riscv.

State the rule which both broke: an architecture which weakens
smp_store_release() or spin_unlock() must provide the barrier another
way.

Update the matching comment in __schedule().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Documentation/scheduler/membarrier.rst | 14 ++++++++++----
 kernel/sched/core.c                    | 10 ++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/membarrier.rst b/Documentation/scheduler/membarrier.rst
index 2387804b1c63..c5f6f4f57331 100644
--- a/Documentation/scheduler/membarrier.rst
+++ b/Documentation/scheduler/membarrier.rst
@@ -28,12 +28,18 @@ architectures are as follows.
  - alpha, arc, arm, hexagon, mips rely on the full barrier implied by
    spin_unlock() in finish_lock_switch().
 
+ - csky, openrisc, sh, xtensa rely on the generic smp_store_release(),
+   which issues a full barrier before the store.  finish_task() uses it.
+
  - arm64 relies on the full barrier implied by switch_to().
 
- - powerpc, riscv, s390, sparc, x86 rely on the full barrier implied by
-   switch_mm(), if mm is not NULL; they rely on the full barrier implied
-   by mmdrop(), otherwise.  On powerpc and riscv, switch_mm() relies on
-   membarrier_arch_switch_mm().
+ - loongarch, parisc, powerpc, riscv, s390, sparc, x86 rely on the full
+   barrier implied by switch_mm(), if mm is not NULL; they rely on the full
+   barrier implied by mmdrop(), otherwise.  On loongarch, parisc, powerpc and
+   riscv, switch_mm() relies on membarrier_arch_switch_mm().
+
+An architecture which overrides smp_store_release() or spin_unlock() with
+something weaker than a full barrier must provide this barrier another way.
 
 The barrier matches a full barrier in the proximity of the membarrier system call
 entry, cf. membarrier_{private,global}_expedited().
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index df6d15cf7109..9985c95ecd73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7367,10 +7367,12 @@ static void __sched notrace __schedule(int sched_mode)
 		 * Here are the schemes providing that barrier on the
 		 * various architectures:
 		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC,
-		 *   RISC-V.  switch_mm() relies on membarrier_arch_switch_mm()
-		 *   on PowerPC and on RISC-V.
-		 * - finish_lock_switch() for weakly-ordered
-		 *   architectures where spin_unlock is a full barrier,
+		 *   RISC-V, LoongArch, PA-RISC.  switch_mm() relies on
+		 *   membarrier_arch_switch_mm() on PowerPC, RISC-V,
+		 *   LoongArch and PA-RISC.
+		 * - finish_task() and finish_lock_switch() for weakly-ordered
+		 *   architectures where smp_store_release() or spin_unlock
+		 *   is a full barrier,
 		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
 		 *   is a RELEASE barrier),
 		 *
-- 
2.47.3

