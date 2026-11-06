Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931834;
	b=OqqxFJEan33WH8hBBWc2SNZu7gUrY3cuFgKj54awM7JkOXz/6o6BWcSbo7niu6DHWpHe
	 kXxmbj7V7W3ehVY397OH7tMUd0nSqa2772Mtv1Y2cu0exjC/eW3wR/NUQfFYJ/aUvRtbn
	 PExCoGDhtSV65aLsiFqfXJjE4aaYf3frrCBmmAlzrBYYYSWpX/zYKPyIYSRv63DMjiXbT
	 5HXUS3uF3BxpJo5DcONAdGZQRCw2Vw62vFQJRDrERkzqReIESYXR9MDswWeq8QAwiujw5
	 gRq8mjjSGU7flt7sHo4G7ddV7xMmdH2l4xtC5zDlqmfx/vT4m7sJe0eiJNRQw9ZQ7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931834;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=EqPr/ub5T0mzU8emv4xapSnt/P45Vwy++DCDHCbXLNg=;
	b=pddVxSnyMoiLDMMiFpKMWMvkzdFiTFLGPXbl4IGDuDIG6TQ3lg9aXw8cOn1rR5mrzEiH
	 +OYreHC7wmYunkxmgd/UeV6mFRwHfDDSeAE6sSkuw+v3dv6IA61IEmXLJYG4cHzew9Qy3
	 +2NEzbstIYjWcAttqllG2J2WLq5l/T5PMEt0HzacwK1mxJ31ngDnnEHDQ6bmrd0NWmGo8
	 ClycsDWfxk2l+vvOUUeCkQhgO0pc5gMFBjmzkO1wR9eAzXegUb4JfFpUrUqxNp5pPAYVh
	 fYWazA14IhFqPri2nZvnAWxzlHbGInWtxeLU4RU3q0SKuhjpf4Um+hP6Ul7oNEad+NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=CrtDVoNl;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920B606A329;
	Fri,  6 Nov 2026 02:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2920B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=CrtDVoNl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=EqPr/ub5T0mzU8emv4xapSnt/P45Vwy++DCDHCbXLNg=; t=1793931832; x=2109291832; 
	b=CrtDVoNlomRhP2GUzVkbihlu2XlFjZr+DNscjx/xCVa5eU0GkKDE7tLQgvJabLMxcB7HMZlDQKz
	BfYKo+iEXkghvLdcH331WdLiEPyp7y4XISDxYgPClK4bP20G1s8SQFHhvftfZHcvbNTiOTQz03xVb
	UNe+yJtMBTzY+fLCtkm5O2hO7kazFARaIULNUbijZ3fLBek5RTPWog1JzQ16Fb+k7/ZX9dbw8cvVF
	ouuqjyri2/R7oA7k3VZzPc0leg7DH4fUInBGos0OESB+1u5uvRxsIxH3WvNFN5F0IH1KtFzyY9/ly
	ldI4Qn8e2agl+i9XpkomODU+vbYuSwSeYYMA==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP9cF-003xm9-4Z; Fri, 06 Nov 2026 03:23:43 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 23:23:42 -0300
Subject: [PATCH v10 1/3] arm64: vdso: Split native/compat mremap callbacks
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-tonyk-robust_arm-v10-1-366ed4a3435b@igalia.com>
References: <20261105-tonyk-robust_arm-v10-0-366ed4a3435b@igalia.com>
In-Reply-To: <20261105-tonyk-robust_arm-v10-0-366ed4a3435b@igalia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>, 
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

From: Mark Rutland <mark.rutland@arm.com>

Currently the native and compat VDSOs share a common vdso_mremap()
function which is used as their vm_special_mapping::mremap callback.

In subsequent patches the native and compat VDSOs will need distinct
mremap logic, which will be easier to manage with separate functions.

Give the compat VDSO its own aarch32_vdso_mremap() function. For now
this is identical to vdso_mremap().

At the same time, fix the odd whitespace in the vdso_mremap() prototype.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arm64/kernel/vdso.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 50596dab23f9..7cafa8208ef1 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -57,7 +57,7 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
 };
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
+		       struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
 
@@ -161,6 +161,14 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+			       struct vm_area_struct *new_vma)
+{
+	current->mm->context.vdso = (void *)new_vma->vm_start;
+
+	return 0;
+}
+
 static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_VECTORS] = {
 		.name	= "[vectors]", /* ABI */
@@ -173,7 +181,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = vdso_mremap,
+		.mremap = aarch32_vdso_mremap,
 	},
 };
 

-- 
2.56.0

