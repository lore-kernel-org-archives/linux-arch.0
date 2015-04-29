From: David Howells <dhowells@redhat.com>
Subject: [PATCH 04/13] Make cpumask functions that return boolean values
 return bool
Date: Wed, 29 Apr 2015 20:21:57 +0100
Message-ID: <20150429192157.24909.64940.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbbD2TWB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Apr 2015 15:22:01 -0400
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org

Make cpumask functions that return boolean values return bool so that gcc can
make better choices.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/cpumask.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 27e285b92b5f..7afeb854d349 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -289,9 +289,9 @@ static inline void cpumask_clear_cpu(int cpu, struct cpumask *dstp)
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in @cpumask, else returns 0
+ * Returns true if @cpu is set in @cpumask
  */
-static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
+static inline bool cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
 {
 	return test_bit(cpumask_check(cpu), cpumask_bits((cpumask)));
 }
@@ -301,11 +301,11 @@ static inline int cpumask_test_cpu(int cpu, const struct cpumask *cpumask)
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in old bitmap of @cpumask, else returns 0
+ * Returns true if @cpu is set in old bitmap of @cpumask
  *
  * test_and_set_bit wrapper for cpumasks.
  */
-static inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
+static inline bool cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_set_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
@@ -315,11 +315,11 @@ static inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in old bitmap of @cpumask, else returns 0
+ * Returns true if @cpu is set in old bitmap of @cpumask
  *
  * test_and_clear_bit wrapper for cpumasks.
  */
-static inline int cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
+static inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *cpumask)
 {
 	return test_and_clear_bit(cpumask_check(cpu), cpumask_bits(cpumask));
 }
