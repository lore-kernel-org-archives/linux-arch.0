Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E7F38E5DE
	for <linux-arch@vger.kernel.org>; Tue,  9 Jun 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998628; cv=none; b=JnSCtyQ/S2tauOxpcV98JTqDXBUUTuGslmMAKm3n9OqziTMdpL2M0XiVFQ2DznDOFWwbaPBmM111mnWYYShY7AXEWJNd+VEsxB7YinXAstCE0uJ9P3ov9q+AQHRObbKmzfC65I0nQoeRnXLYAmCSjgaVNPmnw2B+gm4BZzG+gVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998628; c=relaxed/simple;
	bh=yH+pJLV9DLLLfsLex3zDu02U5b1k2nz+bLLSPCtaa10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AreKB/KRLTAzBZJUgYYmfCHa4F1ECNxoaZJ+Kmaf/D5Mwd0o0Zjgyxi0ou+tYWu0pletX/cJMJ2he9LTGZjqPFOwv7i13GbsU+bk4dIeAl+VQYd/33S375iNkmj8/elonR34xrEIqEk/S3oJhc+00lDNcDF6tZK3A8PkEh3LvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJLJgWCR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJLJgWCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780998625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f8CmiU3sgUCl+h3h7HqmJr8vJwOTJcWXfSC0goNaROU=;
	b=fJLJgWCRiJ9KR1DhW6j4BmrOz0iaYMfeP0GQkMDM0Sh2XRISRwFC6MMKWsETRufnPRfhjw
	1Wd3J6TElTPE8192gDJBgoZ1I53rE4UUbg7Luq0Oq+16mn6xNd5mdGxo02g4p+Ps+HFM/Y
	fuwPBsW5XKrKp407aa8YpGriyUR8LAw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-XiocsaLxMzmr72nHBlMcZA-1; Tue,
 09 Jun 2026 05:50:21 -0400
X-MC-Unique: XiocsaLxMzmr72nHBlMcZA-1
X-Mimecast-MFC-AGG-ID: XiocsaLxMzmr72nHBlMcZA_1780998620
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2D0B1964CE5;
	Tue,  9 Jun 2026 09:50:19 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A595B3008B37;
	Tue,  9 Jun 2026 09:50:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule
Date: Tue,  9 Jun 2026 11:49:40 +0200
Message-ID: <20260609094941.56122-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

raw_res_spin_unlock_irqrestore() calls raw_res_spin_unlock() and then
restores interrupts, this means preemption is enabled when interrupts
are still disabled (as part of raw_res_spin_unlock()) so this cannot
trigger an actual preemption.
This is inconsistent with other spinlock implementations
(raw_spin_unlock_irqrestore() and bpf_res_spin_unlock_irqrestore()
itself).

Adjust the macro to ensure interrupts are enabled before enabling
preemption, allowing to schedule at that point. Make the same
modification in the error path of raw_res_spin_lock_irqsave().

Fixes: 101acd2e78b1 ("rqspinlock: Add macros for rqspinlock usage")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/asm-generic/rqspinlock.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 151d267a49..4d46643f46 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -243,12 +243,20 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 	({                                        \
 		int __ret;                        \
 		local_irq_save(flags);            \
-		__ret = raw_res_spin_lock(lock);  \
-		if (__ret)                        \
+		preempt_disable();                \
+		__ret = res_spin_lock(lock);      \
+		if (__ret) {                      \
 			local_irq_restore(flags); \
+			preempt_enable();         \
+		}                                 \
 		__ret;                            \
 	})
 
-#define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
+#define raw_res_spin_unlock_irqrestore(lock, flags) \
+	({                                          \
+		res_spin_unlock(lock);              \
+		local_irq_restore(flags);           \
+		preempt_enable();                   \
+	})
 
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

