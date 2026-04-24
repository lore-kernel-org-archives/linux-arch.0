Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DAA1A3157;
	Fri, 24 Apr 2026 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035737; cv=none; b=l0U3DGlhXQV1d07rjIVYiofpOV8tg0P9Wu8iY7COqrkdp13nW/hXBLMzVkQUpszOo6w4AWvmEnN1TU6pgE103pHep09yBImStx9jRzxXR165SJC3nlWSRW3d7m6M0HxeoNLlxC8UFsVD4k/Wd1Tdd/w5db1Goowq+xOOAFzkTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035737; c=relaxed/simple;
	bh=2GQQpZVfKf79CLkB3vuTV1KsPX0Zall+u2kivJ9bl90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HyW4hr9z/4MO25ihG3PRI2D+5LFry1dIVHD44krSl3/GcOC60FrXkc8BUJt9xwOqH/7PabxOprML3z7zTJDRK2VPF6yIK1drpXQ4rmdc4FwOlEFDMQqL93vzNYGVFdakN2Uw8pVuEtfmuM2Og2miSXk0KmwZ/SXIVlwHIoVHKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E33j+Pmz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E33j+Pmz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48DAD1AED;
	Fri, 24 Apr 2026 06:02:09 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A8963F641;
	Fri, 24 Apr 2026 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777035734; bh=2GQQpZVfKf79CLkB3vuTV1KsPX0Zall+u2kivJ9bl90=;
	h=From:To:Cc:Subject:Date:From;
	b=E33j+Pmz05YZfhkrDU022/rWSei1SFcH47C9oocH/5SUfc2ps0SefGiVvBrbaTqh3
	 MUYngzyinhJekaRpLPWdPjLzMmnx46DUZwn7Kgs0ZQ/tjpQ9M4VX6iLpV5cG49IgBq
	 BGlhWjbqUtqLJizsevU7JkEmCAPdkS88/toAcKy8=
From: Dev Jain <dev.jain@arm.com>
To: arnd@arndb.de,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	urezki@gmail.com
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	tglx@kernel.org,
	usama.anjum@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 0/3] kasan: hw_tags: Disable tagging for stack and page-tables
Date: Fri, 24 Apr 2026 18:31:54 +0530
Message-Id: <20260424130157.3163009-1-dev.jain@arm.com>
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

Changes since v2:
- Directly skip kasan_unpoison_vmalloc() for GFP_SKIP_KASAN in patch 1

Changes since v1:
- Update description/title
- Patch 1: Simplify skip conditions based on the fact that __GFP_SKIP_KASAN
- Patch 2: Specify _GFP_SKIP_KASAN in THREADINFO_GFP and GFP_VMAP_STACK

Muhammad Usama Anjum (3):
  vmalloc: add __GFP_SKIP_KASAN support
  kasan: skip HW tagging for all kernel thread stacks
  mm: skip KASAN tagging for page-allocated page tables

 include/asm-generic/pgalloc.h |  2 +-
 include/linux/thread_info.h   |  2 +-
 kernel/fork.c                 |  5 +++--
 mm/vmalloc.c                  | 20 +++++++++++++++++---
 4 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.34.1

