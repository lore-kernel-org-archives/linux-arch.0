Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:52032 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388260AbeGWO3f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:35 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 04/17] x86/smpboot: smp init nodelay and no flush caches before sleep
Date: Mon, 23 Jul 2018 21:20:24 +0800
Message-ID: <1532352037-7151-5-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132024.gBxXUjvD3cQUG3XZrNUYF5olEL5fEC3sEpKTKI5RmsA@z>

Dhyana use no delay in smp_quirk_init_udelay(), and return in
mwait_play_dead() as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/smpboot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index db9656e..26cb2c9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -658,6 +658,7 @@ static void __init smp_quirk_init_udelay(void)
 
 	/* if modern processor, use no delay */
 	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
+	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
 		init_udelay = 0;
 		return;
@@ -1574,7 +1575,8 @@ static inline void mwait_play_dead(void)
 	void *mwait_ptr;
 	int i;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 	if (!this_cpu_has(X86_FEATURE_MWAIT))
 		return;
-- 
2.7.4
