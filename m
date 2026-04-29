Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33E3D47B8;
	Wed, 29 Apr 2026 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458481; cv=none; b=POmTHkx4+fGIMAt8KDs8jtt78TGJXmyFcrWtjubjllxaf+VLz5LM70KFZm7ner6JHVXHyn1sDahg7kN0flkUG0TAlrDdvJykIkysuNAIAgZKC/dVDBwLZwjj22snzjur9/91UAZaUwYL7+RdYyBpR/D5cBmwlfRZfkU2OkYvCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458481; c=relaxed/simple;
	bh=UHBT6b3PQsNX4dbp5ITK6cbxzmXlXl+qSx4ZxL4OSG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KPl+sOk5HWlAsi5awMhaHWIFwuKFR6c3ZaXzFLEMYYr4IOu/1r4HBev1PEyaOstBYgv3W0RQ0MNxH5sKLxh/Ea5pRXo2x/VTuZ60FZn0nep7czVvEoxUQM8LcBVsFUFZ0/kkvA07bSYq5GRc9P3Ds1HSBwpiIhYJ8GBXF1fuKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lV3ZV6Rw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lV3ZV6Rw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 624EE2A68;
	Wed, 29 Apr 2026 03:27:50 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C81B3F763;
	Wed, 29 Apr 2026 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777458475; bh=UHBT6b3PQsNX4dbp5ITK6cbxzmXlXl+qSx4ZxL4OSG0=;
	h=From:To:Cc:Subject:Date:From;
	b=lV3ZV6RwQkLW3J5x4BqgxmN8ttA6LqRu1seHzAluQ2D86GgFtc5GbI7b9XjDWdz73
	 xkqIUOdvTaSvS973Qpn1PvkS9DSsx8Lbq/E5SIWej91BFGVmRLCOAYh5YR/5PeqSR7
	 z0Vnnh3LgeU5eIZHqFccKERW0haH/xk62312oiHo=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	arnd@arndb.de
Cc: Dev Jain <dev.jain@arm.com>,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	tglx@kernel.org,
	usama.anjum@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	ryan.roberts@arm.com,
	catalin.marinas@arm.com
Subject: [PATCH v4 0/3] kasan: hw_tags: Disable tagging for stack and page-tables 
Date: Wed, 29 Apr 2026 15:57:01 +0530
Message-Id: <20260429102704.680174-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stacks and page tables are always accessed with the match-all tag,
so assigning a new random tag every time at allocation and setting
invalid tag at deallocation time, just adds overhead without improving
the detection.

With __GFP_SKIP_KASAN the page keeps its poison tag and KASAN_TAG_KERNEL
(match-all tag) is stored in the page flags while keeping the poison tag
in the hardware. The benefit of it is that 256 tag setting instruction
per 4 kB page aren't needed at allocation and deallocation time.

Thus match-all pointers still work, while non-match tags (other than
poison tag) still fault.

__GFP_SKIP_KASAN only skips for KASAN_HW_TAGS mode, so coverage is
unchanged.

Benchmark:
The benchmark has two modes. In thread mode, the child process forks
and creates N threads. In pgtable mode, the parent maps and faults a
specified memory size and then forks repeatedly with children exiting
immediately.

Thread benchmark:
2000 iterations, 2000 threads:	2.575 s → 2.229 s (~13.4% faster)

The pgtable samples:
- 2048 MB, 2000 iters		19.08 s → 17.62 s (~7.6% faster)
---
Applies on 7-0-rc1.

Changes since v3->v4:
 - Sashiko noticed: https://sashiko.dev/#/patchset/20260424130157.3163009-1-dev.jain%40arm.com
   Fix this by honouring vmalloc skip via GFP_SKIP_KASAN only in HW tags case,
   to avoid unintended skipping in SW/generic KASAN.
 - Instead of removing and adding GFP_SKIP_KASAN into gfp_flags, simply
   call __get_vm_area_node() without it
 - Update GFP_SKIP_KASAN documentation
 - Put missing SOB by me

v2->v3:
- Directly skip kasan_unpoison_vmalloc() for GFP_SKIP_KASAN in patch 1

v1->v2:
- Update description/title
- Patch 1: Simplify skip conditions based on the fact that __GFP_SKIP_KASAN
- Patch 2: Specify _GFP_SKIP_KASAN in THREADINFO_GFP and GFP_VMAP_STACK

Muhammad Usama Anjum (3):
  vmalloc: add __GFP_SKIP_KASAN support
  kasan: skip HW tagging for all kernel thread stacks
  mm: skip KASAN tagging for page-allocated page tables

 include/asm-generic/pgalloc.h |  2 +-
 include/linux/gfp_types.h     |  6 +++---
 include/linux/thread_info.h   |  2 +-
 kernel/fork.c                 |  5 +++--
 mm/vmalloc.c                  | 13 +++++++++----
 5 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.34.1

