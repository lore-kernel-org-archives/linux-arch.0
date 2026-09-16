Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C623A9622
	for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535162; cv=none; b=fO/10C6GfR8H62ABoSv/By2K1NoWDjEXO1XmxbLBNQVA3cf6sTJ2baRlrM9l3dZjrQLOD+lQ0Ou3sHa1QrLNIxXrrsfLh6RM1DnAazO7R/Y1nSP2aCqnf1QCbXyovuqwlfmfb9NRgGhd2EV907v6gO6TFVZbVkBES/TnNfKm9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535162; c=relaxed/simple;
	bh=ZCYsk3b8be7YzwPtZc9AlEHE3JpuvSauytIqzViEWP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRHe0nFT9gQU997lOdQ10uNGKooixiZtmvmsJ1VfBYlPRmB0/1HHoc+YXTES2XyAnz847p3p7ukXE8qVmOvGyR5asTFY3e5bg3bjkjSF8W8URnhSPdF/DbEdfKct+RCIKOldLpgmySvV5eLiwVd2YA4ISgP5CGXXGL5IR46PeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YW777VKk; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YW777VKk"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2d942c7cc2fso44665235ad.3
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 22:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535161; x=1790139961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEqGUwhuGtd/IQ00br0ru4/E+DR8RR02AnrUv6Zwxpk=;
        b=AyUo9LHCXrU4JImDbDjl7WdA2jo4nt1Pw9ad+4h4/JwxEWcXNaovnajpY1RxS1GSnG
         cXiM+tXpiv0RAMiX5f2mUg2k15L2xHA4vTdorJfTiyvBZT+f/eeyl0INt9CGmTTBmXHt
         rf9hy6F4p2l5JgXukAN911ofg9YjVkjrGvmQlsPgKMbaxwMfDzuoR4yCrA4J8uhPfygQ
         KOCa2fBgYA9b2tkeXxVUqGHGN9FYcH+JcdBoKxKgMmbV7FjVXS7HKrmHZ3fbOwrJ0Wm2
         v0DAkftJPJTjEkc987FYk2jE9ANtNuAtwb1JBOwMu/pjbiirCGeL0Imujp4yIqdkgv8H
         /WVw==
X-Forwarded-Encrypted: i=1; AKwUvBzsSFYemBOqAuqnQo6GhhPMoSkbeh8wGpa+kQoekId+t3r77k5V2HBVZo0o4cYqFLDVkVIRiY+L9thF@vger.kernel.org
X-Gm-Message-State: AFuF++mMtOasvTNx8YRR9w0NyPcgbJTqJovSwV8zdEa7Jx54imB5/Ccn
	BBKVMEm/7xcZKbfIChuo1sTWQ/CMFGWYRRPcQb+lg4Vs35GGK4Yc4kK8/2v+XccAjPxARjH5AQ7
	Q0a0XZlllJnaJ0Xd8e69xpFPJPmo6xEQct8uS0YFzM9McllE/vueSDItSthZ6dFvpCXNuJT0Orh
	JMwIaaIa/Qbj8EjVO0q9ZjmwYfaZfm1b/QmHG5vF/xdskfvoxI93FbYl7DvLMN59BzUxsJfHY6f
	JyMg5rTrx1Aew==
X-Gm-Gg: AYBFou1kvvi2MWuFkkHqpNINAALycz6j+4ctHzPP2YLAwPCyA5sPG5K8OUHk4nHfQAO
	z0QdbVnlBhD5/fEu0PgkxIRodgqJgWyA2DnuluEYYV0Ib6DQbeWjZJq7rQgAbUP9BApNEYzrJ+G
	i4py+6D/iFI+gqSOGSXw1D7UDlJZC553ub/TA+EEpruKx/kGBU30gvGK7w3sevhIqV1s+tI3DLD
	Z9YyVntW6WJrjOJ7kRsUI1pB996CfTuNCJOiAIpet0uKWAU+8gp6ptitXuCLf75SroEAl/GxXlV
	hLD7DJXSaf+FrT4l4wPF6gYfRFwusoYwF7YiBQ78NWKD4k7/UtVr/+bRg/qEv1ixpvBcrD78f0/
	rICM3lMFpg9gJOa0qRgpxuCI4Y0yrS1Syj7oWgeMd5veTt8ntxTvrYq8NuKRpZdg+f5mlITJ7Os
	3w9X0e/yIuxZk4/heOJwTyV8Hrue4QC4S+
X-Received: by 2002:a05:6a00:1496:b0:84f:77cc:63cd with SMTP id d2e1a72fcca58-87239893a7cmr2166166b3a.17.1789535160548;
        Tue, 15 Sep 2026 22:06:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-87200f5118csm423110b3a.5.2026.09.15.22.05.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:06:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso4451283a12.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2026 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789535158; x=1790139958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qEqGUwhuGtd/IQ00br0ru4/E+DR8RR02AnrUv6Zwxpk=;
        b=YW777VKkuthOhJll13Vfzz2TFuo7Dg4wmScpv2bjhDyzJ/f/p/MOQx8huOil4+PGWN
         WtMxrZuFv75DzHRdMmW8yrE7IHNh9G3HDENQQC02VhyktO6g++ZPQ8J/0inkvJ4CgURj
         R07zG3rTlx/SnJGV0+elbsCoqb3Xe0YjId85M=
X-Forwarded-Encrypted: i=1; AKwUvBzVuoNzLQ/tuEjbTK6qftTLuwvVOBA/1U7DSnQx+YbdkNJPDWWAqtG+633lI6TgMZP3cYivKGdGdSk1@vger.kernel.org
X-Received: by 2002:a05:6a21:1343:b0:3da:80a1:f2f with SMTP id adf61e73a8af0-3dd5f5dfd69mr2927546637.14.1789535158375;
        Tue, 15 Sep 2026 22:05:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:1343:b0:3da:80a1:f2f with SMTP id adf61e73a8af0-3dd5f5dfd69mr2927490637.14.1789535157892;
        Tue, 15 Sep 2026 22:05:57 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm3951386eec.15.2026.09.15.22.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:05:56 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 2/2] x86/vmware: Decrypt steal-time storage before sharing it
Date: Wed, 16 Sep 2026 01:05:40 -0400
Message-ID: <bbdb89067cd07d07fe4963ad229932faf87b0ef9.1789488039.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789488039.git.zack.rusin@broadcom.com>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware's steal-time counter must be in shared memory so the host can
update it. Encrypted guests currently register its address without
decrypting the storage. Move their setup to an early initcall, when the
memory allocator is available for page-table splitting, but before
secondary CPUs start. Leave ordinary guests' setup unchanged.

Convert every possible CPU's storage before registering any address.
Zero each object after conversion, since its contents may not survive
conversion and the host initializes only the counter. Register the boot
CPU with preemption disabled; the existing hotplug callbacks handle the
others. If conversion or boot-CPU registration fails, attempt to re-encrypt
all affected ranges, including a partially converted failing range, and
disable steal time.

TDX's conversion path requires directly mapped memory. Check all per-CPU
objects before converting anything, and disable steal time if a TDX guest
uses the page per-CPU allocator, which supplies vmalloc mappings. This
also covers automatic fallback from the embedded allocator. AMD guests
are unaffected by this restriction because their conversion path supports
those mappings.

Link: https://lore.kernel.org/r/20260309235250.2611115-5-alexey.makhalov@broadcom.com
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Co-developed-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/kernel/cpu/vmware.c | 96 +++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 34b73573b108..f49898275d87 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -25,14 +25,19 @@
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/clocksource.h>
+#include <linux/cc_platform.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
+#include <linux/mm.h>
+#include <linux/preempt.h>
 #include <linux/reboot.h>
+#include <linux/set_memory.h>
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
+#include <asm/cpufeature.h>
 #include <asm/cpuid/api.h>
 #include <asm/timer.h>
 #include <asm/apic.h>
@@ -147,6 +152,7 @@ static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static bool vmw_sched_clock __initdata = true;
 static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, vmw_steal_time) __aligned(64);
 static bool has_steal_clock;
+static bool vmw_steal_time_ready;
 static bool steal_acc __initdata = true; /* steal time accounting */
 
 static __init int setup_vmw_sched_clock(char *s)
@@ -280,7 +286,9 @@ static void vmware_disable_steal_time(void)
 
 static void vmware_guest_cpu_init(void)
 {
-	if (has_steal_clock)
+	if (has_steal_clock &&
+	    (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
+	     vmw_steal_time_ready))
 		vmware_register_steal_time();
 }
 
@@ -325,6 +333,92 @@ static int vmware_cpu_down_prepare(unsigned int cpu)
 }
 #endif
 
+static void __init vmware_steal_time_range(int cpu, unsigned long *start,
+					   int *numpages)
+{
+	unsigned long addr = (unsigned long)per_cpu_ptr(&vmw_steal_time, cpu);
+
+	*start = addr & PAGE_MASK;
+	*numpages = DIV_ROUND_UP(offset_in_page(addr) +
+				 sizeof(struct vmware_steal_time), PAGE_SIZE);
+}
+
+static int __init vmware_decrypt_steal_time(void)
+{
+	int cpu, failed_cpu, numpages, ret;
+	unsigned long start;
+
+	if (!has_steal_clock ||
+	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return 0;
+
+	/*
+	 * TDX's conversion callback derives the physical range with __pa(),
+	 * so the storage must live in the direct map. The page per-CPU
+	 * allocator, which is also the automatic fallback when the embedding
+	 * allocator fails, hands out vmalloc addresses instead. Reject those
+	 * before converting anything, so no page is left converted.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+		for_each_possible_cpu(cpu) {
+			if (!is_vmalloc_addr(per_cpu_ptr(&vmw_steal_time, cpu)))
+				continue;
+
+			pr_warn("steal time disabled: TDX requires a direct mapping\n");
+			has_steal_clock = false;
+			return 0;
+		}
+	}
+
+	for_each_possible_cpu(cpu) {
+		vmware_steal_time_range(cpu, &start, &numpages);
+		ret = set_memory_decrypted(start, numpages);
+		if (ret) {
+			failed_cpu = cpu;
+			goto rollback;
+		}
+
+		/*
+		 * Conversion need not preserve the zeroes. The host
+		 * initializes only the counter on enable, so the guest
+		 * must initialize the reserved words itself.
+		 */
+		memset(per_cpu_ptr(&vmw_steal_time, cpu), 0,
+		       sizeof(struct vmware_steal_time));
+	}
+
+	vmw_steal_time_ready = true;
+	preempt_disable();
+	vmware_guest_cpu_init();
+	preempt_enable();
+	if (!has_steal_clock) {
+		pr_warn("failed to register boot CPU steal-time memory\n");
+		failed_cpu = nr_cpu_ids;
+		goto rollback_pages;
+	}
+	return 0;
+
+rollback:
+	pr_warn("failed to decrypt steal-time memory for CPU %d: %d\n",
+		failed_cpu, ret);
+
+rollback_pages:
+	for_each_possible_cpu(cpu) {
+		vmware_steal_time_range(cpu, &start, &numpages);
+		ret = set_memory_encrypted(start, numpages);
+		if (ret)
+			pr_warn("failed to re-encrypt steal-time memory for CPU %d: %d\n",
+				cpu, ret);
+		if (cpu == failed_cpu)
+			break;
+	}
+
+	vmw_steal_time_ready = false;
+	has_steal_clock = false;
+	return 0;
+}
+early_initcall(vmware_decrypt_steal_time);
+
 static __init int activate_jump_labels(void)
 {
 	if (has_steal_clock) {
-- 
2.53.0
