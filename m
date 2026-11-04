Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811322;
	b=0yYwGsjXJ15vqxR3Jj/mVQG/dDFY5eS/VL1wsxZk6hdSj0zhawIiTh6mpLWD8ZaWQXe0
	 3ZiQF7lANeRRtmvSVXTkocE9Xmvmm97RlLIw83iL97ua4sMz+nKoZyDWV+zAjeIkdNfkd
	 uvmsAus7IL9AFle8c1EV+kTaUd5AqAYWpy2XjnpJXoqUOOAY/TkQkwJsVWlmJnKN0XA9I
	 n884XMjhDLtXNAWWzQStPT0nRJb8E1THjDp6gh3lbTWQQe4P5VcAoHw3IQqE5u081Mo5d
	 ipsPlKnDNf809izvCqAwq4HNRLGIhtY2vmekYDWEKXqVWxNVkPDU/PV5TdfM2ws/wGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yl/ZY+PDO6XN8izl21rZqNPkISM7G6L+Zw9AubDBAPI=;
	b=kg7zTAtJ0umcZAxgVfvwy8dySCcnnBGZhZK2iV6zENnSI8lCz8/qsFb/E1kfna1uGTD5
	 zMmXaz9WPxgyD/0JS9NNjJ9okyDj8ilcaj9SgG/qz3N7CVgPMfO9tCZXN0DB55Srtf0ZH
	 tkkbRwcuuLiAfy/LA8l7MDFYk3WJDBeX35A9vlWmu0G4I5o89IB7RQb1NcxHxLeftuguT
	 hzEJuXjkor39kNIhMLCnVXvLbv1tMi5Wf10J/P4MiFeZ2OUvu9S5q0pTFUq+nSvOjaWJy
	 +P+Am1wYNsMjQfBcOg7DXHpSbNgC00xuZQhh9XF2JuJ57mumlUqQFDSFXH0uoKmakzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1Uo3YzH;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB814606A31B
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB814606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1Uo3YzH
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a18fc7a38so2021486eec.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811321; x=1794416121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yl/ZY+PDO6XN8izl21rZqNPkISM7G6L+Zw9AubDBAPI=;
        b=t1Uo3YzHfzFIV1IqdOI0+CTfS3/LLL1zzTfILhiN2dI3fGeocV4xF1zkxa6GAm53f/
         jUvqjrfCG58n6WXoU8DF2B/8ptX32AZlSmw5Mn53WzFEi1hufbxBp3WHxjeEbKAOphit
         tvhJ3lMfkptQyM/I/upneewDjX3ZF95mWMj+m0KNTgu+mbXKuVh817/8IKqV5+Rv2FP0
         zzj674ByGh1Tk7hUE9ZL9ptUrG9SDF8htEAMOfUYJZy7+4Nz4woO/KJCId9qj5pKq4Fj
         5khJYeVjyRFmYTR29+Jdi2d693/P1mPXtMAaDD989eyt50RoZNpE4uW2Gnyt9GLCyJZk
         KhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811321; x=1794416121;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yl/ZY+PDO6XN8izl21rZqNPkISM7G6L+Zw9AubDBAPI=;
        b=ziwTu7lrQ8AYj33P0ql2uUkTZeuILbt5iMJO0pf18OgHWvtASgK2KuY3HGqebjIaRF
         w4rlTDjFgv6PXUN0fZPJkhqc9Fcw4EUCN9GeRnHC/xqHCdJ7QgUJErNCZX0V8dY7pzw5
         QmrnJrekpuWNJM7EssxkjYdWCSBaktMdLYb2NqXHHQMUXUvmOVZaFmeitmnfNuy8w6wE
         G/qN0+cmf/WBR7CEzLfDCTgjUM/H0ygvaVT6OuMQfZOpDe1AI5eW/NtzgERdWWzDTGKF
         pAwsLJrXORwReoN9Ldwa/2xAKtNA7meFC+kbqWe2SagGZzqrWYL+hudrFeuAciRYulrN
         mRYg==
X-Forwarded-Encrypted: i=1; AKwUvByWgYyMHiGlwXGrzOkqVb3hp0KqwR7S86mGR2scUsLKNfizqcvlKMX5BBYF5wjyp6x0YDE4J6PtOTfs@vger.kernel.org
X-Gm-Message-State: APuU4Z+s4PrHTOhj2Hd8cjXgLqhoyNva+hz0rab1N9XECH8m+X3zmW1Z
	j8TorJhhm9wug2FbSVHuPj6YpRlzgDCr7+CQB4jMhZevrMQToYudXb7s
X-Gm-Gg: AYBFou1ofKAO6nLjffrfESGVneXa3ZS6K75OsP5EP9ru+eIRZYfg2EHBW1rjrXdIdPZ
	oI29dkfE3R/bV0tP6olPYDxeXYo2ufhNfpBR5oLibup7ot9Ilh09PjZ9QlVmJQ//hW2PWp71ZWC
	lTu8KV66GRrr82grl32IG3MgNmB7go6JLNe2YT/mvVjbGeif+vgHQBXWY8pFuC1VEuJXiuyqLIL
	xnymPETNY1OiC1Fksst3DJ1hOSOjrFyBzkCGwfBIrlh0xsIrXb7H5NUNjFrpuYvID5PK2mUyuT9
	Pqr5asLIwUOHQ15jWHXPedirRqh1R0Qoc0EEzv/QWI4JiGikq7zaOai+hWz4qfDpZAhMT1MjIac
	ItWk8Ro2aQZKRILDAjecvW5n3zWEmEeW8lw9L6/a1h5WsuEV7wZh3hxOMYz+fvhEvvmbgVLuQgk
	aPCXyc9yc18bQbdWhuVseEHP8wlUzYb7cbc9FaQJvaqJ6GgXptie82dHHaB3cIVuieRvj81aiGe
	LBE0paCLRosez3xWDOqip3RhswXSej+ID56GftXQn5fukultbVkIPKObqYkOu6xAk8folkNBBuB
	yItdT9TD/7P5v1updmiAxI3ESOhJ+dIqwTcM0So=
X-Received: by 2002:a05:693c:6316:b0:369:fbc1:89c2 with SMTP id 5a478bee46e88-36a4235f4cemr24007502eec.8.1793811320020;
        Wed, 04 Nov 2026 08:55:20 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:55:19 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
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
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 00/28] hazptr: shared-scan kthread, drain-assist, and stall detector
Date: Thu,  5 Nov 2026 00:54:18 +0800
Message-ID: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds a shared-scan kthread to the hazard pointer
implementation so that concurrent hazptr_synchronize() callers share
a single Bloom-walk cycle instead of each busy-waiting on remote
slots.  It also adds a drain-assist mechanism for sticky-address
forward progress (the lockdep hash-bucket scenario raised by Lai
Jiangshan [1]) and a waiter stall detector modeled on the RCU CPU
stall detector.

Rebased onto origin/dev at 6e7df7157a91, which includes the
try_acquire fast path and Andrea Parri's hazptrtorture fixes
(shutdown hang, slot-owner race detection, nested acquire).

v3: https://lore.kernel.org/all/20261005171529.1378809-1-kunwu.chan@gmail.com/

1.  Drain-assist and forward progress
====================================

Lai Jiangshan pointed out [1] that the lockdep conversion, which
uses a permanently-reachable hash-bucket address as the
hazptr_synchronize() target, could starve: new lookups for
unrelated keys in the same bucket keep re-acquiring the address,
indefinitely blocking the waiter.

Drain-assist (CONFIG_HAZPTR_DRAIN_ASSIST, default y) addresses
this.  When a waiter has been blocked for 100+ scan cycles, the
kthread snapshots which per-CPU and overflow-list slots hold the
address: per-CPU slots are tracked via a bitmap, and each
overflow-list slot is marked with a drain generation counter
(drain_gen).  The reader cooperates on release by checking its
own slot's drain_gen, clearing it, and decrementing the
outstanding count.  The drain disengages when the bitmap is
empty and the count reaches zero.  A remove-only re-snapshot
recovers releases that happened during the engage walk, before
the drain address was published.

The mechanism is verified by:

  - Drain litmus tests (herd7 + linux-kernel.cfg).
  - HOTADDR: the same address is continuously re-published by
    hammer readers; the waiter completes after the hammer stops.
  - LONGHOLD: a legitimate 8-second hold with the stall timeout
    set to 2 s so the detector reports during the hold; the
    waiter completes after the holder releases.
  - FAIRNESS: two stuck addresses with two waiters; drain
    rotation confirmed (2 distinct addresses engaged, 3
    fairness-cap disengages, both waiters complete after
    release).

The drain-assist provides empirical forward progress, but does
not provide a formal starvation-freedom guarantee under
continuous reader traffic.

2.  Lockdep performance
=======================

The lockdep conversion (commit 20) replaces the system-wide
synchronize_rcu_expedited() in lockdep_unregister_key() with a
per-bucket hazptr_synchronize().  The motivation, following Boqun
Feng's shazptr series, is to eliminate the function-call IPI to
every online CPU per grace period.

Measured on 96 CPUs with PROVE_LOCKING=y and 96 background
hazptr readers: the wq_churn workload (workqueue create/destroy,
each exercising lockdep_unregister_key()) generates about 3
function-call IPIs per operation after subtracting the
scheduling baseline.  The previous system-wide
synchronize_rcu_expedited() path required an IPI to each of
the 96 online CPUs per grace period, so this represents
roughly a 30-fold reduction for this workload.

Writer-side grace-period cost (rcuscale, nwriters=16, nreaders=0;
effective per-GP = measuring-window duration divided by the total
number of grace periods, from the module's summary line; ARM64
KVM; the per-GP figure is an aggregate throughput metric, not
a per-call latency):

               24 CPU      96 CPU      128 CPU     256 CPU
  hazptr        526 us       528 us       526 us       526 us
  RCU          2650 us       928 us      3836 us      4230 us
  SRCU          450 us       639 us      2352 us       706 us

The comparison uses hazptr_synchronize(), synchronize_rcu(),
and synchronize_srcu(), respectively.  Hazptr per-GP cost
remains nearly constant across the tested CPU counts.  RCU and
SRCU grace-period costs show larger variations across the
tested CPU counts in this QEMU ARM64 environment; these
results are from individual runs.

This matches the v3 numbers (493-500 us for hazptr, 865 us for RCU,
599 us for SRCU at 96 CPUs) within run-to-run variance: the shared
scan kthread preserves the aggregate throughput of the v3
per-waiter-scan protocol in this workload.  An individual hazptr_synchronize() call
under this 16-writer load takes about 8 ms because a single scan
cycle serves all concurrent waiters.

Reader overhead (refscale, nreaders=-1, nruns=5, median, ARM64 KVM):

               PROVE_LOCKING=n    PROVE_LOCKING=y
  hazptr       22.2 ns            22.2 ns
  RCU           4.8 ns          147.6 ns
  SRCU         36.4 ns          163.8 ns

Hazptr reader overhead is unaffected by PROVE_LOCKING (22.2 ns
with and without).  Without PROVE_LOCKING, RCU has lower
reader overhead than hazptr.  With PROVE_LOCKING enabled,
while RCU and SRCU readers are heavily
instrumented: RCU degrades 31x (4.8 ns to 147.6 ns) and SRCU
degrades 4.5x (36.4 ns to 163.8 ns).  With PROVE_LOCKING enabled,
the hazptr read path is about 7x faster than RCU's and SRCU's.

These properties — flat per-GP cost across CPU counts, low
IPI, and reader overhead that is largely unaffected by lockdep — make hazptr suited
for short-critical-section readers under a stable, shared
address, such as the lockdep key-hash lookup.

(v3 reported 26.1 ns; the improvement is consistent with the try_acquire
fast path in the base tree.)

3.  Stall detector
==================

CONFIG_HAZPTR_STALL_DETECTOR (default y, 21 s timeout) is modeled
on the RCU CPU stall detector.  After each scan cycle the kthread
checks still-blocked waiters; on timeout it walks all per-CPU and
overflow-list slots and reports each holder's pid, held time,
acquire call site, and task stack under CONFIG_HAZPTR_DEBUG.
Comparing consecutive reports distinguishes a single long-held
reference from repeated publication by different readers.  The
diagnostic message explains that long-lived references are a
hazard-pointer feature, not necessarily a problem.

Suggested by Paul E. McKenney.  Runtime sysfs controls
(/sys/kernel/hazptr/hazptr_stall_timeout_ms and
hazptr_stall_suppress) allow the administrator to adjust the
timeout or suppress reports at runtime.

4.  Changes since RFC v3
====================

- Rebased onto the try_acquire protocol.  Per-CPU
  slots publish their target directly; the shared scan uses a
  single-pass Bloom walk.  Dropped three v3 patches already
  addressed upstream or by the rebase: "scan all per-CPU slots
  before overflow lists" and "elide redundant first drain
  pass" (rebase), and "hazptr: Fix two-phase hazptr_synchronize
  race with detach" (merged upstream from Mathieu Desnoyers
  [3]).

- Added drain-assist, stall detector, lockdep conversion,
  HOTADDR/LONGHOLD/FAIRNESS torture scenarios, hazptr.sh selftest,
  rcuscale hazptr scale type.

- Safety fixes found during verification: Bloom early-return on
  empty slot, wildcard deferral in scans, exact-match fallback
  for Bloom false positives, FORCE_SLOWPATH skip-before-try,
  drain state re-initialized at engage, drain addr read with
  smp_load_acquire, slot type identified via
  hazptr_slot_is_backup().  Bloom filter collision-rate data
  on request from Joel Fernandes: [2].

- Build fixes: select TRACING for the torture test, export
  drain_key and tracepoint for =m linkage.

- The new base includes Andrea Parri's hazptrtorture fixes
  (reader-exit deferred cleanup, nest_acquire, slot-owner
  checks).  The HOTADDR/LONGHOLD/FAIRNESS scenarios are
  integrated with these changes; all configured hazptrtorture scenarios
  pass on the new base with nest_acquire enabled.

- Suggested-by: Boqun Feng (drain-assist direction, lockdep
  conversion, Bloom filter, slowpath debug, stall detector),
  Paul E. McKenney (stall detector, runtime sysfs controls),
  Mathieu Desnoyers (Bloom filter design). 

Testing
=======

ARM64 KVM (all scenarios at 16 vCPUs, 30 s each; the CPU sweep
runs PREEMPT at 8/16/32/64/128/256 vCPUs):

  Scenario     hazptr BUG   verdict
  ------------ -----------  -------
  PREEMPT      0            SUCCESS
  NOPREEMPT    0            SUCCESS
  SLOWPATH     0            SUCCESS
  LOCKDEP      0            SUCCESS
  READERS0     0            SUCCESS
  READERS4     0            SUCCESS
  HOTADDR      0            SUCCESS
  LONGHOLD     0            SUCCESS
  FAIRNESS     0            SUCCESS
  CPU 8-256    0            SUCCESS

The PREEMPT scenario runs with deferral enabled
(defer_modulus=16000) and nest_acquire=2, exercising the
reader-exit deferred cleanup that Andrea Parri's fixes
introduced; shutdown completes in under 100 ms.

HOTADDR drain verification: 450 engage events, 445 complete
disengages, 5 orphaned, 0 fairness-cap (the 5 orphaned
drains were disengaged because the Bloom scan completed the
waiter before the drain shut down).  LONGHOLD: 5 engage, 5 orphaned
disengage (outstanding=0).  FAIRNESS: 4 engage across 2 distinct
addresses, 3 fairness-cap disengages — drain rotation confirmed.

LKMM litmus tests (herd7 + linux-kernel.cfg):

  Litmus                            Result      Property
  --------------------------------  ----------  --------------------
  acquire-before-scan               Never       Publication ordering
  bloom-wildcard-hole               Never       Wildcard deferral
  drain-engage-wildcard             Never       Engage defers on wildcard
  drain-generation-visibility       Never       Generation ordering for release hooks
  drain-resnapshot-slot-race        Sometimes   Remove-only walk; handled by design
  drain-safety                      Sometimes   Engage snapshot; covered by wildcard+re-engage
  wildcard-flip-escape              Never       Legacy wildcard-flip protocol

All 28 commits compile with 0 errors / 0 warnings ([ARCH], [GCC],
four DRAIN x STALL Kconfig combinations, HAZPTR_TORTURE_TEST=m).

Design notes
============

- The drain engages for one address at a time; a fairness cap
  (HAZPTR_DRAIN_MAX_CYCLES) bounds each round and rotates to
  the next stalled waiter.  Rotation is bounded but not
  formally starvation-free: waiters positioned after the drain
  target in the scanning list do not accumulate re-engage
  cycles while another waiter's drain is active, so a
  late-arriving waiter can wait roughly two drain windows
  before its first turn.  The FAIRNESS torture scenario added
  in this series observes the rotation empirically via the
  kernel drain logs; the ARM64 run confirmed 2 distinct engaged
  addresses and 3 fairness-cap disengages.

- Key memory-ordering properties are tested by litmus tests: engage-wildcard,
  generation-visibility, resnapshot-slot-race, and drain-safety
  (see the litmus table above).  Forward progress requires
  readers to release, which holds for the lockdep use case
  (is_dynamic_key() is a short critical section); the stall
  detector reports any waiter blocked beyond the timeout.

[1] https://lore.kernel.org/all/as3aMmPdCHCXW6Ci@U-YXDQC754-96.local/
[2] https://lore.kernel.org/rcu/CAN_Opa-=QsYFgZ-tENoqvpfqMhr=sZToFBs6NfbyTOpNLYQB1g@mail.gmail.com/
[3] https://lore.kernel.org/all/20261011194902.97364-2-mathieu.desnoyers@efficios.com/

Kunwu Chan (28):
  hazptr: Add shared scan kthread
  hazptr: Use Bloom filter for shared scan waiters
  hazptr: Add scoped_guard() support
  hazptr: Add debug option to force the acquire slow path
  Documentation/litmus-tests: Add hazptr wildcard-flip escape test
  Documentation/litmus-tests: Add hazptr acquire-before-scan test
  hazptr: Fix kernel-doc of hazptr_release()
  hazptrtorture: Add slowpath and lockdep scenarios
  hazptrtorture: Add READERS4 and READERS0 torture configs
  hazptrtorture: Add 128- and 256-CPU configs
  selftests/rcutorture: Add hazptr torture test script
  hazptr: Remove per-waiter scan fallback, simplify synchronize
  hazptr: Add waiter-enqueue tracepoint
  hazptr: Add waiter stall detector
  hazptr: Add reader-assisted drain for stalled waiters
  Documentation/litmus-tests: Add hazptr drain engage-wildcard test
  Documentation/litmus-tests: Add hazptr drain resnapshot-slot-race test
  Documentation/litmus-tests: Add hazptr drain safety test
  Documentation/litmus-tests: Add hazptr drain generation-visibility test
  locking/lockdep: Use hazptr to wait for dynamic key lookups
  hazptrtorture: Add HOTADDR and LONGHOLD scenarios
  hazptrtorture: Add drain fairness rotation scenario
  rcuscale: Add hazptr scale type
  hazptr: Add runtime sysfs controls for stall detector
  hazptr: Select TRACING for HAZPTR_TORTURE_TEST to enable tracepoint
  hazptrtorture: Add torture_type=none clean skip for rcuscale coexistence
  hazptr: Add Bloom false-positive exact-match fallback
  Documentation/litmus-tests: Add hazptr bloom wildcard-hole test

 Documentation/litmus-tests/README             |   37 +
 .../hazptr/hazptr-acquire-before-scan.litmus  |   45 +
 .../hazptr/hazptr-bloom-wildcard-hole.litmus  |   49 +
 .../hazptr-drain-engage-wildcard.litmus       |   44 +
 .../hazptr-drain-generation-visibility.litmus |   41 +
 .../hazptr-drain-resnapshot-slot-race.litmus  |   36 +
 .../hazptr/hazptr-drain-safety.litmus         |   43 +
 .../hazptr/hazptr-wildcard-flip-escape.litmus |   46 +
 include/linux/hazptr.h                        |   71 +-
 include/trace/events/hazptr.h                 |   29 +
 kernel/hazptr.c                               | 1120 ++++++++++++++++-
 kernel/locking/lockdep.c                      |   25 +-
 kernel/rcu/Kconfig.debug                      |   42 +
 kernel/rcu/hazptrtorture.c                    |  633 +++++++++-
 kernel/rcu/rcuscale.c                         |   67 +
 .../selftests/rcutorture/bin/hazptr.sh        |  382 ++++++
 .../rcutorture/configs/hazptr/CFLIST          |    9 +
 .../rcutorture/configs/hazptr/CPU128          |   16 +
 .../rcutorture/configs/hazptr/CPU128.boot     |    1 +
 .../rcutorture/configs/hazptr/CPU256          |   16 +
 .../rcutorture/configs/hazptr/CPU256.boot     |    1 +
 .../rcutorture/configs/hazptr/FAIRNESS        |   19 +
 .../rcutorture/configs/hazptr/FAIRNESS.boot   |    1 +
 .../rcutorture/configs/hazptr/HOTADDR         |   18 +
 .../rcutorture/configs/hazptr/HOTADDR.boot    |    1 +
 .../rcutorture/configs/hazptr/LOCKDEP         |   16 +
 .../rcutorture/configs/hazptr/LOCKDEP.boot    |    1 +
 .../rcutorture/configs/hazptr/LONGHOLD        |   18 +
 .../rcutorture/configs/hazptr/LONGHOLD.boot   |    1 +
 .../rcutorture/configs/hazptr/READERS0        |   16 +
 .../rcutorture/configs/hazptr/READERS0.boot   |    2 +
 .../rcutorture/configs/hazptr/READERS4        |   16 +
 .../rcutorture/configs/hazptr/READERS4.boot   |    2 +
 .../rcutorture/configs/hazptr/SLOWPATH        |   16 +
 .../rcutorture/configs/rcuscale/HAZPTR        |   13 +
 .../rcutorture/configs/rcuscale/HAZPTR.boot   |    1 +
 36 files changed, 2854 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-bloom-wildcard-hole.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
 create mode 100644 include/trace/events/hazptr.h
 create mode 100755 tools/testing/selftests/rcutorture/bin/hazptr.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/FAIRNESS.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot


base-commit: 6e7df7157a91757355e22a2ca46bafc35fbd6465
-- 
2.43.0

