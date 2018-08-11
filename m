From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 10/17] x86/events: enable Hygon support to PMU infrastructure
Date: Sat, 11 Aug 2018 21:28:32 +0800
Message-ID: <1d46c534b84f6e191ac840050ce5c0ea51c241a5.1533989493.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-arch.vger.kernel.org

Hygon PMU arch is similar to AMD Family 17h. To support Hygon PMU, the
initialization flow for it just call amd_pmu_init() and change PMU name
to "HYGON". To share AMD's flow, add code check for Hygon family ID 18h
to run the code path of AMD family 17h in core/uncore functions.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/events/amd/core.c   |  6 ++++++
 arch/x86/events/amd/uncore.c | 15 ++++++++++-----
 arch/x86/events/core.c       |  4 ++++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c84584b..6c13c9d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -669,6 +669,12 @@ static int __init amd_core_pmu_init(void)
 		 * We fallback to using default amd_get_event_constraints.
 		 */
 		break;
+	case 0x18:
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+			pr_cont("Fam18h ");
+			/* Using default amd_get_event_constraints. */
+			break;
+		}
 	default:
 		pr_err("core perfctr but no constraints; unknown hardware!\n");
 		return -ENODEV;
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 981ba5e..9f2eb43 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -507,17 +507,22 @@ static int __init amd_uncore_init(void)
 {
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
-	if (boot_cpu_data.x86 == 0x17) {
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	     boot_cpu_data.x86 == 0x17) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
+	     boot_cpu_data.x86 == 0x18)) {
 		/*
-		 * For F17h, the Northbridge counters are repurposed as Data
-		 * Fabric counters. Also, L3 counters are supported too. The PMUs
-		 * are exported based on  family as either L2 or L3 and NB or DF.
+		 * For AMD F17h or Hygon F18h, the Northbridge counters are
+		 * repurposed as DataFabric counters. Also, L3 counters
+		 * are supported too. The PMUs are exported based on
+		 * family as either L2 or L3 and NB or DF.
 		 */
 		num_counters_nb		  = NUM_COUNTERS_NB;
 		num_counters_llc	  = NUM_COUNTERS_L3;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5f4829f..93e026b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1776,6 +1776,10 @@ static int __init init_hw_perf_events(void)
 	case X86_VENDOR_AMD:
 		err = amd_pmu_init();
 		break;
+	case X86_VENDOR_HYGON:
+		err = amd_pmu_init();
+		x86_pmu.name = "HYGON";
+		break;
 	default:
 		err = -ENOTSUPP;
 	}
-- 
2.7.4
