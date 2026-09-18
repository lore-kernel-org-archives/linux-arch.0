Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A434402B;
	Fri, 18 Sep 2026 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789691256; cv=none; b=GHlvAXYpwDEfAWVGYPbcHtYbTDUisXow8JJhih+q2NQnfB4AZS72zrQcbm2Ds9es70fbmP+ijTd4h8SvooKbQLOhFxqtE3xMDSkTDHq1ObCSnpHfC6DkiG/eGFSBDv+A07ZwNSvOa/IG2J0R1OxZ9rofSd0BSlaUU7OOBySaY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789691256; c=relaxed/simple;
	bh=XilMisU5+p6oEp17zSrE2tM3KClck2J9FqG4mWzxr9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LzJd1CX3S/8AzVkckPOFh1/D/sS/BeG8UymeYlHIuWVectjsWI2oZo1wtmgRckMameLf0zz54mZ6PNZv8MktTPyzgL3xrRwULiq96kc4E5G5Yt/p5ZvSnBcOyFVFdSgr6C67a/IbgYDSRLiFP5KySh3eXhF8Bj3Lm33LYlAuYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DGgTvue0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DGgTvue0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=AAJVlL7V3Svw6ebZPQuFtG6AvhLc+t5u5Nl4UBUE390=; b=DGgTvue0enzvlX3BmKWcCiF8LK
	RRQ+UBBCuqUVMaFZsWn9M8ob8JJbON6YWl9/kR7+lmO6Rtu/2VHdHVODbQih6o0TRj2PmalaldDuh
	bkxnPqdwr393dG7G3z0dxw4b5KA5sOLkMKBDCuq3l7BQsGkHbgR1zyPUjipyThRx42yuQFS2WvLPl
	saSP3K5cBabKp2xztD0RKw1kwTcknJKqwE2CseeOO4rV58LsPpekCP9u00kSbgckEo8zoV8tINNGr
	H+tyBzofp+10Ww0uXhey4KwixnZi5WmhziYlKuSiA2B1N335dyY5NqAgW73+f6WsQo6ba/IDm+A4J
	tv4XIa6g==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7MRl-003iDv-9y; Fri, 18 Sep 2026 02:27:21 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Sep 2026 21:26:59 -0300
Subject: [PATCH v9 1/3] arm64: vdso: Split native/compat mremap callbacks
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-tonyk-robust_arm-v9-1-ab082b1b4c4b@igalia.com>
References: <20260917-tonyk-robust_arm-v9-0-ab082b1b4c4b@igalia.com>
In-Reply-To: <20260917-tonyk-robust_arm-v9-0-ab082b1b4c4b@igalia.com>
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
index 592dd8668de4..089a70d96220 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -58,7 +58,7 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
 };
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
+		       struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
 
@@ -162,6 +162,14 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
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
@@ -174,7 +182,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = vdso_mremap,
+		.mremap = aarch32_vdso_mremap,
 	},
 };
 

-- 
2.55.0

