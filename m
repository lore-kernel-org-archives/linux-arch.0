From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 11/12] tracing: Add TRACE_DEFINE_SIZEOF() macros
Date: Wed, 31 May 2017 16:56:52 -0500
Message-ID: <20170531215653.3240-12-jeremy.linton@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531215653.3240-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
List-Id: linux-arch.vger.kernel.org

There are a few places in the kernel where sizeof() is already
being used. Update those locations with TRACE_DEFINE_SIZEOF.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kvm/trace.h     |  2 ++
 include/trace/events/xen.h | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/trace.h b/arch/arm64/kvm/trace.h
index 7fb0008..5188c70 100644
--- a/arch/arm64/kvm/trace.h
+++ b/arch/arm64/kvm/trace.h
@@ -93,6 +93,8 @@ TRACE_EVENT(kvm_arm_set_dreg32,
 	TP_printk("%s: 0x%08x", __entry->name, __entry->value)
 );
 
+TRACE_DEFINE_SIZEOF(__u64);
+
 TRACE_EVENT(kvm_arm_set_regset,
 	TP_PROTO(const char *type, int len, __u64 *control, __u64 *value),
 	TP_ARGS(type, len, control, value),
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 31acce9..b70a38b 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -30,6 +30,8 @@ DECLARE_EVENT_CLASS(xen_mc__batch,
 DEFINE_XEN_MC_BATCH(xen_mc_batch);
 DEFINE_XEN_MC_BATCH(xen_mc_issue);
 
+TRACE_DEFINE_SIZEOF(ulong);
+
 TRACE_EVENT(xen_mc_entry,
 	    TP_PROTO(struct multicall_entry *mc, unsigned nargs),
 	    TP_ARGS(mc, nargs),
@@ -40,8 +42,8 @@ TRACE_EVENT(xen_mc_entry,
 		    ),
 	    TP_fast_assign(__entry->op = mc->op;
 			   __entry->nargs = nargs;
-			   memcpy(__entry->args, mc->args, sizeof(unsigned long) * nargs);
-			   memset(__entry->args + nargs, 0, sizeof(unsigned long) * (6 - nargs));
+			   memcpy(__entry->args, mc->args, sizeof(ulong) * nargs);
+			   memset(__entry->args + nargs, 0, sizeof(ulong) * (6 - nargs));
 		    ),
 	    TP_printk("op %u%s args [%lx, %lx, %lx, %lx, %lx, %lx]",
 		      __entry->op, xen_hypercall_name(__entry->op),
@@ -122,6 +124,7 @@ TRACE_EVENT(xen_mc_extend_args,
 		      __entry->res == XEN_MC_XE_NO_SPACE ? "NO_SPACE" : "???")
 	);
 
+TRACE_DEFINE_SIZEOF(pteval_t);
 /* mmu */
 DECLARE_EVENT_CLASS(xen_mmu__set_pte,
 	    TP_PROTO(pte_t *ptep, pte_t pteval),
@@ -199,6 +202,8 @@ TRACE_EVENT(xen_mmu_pte_clear,
 		      __entry->mm, __entry->addr, __entry->ptep)
 	);
 
+TRACE_DEFINE_SIZEOF(pmdval_t);
+
 TRACE_EVENT(xen_mmu_set_pmd,
 	    TP_PROTO(pmd_t *pmdp, pmd_t pmdval),
 	    TP_ARGS(pmdp, pmdval),
@@ -226,6 +231,8 @@ TRACE_EVENT(xen_mmu_pmd_clear,
 
 #if CONFIG_PGTABLE_LEVELS >= 4
 
+TRACE_DEFINE_SIZEOF(pudval_t);
+
 TRACE_EVENT(xen_mmu_set_pud,
 	    TP_PROTO(pud_t *pudp, pud_t pudval),
 	    TP_ARGS(pudp, pudval),
@@ -241,6 +248,8 @@ TRACE_EVENT(xen_mmu_set_pud,
 		      (int)sizeof(pudval_t) * 2, (unsigned long long)__entry->pudval)
 	);
 
+TRACE_DEFINE_SIZEOF(p4dval_t);
+
 TRACE_EVENT(xen_mmu_set_p4d,
 	    TP_PROTO(p4d_t *p4dp, p4d_t *user_p4dp, p4d_t p4dval),
 	    TP_ARGS(p4dp, user_p4dp, p4dval),
-- 
2.9.4
