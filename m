Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E490472520
	for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933024; cv=none; b=Gr8aVAzxQ+gTma70fLsWLU5UnE/lxBvq9wAn8zZzlbMC6QIhJGVc+2Ia0wQXavCI95qJaWBnXRxrX3gryjF8qL3Q+MwNgzC3Z0kzBJtpjXPFPOUAjqGLWB1f2Axs+gDPQIIbW4R5Wxp5E67+wMnHXCgoGL/2y797aSauvxWQgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933024; c=relaxed/simple;
	bh=VA+J8gVgQJjXgqa1KyYAn5D2Rm8bdS8GTWaA8o/nJp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWFtK6zb1POUMCk/sZEeJsAqgUpA0CHGHjEL7dmtLrwnb0fOX75Eo/0ZZst6wc+5Qdcp9F9gfha5UqMWlCAUOs4N/wYxIItOC8Hmu3CqwDyLAaaW3yrv+RXL9SWimtUJiiJ15THpJ9D9BAOPYqx4vnSqkFrfamkRyJI/T4YtLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OnxKCQgg; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OnxKCQgg"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4aae314aso1691048d50.3
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2026 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933021; x=1790537821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S731x7B1q5+LU0uMImlSdu51MYq8nznsZeZCtyZbDcY=;
        b=OnxKCQggUjQqoznbKxu09+qRorCvxffDk3SmFn527NA55cWPRdy/PScEVe9s3Buus3
         1Jp5qS6lg0T4urvb21OzMTgXlVebEkisSXt9ByokhpX+VL5ENTLCQCnV+afhh872YCQw
         exl+pBgBaT2deItwcBfgubRkxvt3F9703kqhFLXEZfcT3C9tijVHKNkG3fm63QrTtKnv
         f6CDvHmUdT6CxWdcoZthyBd1tKjoEN9lj+kDjEj/SQ7A6B32L6mVp4MeAUUB9BlqZtpZ
         Knzj/BwL0Et3K8nbwFbktaEpI9/e12TFDd96oXXQLFDJCb4pfXWN+55ehtaNEk0OvuIQ
         EQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933021; x=1790537821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S731x7B1q5+LU0uMImlSdu51MYq8nznsZeZCtyZbDcY=;
        b=nZu0T5Ct3wnZlaHFcT8OgT0GP5tp3KqJ4z5SOqdIvOZMRd676uL/fq1bysXiq1bPRZ
         cyyDpYwsQzXicR79uAJ2of4QX1vUmt1bRIT+AMnY8sSnbgKe5m2/3UULqwsutbnsMdMm
         wpPHmmyabRDoykw6WT130N+1Wfa3xAo0HHxCSJKEsGtNu47YTAlpE2vhyZLXwwg/EuhW
         qBM5LXs3JX68/+UgOBQvYA5ne98bp2/SyU1IZxaF1/+hEskRvyHu2eGiGN25lNMZrx42
         BEpi73d+bO6/1rlHyRyGPSkPp/9XhI7PWS2MV/R3w9g8CQBfLUCOXWHDPm26bAP5pu5c
         bZBQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeoGSM/TDqguVOAn6JMuwAng0cE94nsZHKGub1QlAVOerKvHwqjzG8jDwKC8WrhPacYC2t2xyBOlwo@vger.kernel.org
X-Gm-Message-State: AFuF++luWkaFw0H2ZGsebuZO6XF4g3396pFc3iVRQ0neU7kdjok0+sUk
	Mz9F0UUpiSBWBeS4sHXa7NoLIMpAGjfUgGX2vVzTRLLZA5BUcLCMqA/SxSUcErTDfAc=
X-Gm-Gg: AYBFou2fGpX3wVbRrF1llf0uAyEddJDs1SCBH2mFd8vLyYoDJUlByeZcuO3x0B1Vb9X
	j+iXCYCr9I4uGAZzNHlnLizn5xrrtjioIOFG2aUhuBjdnrToJq0bL1zPyaAcDiPw1XxB+xwoJEc
	wypsAQeXUtbKKwsjoqWqqf7+dzuOU6hZio34qUPtWUCQ1jlMljrBm25KTApkI/SuzMo76Kb1AIb
	fu7rXv8clz6oskXg4GRURXNwqrxyTLGBpX3OeojLr9v127LfPcHxaYRnXnUHlMjH0UL0p2Z1YVn
	6yCCfDVYFGWZGC+10qZ5dm5B3Y2fDDUvfb6AYjEVLM6H9XLzfA4psXN+hKaOpmHI31rdQQukoHg
	uHzJC/dxvYI5P+mDjXId3+pkAEWleen3fBI29jQ0ZZNhL6MM1iy6uEEUpCRZ1hAdPwz2ANfKBN3
	biwzTQLVg7TgVgaxx39XACz6Q6YmMLmcwSPXn72+8J1tSykSI0BPAq3zM04g6XaR7HslXRdZpN8
	/V+gtKjudatItGQmlVTEQjabI8VQ8novqrOg4yEBVwTwp4WpxwSChCy/rOfnwf61ororEP/lXQS
	jDWGHhPT5JZqIopbFUs=
X-Received: by 2002:a05:690e:11c7:b0:672:a2ee:6155 with SMTP id 956f58d0204a3-672a2ee6b7cmr1008959d50.45.1789933021253;
        Sun, 20 Sep 2026 12:37:01 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67299146eb0sm2607555d50.21.2026.09.20.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:00 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 01/46] KVM: luo: Delegate VM creation type to kvm_arch_vm_luo_preserve
Date: Sun, 20 Sep 2026 15:36:05 -0400
Message-ID: <20260920193650.3373435-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the architecture-specific #ifdef ladder setting ser->type in
kvm_luo_preserve(). Leaving ser->type zero by default allows
kvm_arch_vm_luo_preserve() to populate the architecture-defined VM
creation flags without referencing unexported architecture symbols in
generic KVM code.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 virt/kvm/kvm_luo.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_luo.c b/virt/kvm/kvm_luo.c
index 025b53151b6a..b3bd9bebe17a 100644
--- a/virt/kvm/kvm_luo.c
+++ b/virt/kvm/kvm_luo.c
@@ -73,16 +73,13 @@ static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
 	if (IS_ERR(ser))
 		return PTR_ERR(ser);
 
-#if defined(CONFIG_X86)
-	ser->type = kvm->arch.vm_type;
-#elif defined(CONFIG_ARM64)
-	ser->type = kvm_phys_shift(&kvm->arch.mmu);
-	if (kvm_vm_is_protected(kvm))
-		ser->type |= KVM_VM_TYPE_ARM_PROTECTED;
-
-#else
+	/*
+	 * @type is the argument the new kernel will pass to KVM_CREATE_VM, and
+	 * only the architecture knows how to spell it.  kvm_arch_vm_luo_preserve()
+	 * fills it in; leaving it zero here is the right answer for an
+	 * architecture that does not implement the hook.
+	 */
 	ser->type = 0;
-#endif
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
@@ -115,7 +112,6 @@ static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
 	kvm = file->private_data;
 
 	args->file = file;
-	kho_restore_free(ser);
 
 	kvm_uevent_notify_vm_create(kvm);
 	return 0;
@@ -147,11 +143,7 @@ static void kvm_luo_finish(struct liveupdate_file_op_args *args)
 {
 	struct kvm_luo_ser *ser;
 
-	/*
-	 * If retrieve_status is true or set to error, nothing to do here.
-	 * Already cleaned up in kvm_luo_retrieve().
-	 */
-	if (args->retrieve_status)
+	if (args->retrieve_status < 0)
 		return;
 
 	if (!args->serialized_data)
-- 
2.55.0.1082.g2b9226bbc0-goog

