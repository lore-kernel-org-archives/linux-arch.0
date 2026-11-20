Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214880;
	b=awcShQKnWB/E6YPLl03GuSzOGOPHC+M+qYZMJNKlm8EE64n61rNzaa8S7SBxzGgNU2iB
	 zUOJao3HckGZR7XaHUdcJgj07c9Rl9nD+YD1wOZwlPtT7lIBN7VYWn2+8o3XuVXZ/c/Ql
	 0uM8VSzCC2/7A13fkkWi+rtcyHn9wWnVRvlcsh1r9wdhtqCdfwVO90WqC3/x0L261kJ6v
	 VhP94Vm+l09osY8oYdNtcE2bmHxdjyekgyuz+Uqr3DFuuvGXWPH45suJQI7nyEb1qlHel
	 ftuQVZCGqHH2vgReNWHh0lBB7zflhwerwRHFqLTYfqntqWVZzyWjAwA8Ee+y3Zt5o3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214880;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Subject:To:Cc:From:
	 Date:Message-Id;
	bh=2/DnoLd1laDsESHwuJ8oDndRsaqFJiYak80FH3k99hI=;
	b=CaE2RcL5YbP6jHigmHszQKPPbij9pkLc9myHga0HRcL/v6isdJ9xrCzmPd5+JFbODto5
	 RGi/jGAwJwpaVNnDHtYu/D4UCmgVlkjGw4IoedFabzwIR0hxLeFMupgdRPMJSE1DWp5CV
	 Gv90b91k+mpwdmMj1QI9sTbYz86KEQPXcfwqy1x9CD7rmyBiUfaClJ7g/nYu+btN2sGaE
	 wbPaG3G/Z6oihPOhK6lNVWMANroScokci26iKFBFEqRm2+GvFeifnJfArzHEHEnt+JySX
	 r/61q1/RVniEMWp6eA/tJ6TfWpllKIQ7c7GhXSfbeHxOh4PmaHJP/s4mzT0UbhV6Huw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cYoNnR7+;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE7606A698;
	Fri, 20 Nov 2026 22:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02CE7606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cYoNnR7+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795214880; x=1826750880;
  h=subject:to:cc:from:date:message-id;
  bh=9bVzioXZw7USSiIfTjHk3w5r1BhOeDv0Es4/WoxyQTk=;
  b=cYoNnR7+s0TkNdFEzDZYbIhnFqNs+PxNiogA4xtDx6biXolOdJ0wipmC
   VxFzSWWmTuZDLa15RWTDYWNfL5gzMom1nVeBUb2R63THVJv5DlwqTfEkZ
   PbuL9Cp+Uk9FeFy5TNz+J00Hw22hUHQNDswKF/yFuyqCYssf6g1b0D9pC
   0V8wvwYqKeet2+fggCa5+tiY/SczqKTqb/jCgi2d6j1b7SmHJuC5SBt3w
   ezigcK5+e7Rz5oknLs7l35uRT5ltcQ3B4reABEPFGo+QtdhnA+RO5p0Jo
   9Zd1xA9JkVd5FFCe8hE9LtZB1XInCdEVvjd5K9Xk1ezGyhXF52fOLWXV7
   Q==;
X-CSE-ConnectionGUID: rfImMtNlTkKIPz/Pgkechw==
X-CSE-MsgGUID: RSHswU9BSMGi0ba7uWzaoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4093870"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4093870"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 14:48:00 -0800
X-CSE-ConnectionGUID: 53pvTRDATiCws4Dlp6vfiQ==
X-CSE-MsgGUID: 6iMRYmjJQhGysHkWXSsGxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11152071"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 20 Nov 2026 14:47:59 -0800
Subject: [PATCH] smp: Add memory barrier before many-CPU IPIs
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Liam R. Howlett" <liam@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, x86@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Nov 2026 14:47:58 -0800
Message-Id: <20261120224758.04F70CD8@davehans-spike.ostc.intel.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list


From: Dave Hansen <dave.hansen@linux.intel.com>

This innocent-looking snippet:

	mm->foo = bar;
	on_each_cpu_mask(mm_cpumask(mm), ipi_func, ...);

is potentially buggy because the variable update is not ordered with
respect to the mm_cpumask() read. There were at least two examples of
this pattern on x86 that we think were real bugs. See commit
0dc2a4dac3d0 ("x86/mm: Ensure write visibility during LDT
installation") for one of them.

Add a barrier to the core IPI code to make this pattern more foolproof.

Other arch maintainers: You might want to take a look over your IPIs
and see if this pattern is biting you anywhere. Also, for those of
you that *do* have correct barriers in place for this pattern, they
may become redundant if this gets applied.

This specific idea came from Linus (and his LLM), with some tweaking
on top from me. I'm planning to send it up in the next merge window
via an x86 tree, barring any objections or performance issues that
surface. Please speak up if this causes you any heartburn.

Longer discussion follows.

== Background ==

There's a basic pattern in the kernel where some in-memory structure
is changed and then remote CPUs are notified via an IPI about the
change. TLB flushes are the canonical example but there are plenty
of others.

The IPI is generally sent to the CPUs using an mm found via
mm_cpumask(). CPUs set themselves in that mask when they context
switch to an mm.

So, there are two sides to this pattern. Both write some data and the
other side consumes it. Bugs happen if, for instance, the IPI-sending
CPU uses a stale mm_cpumask(). Or, if the IPI-receiving CPU happened
to read the data before setting its bit in mm_cpumask().

== Problem ==

There was a recent x86 bug where mm_cpumask() was read before the
newly-written data was visible to remote CPUs. This was the reverse of
program order, but allowed without a memory barrier.

But this case is not special. There are other examples on x86,
including one in the LAM code which is probably a real but largely
inconsequential bug today. There are a few other x86 cases which use
atomics (and have their own memory barriers), but they are probably
correct by accident more than design.

== Solution ==

Add a full smp_mb() in the core IPI code and documentation of the new
rules. Place the smp_mb() just before the cpumask is acted on.  This
will ensure that any data written before the IPI is visible to remote
CPUs.

This makes the smp_call_function() code a wee bit more expensive, but
substantially harder to get wrong.

Combined with the barriers in mm switching, this ensures that remote
CPUs either get the IPI or can see the write from the IPI sender.

Place the barrier so it covers every entry point that takes a cpumask:
on_each_cpu_mask(), on_each_cpu_cond_mask() and
smp_call_function_many(). Callers that sample mm_cpumask() themselves
to pick targets must still order the update against their own mask
read.

Remove the now-redundant smp_mb() in x86's install_ldt().

== Impact ==

Many IPI users already have working barriers in place. The new barrier
may make some of those redundant.

== Alternatives ==

My first thought was to add a barrier in mm_cpumask() itself. But it
only computes a pointer to the cpumask. A barrier there would be odd
because there is no actual data consumed.

Andy Lutomirski suggested adding a barrier to on_each_cpu_mm(). That
would work for the x86 cases, but might leave issues in code that does
not deal with mm's.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org
---

 b/arch/x86/kernel/ldt.c    |   12 ++++--------
 b/arch/x86/mm/tlb.c        |    5 +++++
 b/include/linux/mm_types.h |   14 +++++++++++++-
 b/include/linux/smp.h      |    4 ++++
 b/kernel/smp.c             |   17 +++++++++++++++++
 5 files changed, 43 insertions(+), 9 deletions(-)

diff -puN arch/x86/kernel/ldt.c~ipi-mb2-generic arch/x86/kernel/ldt.c
--- a/arch/x86/kernel/ldt.c~ipi-mb2-generic	2026-11-20 11:28:32.775743722 -0800
+++ b/arch/x86/kernel/ldt.c	2026-11-20 12:04:14.780113172 -0800
@@ -422,16 +422,12 @@ static void install_ldt(struct mm_struct
 {
 	mutex_lock(&mm->context.lock);
 
-	/*
-	 * Ensure that new mm user CPUs either see the new LDT value
-	 * or get an IPI. Make the store visible before reading
-	 * mm_cpumask(). New mm users make their mm_cpumask() writes
-	 * visible before reading mm->context.ldt.
-	 */
 	WRITE_ONCE(mm->context.ldt, ldt);
-	smp_mb();
 
-	/* Activate the LDT for all CPUs using currents mm. */
+	/*
+	 * Activate the LDT for all mm-user CPUs. New mm users either
+	 * see the new LDT or get the IPI, see mm_cpumask().
+	 */
 	on_each_cpu_mask(mm_cpumask(mm), flush_ldt, mm, true);
 
 	mutex_unlock(&mm->context.lock);
diff -puN arch/x86/mm/tlb.c~ipi-mb2-generic arch/x86/mm/tlb.c
--- a/arch/x86/mm/tlb.c~ipi-mb2-generic	2026-11-20 11:28:32.777743889 -0800
+++ b/arch/x86/mm/tlb.c	2026-11-20 11:54:03.546906165 -0800
@@ -937,6 +937,11 @@ void switch_mm_irqs_off(struct mm_struct
 		 *
 		 * This way switch_mm() must see the new tlb_gen or
 		 * flush_tlb_mm_range() must see the new loaded_mm, or both.
+		 *
+		 * This also protects other per-mm state read below, like the
+		 * LDT. Changes to that state are followed by an IPI to the
+		 * CPUs in mm_cpumask(). Setting the bit first means this CPU
+		 * either reads the new value or gets the IPI.
 		 */
 		if (next != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
diff -puN include/linux/mm_types.h~ipi-mb2-generic include/linux/mm_types.h
--- a/include/linux/mm_types.h~ipi-mb2-generic	2026-11-20 11:28:32.779744056 -0800
+++ b/include/linux/mm_types.h	2026-11-20 11:28:32.785744556 -0800
@@ -1514,7 +1514,19 @@ static inline void mm_init_cpumask(struc
 	cpumask_clear((struct cpumask *)cpu_bitmap);
 }
 
-/* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
+/*
+ * mm_cpumask() - CPUs that may hold state derived from @mm (TLB entries,
+ * cached per-mm context). Code that updates per-mm state and then notifies
+ * the CPUs in the mask relies on:
+ *
+ *  - A CPU sets its bit, then a full barrier, then reads that state or
+ *    loads @mm's page tables.
+ *  - The updater has a full barrier between the update and reading the
+ *    mask. on_each_cpu_mask() and smp_call_function_many() provide it;
+ *    open-coded mask tests (e.g. "only this CPU?") must do it themselves.
+ *  - An architecture that clears bits must revalidate that state when the
+ *    CPU sets its bit again.
+ */
 static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 {
 	return (struct cpumask *)&mm->flexible_array;
diff -puN kernel/smp.c~ipi-mb2-generic kernel/smp.c
--- a/kernel/smp.c~ipi-mb2-generic	2026-11-20 11:28:32.780744139 -0800
+++ b/kernel/smp.c	2026-11-20 11:48:27.863451170 -0800
@@ -950,6 +950,15 @@ static void smp_call_function_many_cond(
 	 */
 	WARN_ON_ONCE(!in_task());
 
+	/*
+	 * Callers update some state and then IPI the CPUs in @mask to act on
+	 * it. A CPU that sets its bit in @mask and then reads that state
+	 * must either see the update or get the IPI, so order the caller's
+	 * prior updates before reading @mask. Pairs with a full barrier
+	 * between setting the bit and reading the state, e.g. in switch_mm().
+	 */
+	smp_mb();
+
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	if (cpumask_any_and_but(mask, cpu_online_mask, this_cpu) < nr_cpu_ids) {
 		cpumask_and(cpumask, mask, cpu_online_mask);
@@ -1043,6 +1052,10 @@ static void smp_call_function_many_cond(
  *
  * @func is not called on the local CPU even if @mask contains it.  Consider
  * using on_each_cpu_cond_mask() instead if this is not desirable.
+ *
+ * Stores made by the caller before this call are ordered before the
+ * read of @mask, so a CPU that sets its bit in @mask and then reads
+ * that data will either see the stores or receive the IPI.
  */
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
@@ -1181,6 +1194,10 @@ void __init smp_init(void)
  * to be seen or sent an IPI. If @wait is true, the final wait for remote
  * completion happens after that preemption-disabled section.
  *
+ * Stores made by the caller before this call are ordered before the
+ * read of @mask, so a CPU that sets its bit in @mask and then reads
+ * that data will either see the stores or receive the IPI.
+ *
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
  */
diff -puN include/linux/smp.h~ipi-mb2-generic include/linux/smp.h
--- a/include/linux/smp.h~ipi-mb2-generic	2026-11-20 11:48:08.343859262 -0800
+++ b/include/linux/smp.h	2026-11-20 11:48:27.863451170 -0800
@@ -82,6 +82,10 @@ static inline void on_each_cpu(smp_call_
  *
  * If @wait is true, then returns once @func has returned.
  *
+ * Stores made by the caller before this call are ordered before the
+ * read of @mask, so a CPU that sets its bit in @mask and then reads
+ * that data will either see the stores or receive the IPI.
+ *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.  The
  * exception is that it may be used during early boot while
_
