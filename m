Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478143BE63C;
	Thu, 19 Mar 2026 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921006; cv=none; b=uG7rZNkBBm36+O2ID3NGb65ZLYlDlXgI9JyeQ657Uzr/QVHB660U1xYwpmoMS3XfkRolVUKCH62pspn1+S7SuBAK4b8A6uGz6zg6gjM5DrES9tI3Nuxd5RmBaYr1H1fzWGHrjFUDwtvTswi0NK888SnIEo+U6RyAajaA0i4MvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921006; c=relaxed/simple;
	bh=0l25HyAHQgoONvpx1RfA/x7kDIoBZJuv5+2RBDF9kdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYZpCMErbSS34jl+hHaeyaOVsshs6tn3nOjtyTBDQNcLwU/nVOEKGr4i37XEl0UnB7emu/a0tngnZzBBxXHU2AKu2XlaxnQkK9WY27bto1RGTkazgOGnGjwV+mlM/ikreEa9RIIOzpfKNk3ursasBpKOioCBNhTyLNtVK1btlzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F851A25;
	Thu, 19 Mar 2026 04:49:58 -0700 (PDT)
Received: from e142334-100.cambridge.arm.com (e142334-100.cambridge.arm.com [10.1.194.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D98B3F778;
	Thu, 19 Mar 2026 04:50:00 -0700 (PDT)
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
Subject: [PATCH 0/3] KASAN: HW_TAGS: Disable tagging for stack and page-tables
Date: Thu, 19 Mar 2026 11:49:43 +0000
Message-ID: <20260319114952.3241359-1-usama.anjum@arm.com>
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

Muhammad Usama Anjum (3):
  vmalloc: add __GFP_SKIP_KASAN support
  fork: skip MTE tagging for kernel stacks
  mm: SKIP KASAN for page table allocations

 include/asm-generic/pgalloc.h | 2 +-
 kernel/fork.c                 | 8 +++++---
 mm/vmalloc.c                  | 8 ++++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.47.3

