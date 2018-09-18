From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 05/20] signal/x86: In trace_mpx_bounds_register_exception add __user annotations
Date: Tue, 18 Sep 2018 02:05:31 +0200
Message-ID: <20180918000546.12552-5-ebiederm@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The value passed in to addr_referenced is of type void __user *, so update
the addr_referenced parameter in trace_mpx_bounds_register_exception to match.

Also update the addr_referenced paramater in TP_STRUCT__entry as it again
holdes the same value.

I don't know why this was missed earlier but sparse was complaining when
testing test branch so fix this now.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/include/asm/trace/mpx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/trace/mpx.h b/arch/x86/include/asm/trace/mpx.h
index 7bd92db09e8d..54133017267c 100644
--- a/arch/x86/include/asm/trace/mpx.h
+++ b/arch/x86/include/asm/trace/mpx.h
@@ -11,12 +11,12 @@
 
 TRACE_EVENT(mpx_bounds_register_exception,
 
-	TP_PROTO(void *addr_referenced,
+	TP_PROTO(void __user *addr_referenced,
 		 const struct mpx_bndreg *bndreg),
 	TP_ARGS(addr_referenced, bndreg),
 
 	TP_STRUCT__entry(
-		__field(void *, addr_referenced)
+		__field(void __user *, addr_referenced)
 		__field(u64, lower_bound)
 		__field(u64, upper_bound)
 	),
-- 
2.17.1
