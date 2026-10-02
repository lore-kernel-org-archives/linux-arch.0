Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0024E13E8;
	Fri,  2 Oct 2026 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961184; cv=none; b=nHdlCZYw2Jt8MtgUr4kHmEELbGMqsAYUABS/Cu5yvMVyQUw07m+RhQg/3hHVwvksl9JX77id7ojvWGM2+GcNnW/coG2v9tA8DPPUkkWRoc6WUvSsyn+p9sjpisFL0CZUTVXBSP/AFczNQtkY4kj5Y0Ils1wYBvPQpIsBSVF4Byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961184; c=relaxed/simple;
	bh=bMOormtD/BysD5q/X8WDjYCKDuOENgwnylEY69wimnU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aBQ84H34DkgrFpwqFWws1bEASLhZwJw0xlzAxzKx7+XA9faPBCicS96G5QSCpN7vVmXqrWZIgh+7tNweM6D0iQqKbGa785YD/i+bxEf1r9T9JTSjgpfSI9LwjcpN7cOoVFL2EvX08qBaDDpTsnfOCtjmZ6oWlbw7F8jbzHf55dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=k3cOqoXT; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=CmtFmN6j; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="k3cOqoXT";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="CmtFmN6j"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790961152; bh=b9Q0i239fHVl2Kmz77y2hqJ
	hKMRp0ccS9+F9KIK0Jhk=; b=k3cOqoXT7iyuu9IwI3dU6iCnI6VAlceY9g/2speCBBovG+d5lm
	+8fyy0pebrjEp1MDWDVxLM7103M7XPWEMzwwTBeOxQ4xu3GVRLOmmDBrDzRJ8dvNWF7LxgfLheu
	xalcN3D8SdgKogqpDG/LdRabowqU0Zswkj3NYeARcKkZDfmTuotP/T0N9IwFAsv2ARks9bzha7y
	Ia9oBlbaEtoi7V6wGyl4vHUUDH41mQLZHW52FKgh43g/xrZ3+R7p8VnjXozqCmMmZFulXuE5bR4
	Gzomkm56TsgL/i+VWr1AhKy9VZB9n6sqtN7sU7h7J0XCG/CW2exlPPym7Kb37LzTlpg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790961152; bh=b9Q0i239fHVl2Kmz77y2hqJ
	hKMRp0ccS9+F9KIK0Jhk=; b=CmtFmN6jO7CuOtkqUNxQF+NndeulGQxjo9ai9gJ3chl4yCFwcB
	NtHWgsC4OciGaHrxIKTkj6M518iY0qxAIaDg==;
Date: Fri, 02 Oct 2026 18:12:32 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Kunwu Chan <kunwu.chan@gmail.com>, paulmck@kernel.org, corbet@lwn.net,
 mingo@redhat.com, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 josh@joshtriplett.org, urezki@gmail.com, dave@stgolabs.net,
 lianux.mm@gmail.com
CC: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun@kernel.org, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com,
 skhan@linuxfoundation.org, rdunlap@infradead.org, longman@redhat.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, kunwu.chan@gmail.com, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org,
 rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_v2_00/15=5D_hazptr=3A_batch_sy?=
 =?US-ASCII?Q?nchronize_operations_through_a_shared_scan?=
In-Reply-To: <20261002170847.3653663-1-kunwu.chan@gmail.com>
References: <20261002170847.3653663-1-kunwu.chan@gmail.com>
Message-ID: <06F49954-C343-4894-931D-9B2F50F644DE@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 2 October 2026 18:08:32 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
>This series extends Paul McKenney's v3 hazptr implementation [1]
>with a shared scan path for concurrent hazptr_synchronize() callers,
>and adapts the lockdep dynamic-key hashlist use case from Boqun
>Feng's 2025 shazptr series [2] to the current hazptr API.
>
>The series also adds rcuscale support and torture coverage for
>the hazptr implementation.
>
>The lockdep conversion replaces the expedited RCU wait in
>lockdep_unregister_key() with hazptr_synchronize().  This limits
>the wait to hazard pointers protecting the target hash bucket
>instead of waiting for a system-wide expedited RCU grace period.
>
>[1]
>https://lore.kernel.org/all/20260919000056.3132131-26-paulmck@kernel.org/
>[2]
>https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/
>


This is well needed. Thanks for the patch, I'll maybe review maybe test if
I have time, cough cough, school!

>Performance data
>================
>
>All measurements are on an ARM64 KVM guest with
>HAZPTR_SCALE_NR_OBJS=8 and round-robin updater selection; unless
>noted otherwise, nreaders=0.  Scale tests run with
>PROVE_LOCKING=n.
>
>rcuscale synchronize latency (96 CPUs, nw=1):
>
>              nreaders=0      nreaders=1       nreaders=4      nreaders=96
>    scale       avg              avg             avg              avg
>    --------------------------------------------------------------------
>    hazptr     46 us            47 us          102 us            106 ms
>    RCU       8.3 ms           8.5 ms         16.6 ms         54.4 ms
>    SRCU      8.2 ms           8.0 ms         11.7 ms         11.8 ms
>
>Hazptr single-writer latency remains below 110 us with up to
>four readers on this 96-CPU guest, but rises to 106 ms when
>all 96 CPUs hold hazard pointers.
>
>Under 16 concurrent synchronize callers (nw=16), per-writer
>latency at four CPU counts:
>
>              hazptr nw=16      RCU nw=16     SRCU nw=16
>    CPUs       avg               avg             avg
>    -----------------------------------------------------------
>      24       8.0 ms          13.6 ms          9.2 ms
>      96       8.0 ms          13.3 ms          8.6 ms
>     128       7.9 ms          13.0 ms         11.7 ms
>     256       8.0 ms          20.8 ms          9.6 ms
>
>Hazptr remains around 8.0 ms across these CPU counts, with the
>scan-kthread retry interval contributing to the latency.
>RCU rises to ~21 ms at 256 CPUs while SRCU stays around 9-12 ms.
>
>Reader-side overhead (refscale, 96 readers on the 96-CPU guest,
>3 runs each):
>
>    hazptr     25.7 ns/op
>    RCU        96.7 ns/op
>    SRCU      134.6 ns/op
>
>lockdep workload -- tc qdisc mq x100, ARM64 KVM, PROVE_LOCKING=y,
>96 background hazptr readers, function-call IPIs per 100 ops:
>
>    CPUs       hazptr              exp RCU            reduction
>    ------------------------------------------------------------
>      24       196                 207                 5%
>      96       189                 265                29%
>     128       193                 266                27%
>     256       222                 384                42%
>
>Hazptr issues fewer function-call IPIs at each CPU count, with
>the difference reaching 42% at 256 CPUs.
>
>The hazptr.sh test suite passes, including the lockdep scenarios
>and the 8-to-256 CPU sweep, with no lockdep warnings, deadlocks,
>or crashes.
>Additional x86 server testing with Lian Wang is planned(maybe after
>LPC).
>
>Changes since RFC/WIP
>=====================
>
>- RFC/WIP: https://lore.kernel.org/all/20260922070950.4173245-1-kunwu.chan@gmail.com/
>
>- Split the original 4-patch RFC/WIP into smaller commits covering
>  shared scanning, correctness, API support, lockdep, scaling, and
>  torture testing.
>
>- Incorporated Boqun Feng's review feedback: use a Bloom filter to
>  avoid per-waiter allocation, add scoped_guard() support, and add
>  a debug option to force the hazptr acquire slow path.
>
>- Fixed scan ordering around backup-slot promotion by scanning all
>  per-CPU slots before the overflow lists, with a separate
>  overflow-list phase.
>
>- Simplified the scan cycle to flip first and drain only the old
>  wildcard generation, with herd7-verified LKMM tests for both the
>  in-flight and resolved publication cases.
>
>- Extended rcuscale and hazptrtorture coverage, added a selftest
>  script for the torture configurations, and fixed the
>  hazptr_release() kernel-doc.
>
>Kunwu Chan (15):
>  hazptr: add shared scan kthread
>  hazptr: use Bloom filter for shared scan waiters
>  hazptr: scan all per-CPU slots before overflow lists
>  hazptr: add scoped_guard() support
>  hazptr: add debug option to force the acquire slow path
>  hazptr: elide redundant first drain pass
>  Documentation/litmus-tests: add hazptr wildcard-flip escape test
>  locking/lockdep: use hazptr to wait for dynamic key lookups
>  rcuscale: add hazptr scale type
>  hazptr: fix kernel-doc of hazptr_release()
>  Documentation/litmus-tests: add hazptr acquire-before-scan test
>  hazptrtorture: add slowpath and lockdep scenarios
>  hazptrtorture: add READERS4 and READERS0 torture configs
>  hazptrtorture: add 128- and 256-CPU configs
>  selftests/rcutorture: add hazptr torture test script
>
> Documentation/litmus-tests/README             |  13 +
> .../hazptr/hazptr-acquire-before-scan.litmus  |  45 +++
> .../hazptr/hazptr-wildcard-flip-escape.litmus |  46 +++
> include/linux/hazptr.h                        |  56 ++-
> kernel/hazptr.c                               | 336 +++++++++++++++++-
> kernel/locking/lockdep.c                      |  25 +-
> kernel/rcu/Kconfig.debug                      |  10 +
> kernel/rcu/hazptrtorture.c                    |  57 ++-
> kernel/rcu/rcuscale.c                         |  70 +++-
> .../selftests/rcutorture/bin/hazptr.sh        | 146 ++++++++
> .../rcutorture/configs/hazptr/CFLIST          |   6 +
> .../rcutorture/configs/hazptr/CPU128          |  16 +
> .../rcutorture/configs/hazptr/CPU128.boot     |   1 +
> .../rcutorture/configs/hazptr/CPU256          |  16 +
> .../rcutorture/configs/hazptr/CPU256.boot     |   1 +
> .../rcutorture/configs/hazptr/LOCKDEP         |  17 +
> .../rcutorture/configs/hazptr/LOCKDEP.boot    |   1 +
> .../rcutorture/configs/hazptr/READERS0        |  16 +
> .../rcutorture/configs/hazptr/READERS0.boot   |   2 +
> .../rcutorture/configs/hazptr/READERS4        |  16 +
> .../rcutorture/configs/hazptr/READERS4.boot   |   2 +
> .../rcutorture/configs/hazptr/SLOWPATH        |  16 +
> 22 files changed, 881 insertions(+), 33 deletions(-)
> create mode 100644
> Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
> create mode 100644
> Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
> create mode 100755 tools/testing/selftests/rcutorture/bin/hazptr.sh
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/CPU128
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/CPU256
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/READERS0
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/READERS4
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
> create mode 100644
> tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
