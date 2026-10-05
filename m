Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB94D90AE
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220554; cv=none; b=p2sqq+jMBL0hnBpts00FuKKcWFGu83a/uAxG5QzK5izhOcuI+MtcpWx72OhNw0EiNDd6QXLrIuzDFY/rSVkmwdcHORrrlMP5iD0Ex1adMYvHDI8ULWZ/jsnqw9wUnLFmZVubjCmUe1MPB/tzjxhralkB0WaS32QrWk9/GBAcHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220554; c=relaxed/simple;
	bh=b9wO8A8BJk0msRgDSSIm/zwSQ296F+LSttY983JHDrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOESS+MEbLRlbz7cJi4rXSFQLClK5yMqtz7wS0kmjOJR346i+1aGC1C+K/tmU+qXwZa2Gzt/Z8Z7gsg5U92WdFtxgqiCb/18ktkEZjRrbTf/TT4VBGOGXTGlntxBUyO0DqgIv1Um0YTlkwG/wobDlneJF8jZjgvJ9rq1NlqvKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xkj7PB6F; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkj7PB6F"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6f8525bfbso1320952a91.0
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220551; x=1791825351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=noJfd7OdedAOUSKXlipn0GwwH2nQ+S/hQ095hJ1+g44=;
        b=Xkj7PB6FQgCObIEEjhZ5PoTk6KLrWARsLMNyEAGOR8nolz1OUQxfAeMmkgn2tcIM6B
         DWibmJrwu8vAGli2G11Ry4vV9mktFvbs+4W7/BplQ2sYp89t20SyjSWVG+sGCUJzsPGI
         64fY1cvVh0i06PXy67Uso9rPaI0Ma/srj6G3XFN1jb1X+ZfbcFm17EK5rQSRPIJssdkl
         pkD3mZiEWtENknVtRqWoX6/NqKHHRZosCZTax58ZJ13pysfRT/r5YHGeVn3q6DUzSDjI
         yLjDgzexFrKV2OaThWATDg0IW7xvQkdduxBEgBMZSO9A/ngjy5Xx6oSh5HO3wzjxI2y0
         d8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220551; x=1791825351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noJfd7OdedAOUSKXlipn0GwwH2nQ+S/hQ095hJ1+g44=;
        b=vWLhwxN3KG9OErCI0R3Hfp5eyEtrYUtUaG8pOjAJlF7dcz77I7MpoGKCLnyaZIAGbX
         jZnCPQXTnfes28dehEDBRprTcjE9QrlmGUe+9vEdVD2olZu1OPR1p+WgrV2NgMUpG/x+
         KWClXG+5bmul77oKzYKpKgtlMWfdn+tSBKmcke+KlF6MawW5WY5QyI9Ctnr8XlIModyh
         d77L2UFGPLdTElsACkS7DVpKN+eoUEEdYH3t9DC6rpWo7Fydd6uDkEIMbDme5OfnmYgm
         Zdgze//E4nsgQrel04Fmgrhk91tWz/FKdl7Mc/GfM9faq5RCaAtQWnS8QaYXA93bR2a4
         MTig==
X-Forwarded-Encrypted: i=1; AKwUvByqTHLAHw8Lkc3xwgeP4u7iRO7nEe4HznLaFEoBpESsry1AKJnIMZh4nJEx+c9G1JZZC/oMy+mBS8ER@vger.kernel.org
X-Gm-Message-State: AFq9FYJxnaMstGMKndSE/ipbVVWTmXpft3K02tkLYqzDFzWVf3C4vkjw
	tOEv0eynokblX5gUrHKstVQHn1jVh2TJ+6jUIsd22pL0Z0Ry6VOPRYUR
X-Gm-Gg: AYBFou3Tq1u4HWsR49iZrm+VHmjtG/uuNH/MhKh0HRmw76Bx0jieSgRq9QM+a7aUpGD
	duM1z7hxKiAXTXlMeKAU4zZ539YkcYFtHukgKMqMCPoUNHXdgrbFzwBBZpo0Zp89/xZ0fHlxiju
	eWMsgyGD91hSZD54W/frjZH3eCoOa4T4odLHtWR7xKFDwNI2+BYgorZCmDa4GR/b7kQE4LfMnVG
	kOI4XpIB5ZvyA5o/BdZU4qcprc1erCUnpzxkm8f6gw1n60CUha2bYzac78WgcVCt23FeC1q9mlp
	Cs5/Aw1dWFM5D/u1BPJy1BorP2erqVoP40Iib4JVSeHJ3GKoyWiu/MilQ4jqrh/kaV96ku6P/r+
	+swI/GY1k+c1GCOA6Edkn+kiGvuNbtiR4QHIAqIR10LfoGKYU6ST+d6ron6E7S51jN2nslVz7ft
	VjZZvRetIaz+Cajrf0c2yaxD8DgR7nOv/E89q1+Qdy1JFlsCl9EhlZyRKFgbq+bvrk2z+Qa8hMe
	w4MyAuz6Y3wlPTVYnbp05HKXGicHQ==
X-Received: by 2002:a17:90b:5281:b0:3a4:a370:d888 with SMTP id 98e67ed59e1d1-3a6ceaf8df6mr4799154a91.20.1791220550549;
        Mon, 05 Oct 2026 10:15:50 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:15:50 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v3 00/15] hazptr: batch synchronize operations through a shared scan
Date: Tue,  6 Oct 2026 01:15:14 +0800
Message-ID: <20261005171529.1378809-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends Mathieu Desnoyers's hazard pointer implementation [1]
with a shared scan path for concurrent hazptr_synchronize() callers,
and adapts the lockdep dynamic-key hashlist use case from Boqun
Feng's 2025 shazptr series [2] to the current hazptr API.

The series also adds rcuscale support, torture coverage, and litmus
tests for the hazptr implementation.

The lockdep conversion replaces the expedited RCU wait in
lockdep_unregister_key() with hazptr_synchronize().  This limits
the wait to hazard pointers protecting the target hash bucket
instead of waiting for a system-wide expedited RCU grace period.

[1] https://lore.kernel.org/all/20260919000056.3132131-26-paulmck@kernel.org/
[2] https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/

Performance data
================

The measurements below were collected on an ARM64 KVM guest running
on an ARM64 server (96 vCPUs, 8 GB RAM), unless noted otherwise.
The kernel is based on Paul McKenney's -rcu tree "dev" branch at
commit d21906b0aa1e ("doc: Document additional RCU task-stall dump
information") with the full hazptr patch series applied.

CONFIG_PREEMPT=y, CONFIG_PREEMPT_RCU=y, CONFIG_NR_CPUS=256.
Configuration is saved alongside each result set.

Following Paul's suggestion, the reader-side refscale numbers are
reported separately for CONFIG_PROVE_LOCKING=n and
CONFIG_PROVE_LOCKING=y, since lockdep instrumentation significantly
affects the measured RCU and SRCU reader-side costs but has little
effect on the hazptr reader path in this setup.

Lockdep workload -- tc qdisc mq x100, CONFIG_PROVE_LOCKING=y,
96 background hazptr readers:

  function-call IPIs (100 tc qdisc operations):  183

For reference, insmod/rmmod x10 in the same setup generated 4930
function-call IPIs.

The lockdep_unregister_key() path is the motivating use case for
this series: it replaces a system-wide synchronize_rcu_expedited()
call with a hazptr_synchronize() scoped to the per-key hash bucket.

Writer-side effective per-GP time (rcuscale, nwriters=16, nreaders=0,
one run per CPU count; computed as total test duration divided by
the total number of grace periods across all writers):

                         hazptr      RCU         Tree SRCU
  CPUs                   per-GP      per-GP      per-GP
  -----------------------------------------------------------
   24                    498 us      863 us      632 us
   96                    493 us      865 us      599 us
  128                    493 us      873 us      789 us
  256                    500 us      1162 us     476 us

At 96 CPUs the measurements are from the comparison blocks in the
same guest boot (order: hazptr nw=16, hazptr nw=1, hazptr nw=16,
rcu nw=1, rcu nw=16, srcu nw=1, srcu nw=16).  The hazptr scalability
row uses the first hazptr nw=16 block, which is consistent with the
single per-CPU runs at 24, 128, and 256 CPUs.  RCU and Tree SRCU
use their standard implementations.

Hazptr effective per-GP time stays nearly constant from 24 to 256
CPUs, remaining within 493-500 us, consistent with the shared-scan
kthread amortising the scan across concurrent synchronize callers.
At 96 CPUs, the effective per-GP times are approximately 865 us for
RCU, 599 us for SRCU, and 493 us for hazptr with 16 concurrent
callers.

For comparison, the nwriters=1, nreaders=0 case measured about 19 us
per grace period in this run at 96 CPUs.

Reader-side overhead (refscale, nreaders=-1 for 75% of 96 online
CPUs, nruns=5, median of 5 runs per scale type):

  The lockdep=n and lockdep=y refscale numbers were collected in
  separate QEMU boots from kernels built from the same source tree
  with PROVE_LOCKING toggled.  The first hazptr block in each boot
  is used.  All 96 vCPUs were visible to the guest (CONFIG_NR_CPUS=256).

                   PROVE_LOCKING=n     PROVE_LOCKING=y
  hazptr           26.1 ns             25.6 ns
  RCU               5.0 ns            165.5 ns
  SRCU             38.8 ns            192.3 ns

Hazptr reader-side overhead is nearly unchanged with and without
CONFIG_PROVE_LOCKING in this setup, while RCU and SRCU show
substantially higher costs when lockdep is enabled.  This is why
the refscale results are reported separately for the two
configurations.

Hazptr torture regression (CONFIG_PROVE_LOCKING=y):
basic, lockdep+wq_churn, and SLOWPATH PASS at 96 CPUs;
CPU sweep (8/16/32/64/128/256) also PASS with no lockdep warnings.

Additional x86 server testing with Lian Wang is planned(maybe after
LPC).

Test reproducibility
---------------------

Across five refscale runs, the standard deviation was 0.16 ns for
hazptr and 0.12 ns for RCU with PROVE_LOCKING=n.  Rcuscale data
points are based on a single test run per CPU count, but each run
covers thousands of individual grace periods and the hazptr 
measurements remain within 493-500us across the tested CPU counts.
The lockdep workload measurement uses 100 tc qdisc operations in 
a single QEMU boot; repeated runs agree to within ~10 IPIs on 
this server.

Changes since v2
================

- v2: https://lore.kernel.org/all/20261002170847.3653663-1-kunwu.chan@gmail.com/

Only cover letter changes; no code changes since v2.

- Fixed attribution: the base hazptr implementation is Mathieu
  Desnoyers's work.

- Split the refscale reader-overhead table into separate
  PROVE_LOCKING=n and PROVE_LOCKING=y columns, following Paul's
  suggestion, so that the lockdep impact on RCU and SRCU fast
  paths is visible rather than folded into a single number.

- Replaced the rcuscale "per-writer latency" column with
  per-grace-period values.  The new metric (total test duration
  divided by total grace periods) is more directly interpretable
  when comparing 1-vs-16 concurrent synchronize callers.  The
  nw=16 comparison now uses the same rcuscale test block for
  hazptr, RCU, and SRCU at each CPU count.  The nw=1 baseline
  is provided for reference so that the reader can see the single-
  writer cost and the per-GP cost under 16 concurrent callers side
  by side.

- Added test-condition and reproducibility notes (kernel commit,
  PREEMPT model, visible CPU count, boot ordering, standard
  deviation, sample sizes).

- Removed the unreviewed srcua scale-type patch from this series;
  it will be posted separately.

Changes since RFC/WIP
=====================

- RFC/WIP: https://lore.kernel.org/all/20260922070950.4173245-1-kunwu.chan@gmail.com/

- Split the original 4-patch RFC/WIP into smaller commits covering
  shared scanning, correctness, API support, lockdep, scaling, and
  torture testing.

- Incorporated Boqun Feng's review feedback: use a Bloom filter to
  avoid per-waiter allocation, add scoped_guard() support, and add
  a debug option to force the hazptr acquire slow path.

- Fixed scan ordering around backup-slot promotion by scanning all
  per-CPU slots before the overflow lists, with a separate
  overflow-list phase.

- Simplified the scan cycle to flip first and drain only the old
  wildcard generation, with herd7-verified LKMM tests for both the
  in-flight and resolved publication cases.

- Extended rcuscale and hazptrtorture coverage, added a selftest
  script for the torture configurations, and fixed the
  hazptr_release() kernel-doc.


Kunwu Chan (15):
  hazptr: add shared scan kthread
  hazptr: use Bloom filter for shared scan waiters
  hazptr: scan all per-CPU slots before overflow lists
  hazptr: add scoped_guard() support
  hazptr: add debug option to force the acquire slow path
  hazptr: elide redundant first drain pass
  Documentation/litmus-tests: add hazptr wildcard-flip escape test
  locking/lockdep: use hazptr to wait for dynamic key lookups
  rcuscale: add hazptr scale type
  hazptr: fix kernel-doc of hazptr_release()
  Documentation/litmus-tests: add hazptr acquire-before-scan test
  hazptrtorture: add slowpath and lockdep scenarios
  hazptrtorture: add READERS4 and READERS0 torture configs
  hazptrtorture: add 128- and 256-CPU configs
  selftests/rcutorture: add hazptr torture test script

 Documentation/litmus-tests/README             |  13 +
 .../hazptr/hazptr-acquire-before-scan.litmus  |  45 +++
 .../hazptr/hazptr-wildcard-flip-escape.litmus |  46 +++
 include/linux/hazptr.h                        |  56 ++-
 kernel/hazptr.c                               | 336 +++++++++++++++++-
 kernel/locking/lockdep.c                      |  25 +-
 kernel/rcu/Kconfig.debug                      |  10 +
 kernel/rcu/hazptrtorture.c                    |  57 ++-
 kernel/rcu/rcuscale.c                         |  70 +++-
 .../selftests/rcutorture/bin/hazptr.sh        | 146 ++++++++
 .../rcutorture/configs/hazptr/CFLIST          |   6 +
 .../rcutorture/configs/hazptr/CPU128          |  16 +
 .../rcutorture/configs/hazptr/CPU128.boot     |   1 +
 .../rcutorture/configs/hazptr/CPU256          |  16 +
 .../rcutorture/configs/hazptr/CPU256.boot     |   1 +
 .../rcutorture/configs/hazptr/LOCKDEP         |  17 +
 .../rcutorture/configs/hazptr/LOCKDEP.boot    |   1 +
 .../rcutorture/configs/hazptr/READERS0        |  16 +
 .../rcutorture/configs/hazptr/READERS0.boot   |   2 +
 .../rcutorture/configs/hazptr/READERS4        |  16 +
 .../rcutorture/configs/hazptr/READERS4.boot   |   2 +
 .../rcutorture/configs/hazptr/SLOWPATH        |  16 +
 22 files changed, 881 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
 create mode 100755 tools/testing/selftests/rcutorture/bin/hazptr.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH

base-commit: d21906b0aa1e9573cdb5e7acaca44966b9d1dcd2
-- 
2.43.0

