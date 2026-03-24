Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405A3D567A;
	Tue, 24 Mar 2026 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358811; cv=none; b=b2RZ9d/MZGTH3F0lM939CXx0qujQiOF4yygfmsecBAYppxr8j0nOVII5KN8J777usI6WnzyTm6Eh0LkVY5Z+uDL+iejlo3nem93geP2XluyJm22SQpdxcyZNSPOWsSymYY9198M/7oTpQMwJRqt7O5NsOLCjrYoj9UWi4c4STsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358811; c=relaxed/simple;
	bh=F/htvyFctlbNCF0Y3WWbR6ZEMytC7JSoA3t6ZZQxiTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q4B+L0FkNterB1QlvIN1Q3TtE1R2PnMflsnWkBVdJzjYnDMIpn8+Mhi1tdWbhdNz6jRAiZOEhLy8anbe013aQj32bv0aGWybdDzowpqVwEcFU4hkMbspP1UB8BjgbKU9Q1fV4dWvU5C5TEYCgbMkCl6a+iPWQIMgX1/gMiAKTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GAPjGmLN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GAPjGmLN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFCBA1476;
	Tue, 24 Mar 2026 06:26:42 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 935103FAF5;
	Tue, 24 Mar 2026 06:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774358808; bh=F/htvyFctlbNCF0Y3WWbR6ZEMytC7JSoA3t6ZZQxiTE=;
	h=From:To:Cc:Subject:Date:From;
	b=GAPjGmLNA2YBz+piw50rSr90wWg1hKu2xeFC6b9WohZRg5sJn/f7FEuJnwTJu0flv
	 CWF5JGZxgDVFsK7L3pWn1XO/yZuSgRC5qDd1WdH/9cHcgbY29uCOLYoYZLWaRyJm4H
	 phG4Qg87ZrNFvEut2qjD6YcSPCYyH4utTyOI86Js=
From: Muhammad Usama Anjum <usama.anjum@arm.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Peter Collingbourne <pcc@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan.Roberts@arm.com,
	david.hildenbrand@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>
Subject: [PATCH v2 0/3] KASAN: HW_TAGS: Disable tagging for stack and page-tables
Date: Tue, 24 Mar 2026 13:26:26 +0000
Message-ID: <20260324132631.482520-1-usama.anjum@arm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stacks and page tables are always accessed with the match‑all tag,
so assigning a new random tag every time at allocation and setting
invalid tag at deallocation time, just adds overhead without improving
the detection.

With __GFP_SKIP_KASAN the page keeps its poison tag and KASAN_TAG_KERNEL
(match-all tag) is stored in the page flags while keeping the poison tag
in the hardware. The benefit of it is that 256 tag setting instruction
per 4 kB page aren't needed at allocation and deallocation time.

Thus match‑all pointers still work, while non‑match tags (other than
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
Changes since v1: (summary only)
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
 mm/vmalloc.c                  | 11 ++++++++---
 4 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.47.3

