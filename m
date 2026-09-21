Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCA8499F3D;
	Mon, 21 Sep 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988350; cv=none; b=nFJJ2SO5CTPA+LIm6UfMJ9+ly7mKyhBzDWgLMIrRxYpNgeqdj5tNsII8LO9H1Z3UZHfsb78TdFdo9YUkbfFlA6Vb9dykOfoewhj4gJvbCd84Gs5geRlHngHpYwUVhkfCnh/XI5oE3dhpo+gVP9CbfY77/UyyK463Icqv/Ltg6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988350; c=relaxed/simple;
	bh=Or+pfL3PXEcPJdOW4W+xPfx8ylyd8tpn0CA0i+cQDx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X54mlD/38lpOMYdu0BpI9LhOd0xDK7SutXpuTB5vuF98TwKNoGCiwwQXzRWj8n+Ud4O/JQYQQwTfnq1992LLI7tAEW68PJjux+Qw8N4zLUAMbU7q2hOOpkQO+WoRI8Bx9KilKKxYfAzYSe2yp2rK4kqXjridRx+nCkgOkplIei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OTPGWQ3V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OTPGWQ3V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0D821CE0;
	Mon, 21 Sep 2026 03:59:03 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E11E3F86C;
	Mon, 21 Sep 2026 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988347; bh=Or+pfL3PXEcPJdOW4W+xPfx8ylyd8tpn0CA0i+cQDx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OTPGWQ3V/YIEMLtO7u2Mynqz++o5RPwLMFLlzIT4rgUlbfJz02BoKMgw4RXvRuSNj
	 deUYqvEpMQchecaubbKtyAiqcrqDJ3rG98HSWlUBFWHIGiqs9ocWbZVbfPkkrmm/D7
	 ncRtII6dpeDQJvydmvJhhhL2Snuaf1u6HEPcx7TY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:43 +0100
Subject: [PATCH 21/21] Documentation: mm: clarify behaviour of compile-time
 folded page tables
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-21-cd40cf68242e@arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
In-Reply-To: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
To: Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5249; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=WkUI9iV+4tWIf8gUL0eT1d3WqVW3xHozxqWVF9c3f4k=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1UvQaI/DbnQhSon1cfVb2lmVIAgB8pZa9xc
 x4itcv3wn+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENVAAKCRBt1cPRWsUx
 M3wVC/9HHxJ8te9GEbS6FYmVPJFsAKbIOicXI24Ln9gqlvTZxuy4kNJc4ab1vnjPxk64m8Rg+x2
 Mge3H0r3HnaL+quWGc5hhXjVijIFzCG8gpQvS3TAos58QC0AOllXSljJJW+I6bPGRHEfZbrplmH
 MSpeBY8ZsvhMVxoa7rzCNDxLL9FQI0Cc3PXqn84Rx9aaobgkmEtYiN7CNHsRZU3ng64fu67dco/
 9XO55oYTMY5NC0dEQSGNn31KsfpblVBRsW5um+k73FHlpD7vrNWPHSDKjsItM4o3qlBwTsCwCl1
 Z7zy/Eg/ZygXnmH8QOhMc7fglKOXMvcG/maDLM9eOF/8KD3LCcwyTzCpuv5EoxT7vOhxogj2kut
 s/VQGR4ui3uesYjCw/PuXgA7Ampck2ZMBsmMmPI1k93NpLLOG4Y529M4WW6uqqGb5xddwPmnW5l
 apVpiy9rUjEUxGjRGHepEQpg+BUzcWhj6iVaP8sd5tNs9WaHGtTaNtG9oqCr4rfrjLXkY=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Compile-time folded page tables are not necessarily easy to understand, and even
people the were once familiar with the concept might need to refresh their memory.

Add proper documentation, including a nice diagram, for the current design.
Mention details about dummy functions, including the recently changed pXdp_get()
helpers.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/mm/page_tables.rst | 84 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index 126c876282509..84f2715c7de0a 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -143,15 +143,81 @@ pointers on each level is architecture-defined.::
 Page Table Folding
 ==================
 
-If the architecture does not use all the page table levels, they can be *folded*
-which means skipped, and all operations performed on page tables will be
-compile-time augmented to just skip a level when accessing the next lower
-level.
-
-Page table handling code that wishes to be architecture-neutral, such as the
-virtual memory manager, will need to be written so that it traverses all of the
-currently five levels. This style should also be preferred for
-architecture-specific code, so as to be robust to future changes.
+Not all architectures support 5-level page tables; while for some of them
+the exact number of supported page table levels is known at compile time,
+others can determine the number of page table levels at runtime based on
+hardware support and address space sizes.
+
+Generic page table walking code always assumes that 5 levels of page table
+exist. To make page table walking code not have to worry about that,
+`compile-time folding` and `runtime folding` of page tables are used.
+Compile-time folding is mostly handled in common code, whereas runtime folding
+is exclusively handled in architecture code.
+
+This description focuses on generic compile-time folded page tables; for
+architecture-specific variants, some details can vary, however, without
+affecting common page table walkers.
+
+When walking folded page tables, all upper page table levels up to the supported
+level are skipped in page table walkers: this is achieved by (a) treating
+entries in upper page table levels as present and pointing at a page table; and
+(b) having page table walkers cast the entry pointer to the next-level entry
+instead of dereferencing that table. From the perspective of a page table
+walker, the entry points at itself.
+
+Assuming compile-time folded 4-level page tables, to achieve (a), pgd_present()
+and pgd_leaf() are hard-coded to indicate a present page table entry that
+points at a page table, and to achieve (b) p4d_offset() and
+p4d_offset_lockless() simply cast the page table entry pointer to the next
+lower level.
+
+In the current design, this is further modeled by having the P4D have a
+single page table entry::
+
+        PGD
+  --> +------+          NOP4D
+      | ptr0 |-------> +------+           PUD
+      | ptr1 |-        | ptr0 |-------> +-----+
+      | ptr2 | \       +------+         | ptr |-------> ...
+      | ptr3 |  \                       | ptr |
+        ...      \                        ..
+                  \        NOP4D
+                   +----> +------+           PUD
+                          | ptr1 |-------> +-----+
+                          +------+         | ptr |-------> ...
+                                           | ptr |
+                                             ...
+
+Note that the arrows from PGD to NOP4D represent page-table-walker
+transitions, not pointers stored in the pgd entries.
+
+Using p4d as an example, `nop4d`/`p4d folded` translates to the following:
+
+- p4d is considered folded into pgd; both are operating on the same page
+ table.
+
+- Most pgd_* helpers are hard-coded dummy functions that ignore the passed
+  pgd_t values entirely. Exceptions are pgd_val() and low-level helpers
+  set_pgd() + pgd_page_vaddr(), which effectively translate to set_p4d()/
+  p4d_pgtable() to keep existing arch code working.
+
+  Architectures must provide p4d_* helpers (unless further common
+  compile-time folding applies).
+
+- PTRS_PER_P4D is hard-coded to 1. Architectures must define PTRS_PER_PGD.
+
+To avoid reading a value that will never be used but cannot be entirely
+optimized out, compile-time folded page table code also makes pXdp_get()
+return a constant dummy value.
+
+In common code, this only affects pXd_val() when used for printing page
+table entries for debugging purposes. As we don't want architecture code
+that uses set_pXd(), pgd_page_vaddr() or pXd_pgtable() to accidentally
+operate on dummy values, the compiler will error out if it detects that the
+helpers are used with dummy values. For a folded level, pXd_page() must not
+be used and unconditionally triggers a compiler error. Architecture code must
+instead call the helpers on the proper first page table level: e.g., set_p4d()
+instead of set_pgd().
 
 
 MMU, TLB, and Page Faults

-- 
2.43.0

