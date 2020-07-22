From: David Brazdil <dbrazdil@google.com>
Subject: [PATCH 7/9] kvm: arm64: Mark hyp stack pages reserved
Date: Wed, 22 Jul 2020 17:44:22 +0100
Message-ID: <20200722164424.42225-8-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbgGVQpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B2C0619DC
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so2553791wru.6
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:12 -0700 (PDT)
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, kernel-team@google.com, David Brazdil <dbrazdil@google.com>

In preparation for unmapping hyp pages from host stage-2, allocate/free hyp
stack using new helpers which automatically mark the pages reserved.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0700c3d21b23..dc557b380c87 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1451,13 +1451,58 @@ static int init_subsystems(void)
 	return err;
 }
 
+/*
+ * Alloc pages and mark them reserved so the kernel never tries to
+ * take them away from the hypervisor.
+ */
+static unsigned long alloc_hyp_pages(gfp_t flags, unsigned int order)
+{
+	struct page *page;
+	unsigned long i;
+
+	page = alloc_pages(flags, order);
+	if (!page)
+		return 0;
+
+	for (i = 0; i < (1ul << order); ++i)
+		mark_page_reserved(page + i);
+
+	return (unsigned long)page_address(page);
+}
+
+static unsigned long alloc_hyp_page(gfp_t flags)
+{
+	return alloc_hyp_pages(flags, 0);
+}
+
+/*
+ * Free pages which were previously marked reserved for the hypervisor.
+ */
+static void free_hyp_pages(unsigned long addr, unsigned int order)
+{
+	unsigned long i;
+	struct page *page;
+
+	if (!addr)
+		return;
+
+	page = virt_to_page(addr);
+	for (i = 0; i < (1ul << order); ++i)
+		free_reserved_page(page + i);
+}
+
+static void free_hyp_page(unsigned long addr)
+{
+	return free_hyp_pages(addr, 0);
+}
+
 static void teardown_hyp_mode(void)
 {
 	int cpu;
 
 	free_hyp_pgds();
 	for_each_possible_cpu(cpu)
-		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_hyp_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
 }
 
 /**
@@ -1481,7 +1526,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		unsigned long stack_page;
 
-		stack_page = __get_free_page(GFP_KERNEL);
+		stack_page = alloc_hyp_page(GFP_KERNEL);
 		if (!stack_page) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.27.0
