Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F083E3176
	for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2026 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654619; cv=none; b=enEKI24JUNR+GeZ6q0jo016h8zs3wgNwj3M4YF668dBrk8zz6LiPVj4y6RJm6ckSIiAthCzJqyUkEx4UqQyAUjKeAA1gn+u78sVr54V+sW24PFoy59/CpDFnOVU3sRf8TQhRFVOH5hcpRIifcXdn3X7nQRQBvIQ24mxCqhwgZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654619; c=relaxed/simple;
	bh=rUzQo5KHgL8B6Zt2JDNYEUTyvIMbiqzpi4ZnuUlZBBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3z0+hxvyGSgjbubzRCvat6jAItzu7HjBJdiDLOTuII5vCWlXIOWiII9id5P+jJEbEihE4C4/GQIAbvcVAIb+k3kpcyx/avbEhCD9AS3Dfs6fktCSCvVh9PfPjyCsSL4a75xSBoleOhF4gn0rfNLmPZP5bSmhSKbTLEr8wA5wT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bjNTJ6w2; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bjNTJ6w2"
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-77bf892b496so95561137.0
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654615; x=1791259415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CV8TEMBP6IF+2lIlzYCpg42JpAwpPVBphnZX2jCaOFA=;
        b=Hvmpp2tRqYGjvCLJ9nsVk03nU8dtbDuvq8+SAHmWdUsgekLrz32KEQ2ZhcEwcNGvLY
         j2yuY9vwlRzaLIe9FLNoEXgkN3MkUoXsQZYqTPHE9v2UrlLHDAUkmLjaiaaNjP+Boxnj
         x3XRmiZpcIJbkez35vnrgO0z9cmaebe2nkOAvq6FGntd+OC3vk2hlcPIN27bGLvuMuCa
         OaqGiHT3HDGaA+ZAA76jVgc8wmmQJYtdWx9WqI/I7JqsH+HaHsqV9zK7yBf6fPs06Q5J
         B+KcdPU0xGPUzk0OOWz+/Qn8QLg9Kdk7jKIJPNB+1kMbPMIT723BFyFZMAP5iQvxSXG4
         l5Xw==
X-Forwarded-Encrypted: i=1; AKwUvBx9ix0x/VIskQhMSbIpI1vMMzxoEC91be3pNAoYcERTur/mXC09pmhIVW4h1Sc83OMWp12f5zNNcpTi@vger.kernel.org
X-Gm-Message-State: AFq9FYKfAZU+6s9o6b53cfhc3FKUWU6dtelOsFGINEzEeQcwBlr+gFAM
	M9nbBpmNoDzcYckxcIWmimS7/pefs0SLHrYAse1diLQRUd4Fnc+yLe1gBhx1w6isG+BlMAaHc1o
	nlrbJT9/hlDOUobmB+5Jz8PnujS/yhAev3fFtqw9Esj6wKc2YwX/0QW9fgkaT0KI8P3mAszLXuX
	vEdPk9/8Vxs1F82q0R3AmpJ0X7tcU3J3xvGHMJx1RCyX0RA0tb20gMYqFnEx+ozcl2aguO8/QrS
	QRSGa7JWw7sIA==
X-Gm-Gg: AYBFou08W9E1x9DjZcPU7Fj835gqJdu9TVpl8t8iTNJevJ1yui6pYFH0Fi0npeyotcf
	kbsi+uO7gsIp6yDfOCaFTEQuAc4o0sg7XfC9S37/szB1cEJP3p0qbXL3helsY1cUcRstnKNWJKj
	mFhtNjwEgaHi4BrNgtJl838poxVvt52Y99EWCEywvMdY55D35QEtsg6SyTX6TtqXpKvWa/bcxYt
	SYXIHwRzpTaBLf1tXnWkfq9ZbQKIqoTXoKbrmNTWQ+08xjv5b/zVJQhx5LFXHYubGaBeFWQdwFH
	e9pWT1tQWHI00AolpLbKege4Qg+MXbyXzBWk83Ez+jmhqBjyyvaxX0um7tg9uLCiJxt9oXjvdyb
	OH8eke+HhrxyuZb/nAkoEKp52IL5oqwr27O6cU+F9uWdfF860lvaIuHe46WiVECBDkgMUV/dzQM
	S4FOn6y/fY0wZ9kog6Wd0+xim81u4mj3Ws7jY=
X-Received: by 2002:a05:6102:5806:b0:7b4:bdf5:9307 with SMTP id ada2fe7eead31-7b4bdf5940cmr1627684137.30.1790654614565;
        Mon, 28 Sep 2026 21:03:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-986f069cb69sm641516241.10.2026.09.28.21.03.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so14197681eec.1
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2026 21:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654613; x=1791259413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CV8TEMBP6IF+2lIlzYCpg42JpAwpPVBphnZX2jCaOFA=;
        b=bjNTJ6w2pB+RY4tIwDLWRoyh1TKrkkXYnJifKxI+xNDRyGSYEEyzU0N9RA+k3C96ay
         vaJH3Uc2C7BTr+aeuOpbnzDtG1rLZuoXoQ9TZEm3yZzzX+cYXeIlE51x0XqJMlI+lXq0
         upWhIuZH+I939ODjwf+SW6xGOiFUHEmKFwSeY=
X-Forwarded-Encrypted: i=1; AKwUvBw2/52iIVxOPS5fUBQuFK8gCeJJI4bCDUgILwNT5yrSGPT375nw2yXFgicaFwIgPscZymdzU73ozxrW@vger.kernel.org
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr12611767eec.31.1790654612912;
        Mon, 28 Sep 2026 21:03:32 -0700 (PDT)
X-Received: by 2002:a05:7301:4d0b:b0:341:d191:b838 with SMTP id 5a478bee46e88-34272562bc0mr12611727eec.31.1790654612252;
        Mon, 28 Sep 2026 21:03:32 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:29 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 5/6] x86/tdx: Support early sharing of kernel data
Date: Tue, 29 Sep 2026 00:02:54 -0400
Message-ID: <20260929040256.543767-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Share pages before the page allocator is available, after both their
direct-map and kernel-image mappings have been made shared. Preserve
initial contents in a private scratch page, matching the AMD early helper,
and use the existing MapGPA path and shared-page accounting.

UP per-CPU data has an image alias. Drop shared image mappings before
kexec converts their backing pages to private through the direct map.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/coco/tdx/tdx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..4a683e9eafc3 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -4,6 +4,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt)     "tdx: " fmt
 
+#include <linux/cacheflush.h>
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
@@ -18,6 +19,7 @@
 #include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
+#include <asm/sections.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
 
 /* MMIO direction */
@@ -1006,6 +1008,23 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+static char tdx_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
+
+static int __init tdx_early_decrypt_page(unsigned long addr, unsigned long alias)
+{
+	void *buffer = __va(__pa_symbol(tdx_early_buffer));
+	int ret;
+
+	memcpy(buffer, (void *)addr, PAGE_SIZE);
+	clflush_cache_range((void *)addr, PAGE_SIZE);
+	early_set_page_decrypted(addr, alias);
+	ret = tdx_enc_status_change_finish(addr, 1, false);
+	if (ret)
+		return ret;
+	memcpy((void *)addr, buffer, PAGE_SIZE);
+	return 0;
+}
+
 /* Stop new private<->shared conversions */
 static void tdx_kexec_begin(void)
 {
@@ -1033,6 +1052,18 @@ static void tdx_kexec_finish(void)
 
 	lockdep_assert_irqs_disabled();
 
+	/* Drop image aliases before the direct-map walk makes pages private. */
+	addr = (unsigned long)_text;
+	while (addr < _brk_end) {
+		unsigned int level;
+		pte_t *pte = lookup_address(addr, &level);
+
+		if (pte && pte_decrypted(*pte))
+			set_pte(pte, __pte(0));
+		addr = (addr & page_level_mask(level)) + page_level_size(level);
+	}
+	__flush_tlb_all();
+
 	addr = PAGE_OFFSET;
 	end  = PAGE_OFFSET + get_max_mapped();
 
@@ -1160,6 +1191,7 @@ void __init tdx_early_init(void)
 	 */
 	x86_platform.guest.enc_status_change_prepare = tdx_enc_status_change_prepare;
 	x86_platform.guest.enc_status_change_finish  = tdx_enc_status_change_finish;
+	x86_init.paging.early_decrypt_page = tdx_early_decrypt_page;
 
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
-- 
2.53.0

