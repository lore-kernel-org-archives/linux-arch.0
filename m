Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805907;
	b=q+tWfglGc5tsblezqznz9OMNwZ/zM30L4SEcgmTV1b/Bwjfv0/yS4MBgqNdhpd83w43y
	 5JfXKskHTm/slUjcGWFnzQPsGP+RSki/YptDldLknXbq6n79LBoBPc7PSCk+haZ6P+Mh6
	 ua6UHiD7zjGb0kTpq+LuejKypV7nYi8/6a/Z3O9+Dqe7pmjfYs6GbB/IjJTqwOvyZrEWX
	 ezxzuz4oc02sFIZ9kauZyd9BiFql2qYMCCXo7/tEGmV0Sa4BaXiUZzfRCzf1JwTo0ueQs
	 AWq/w8UzLDDMIJ4c2zUFltA+QAAUwEnyCSt+HasaVmSW7bWniUsdQfVtS4zVFhUzZlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805907;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rF8sHZW1cTd+n7KcEI4fz6GZGwqe6JLJYuwVImB7MOs=;
	b=q5diTy4N2TCLdjYQYqWDB1luikupItPqkLNHuCQkWhVSmICnfIBye9yXxgteZnPZRCmc
	 +9h2c6hgbS7+quRdIbtDh5AYGYEcE9r66ktkegM+eUWxZ20RN2HPqqovePmizjxvqm2Jx
	 t4duj/ZBswz7pGOQOPtgxjiqBx4q0CsKu7meECXkf/cDOUH8Adcm+E3eq0whKh50/YT9u
	 SRUP1JnFAzV3/KFLyBNZKGbso/GEdpXpd+0vIzm1D05tzhgm8jETNjOFc1rBj7Dx4rG9N
	 QmQedE+15eWiZ2Z32iEjk6P6r8z7KuWKrRRl2Zb1HRbBdqE+swwp/MH1sWP68QmVEPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=q4blEadq;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A04606A6A3;
	Fri, 27 Nov 2026 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0A04606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=q4blEadq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795805904;
	bh=rF8sHZW1cTd+n7KcEI4fz6GZGwqe6JLJYuwVImB7MOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4blEadqTvxKYWYF6QajeBr2d9uBZfo+WIzk4gpnujx/mHTrAjMe5mH3goY66EsGl
	 vfGdAsGfiQflDvHaxbmwHM+xlRM7c/INxYXF19V+sBVp1Fmhv6KuOGV/MKTRrSeaCS
	 xKC213z7s9QWX1WV+UkDOS22okkKbXWOIvIvsAuao33N7vKYXxssz9lyQlrtsrJ7Hx
	 UwzzhPermKdzZjFhlGDj8q+XK/U9i4oI+weBMdQGSGg+XUGOWKWviNKHwyFcS7Ke3S
	 tmGcQgRCsBZNGfHQ65QcH83g7QToF0o3i5Aqb3m5ld2dX+7ueLJxd7t1q5+6AVtXnY
	 gd5/eYFmUqLwA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbjNw68h6zXQN;
	Fri, 27 Nov 2026 13:58:24 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 10/16] Documentation/membarrier: Update the per-architecture barrier list
Date: Fri, 27 Nov 2026 13:58:15 -0500
Message-ID: <20261127185822.158216-11-mathieu.desnoyers@efficios.com>
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

