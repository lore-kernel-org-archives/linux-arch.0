Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF53AD528
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082305; cv=none; b=Imh3qbBc/Tdn1YOUn67cTEYDg1EZ/aQksuLypIwBjeQmJ6+nowRSfcipR96qOmaAF7Ap4gxUTfeL7twRC30UIPLV1RBl/Q2gclOsCygTcECqBBLiNoBRK73stkd+jdTqfYHbXOm1Hb0voSPGNNKgM24q0Px2iqbBMpuY+mEu5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082305; c=relaxed/simple;
	bh=IRQm3dt0P9dV3RkqQkn/DS+iNiQJKrzZzaxRKL+uIUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXj1DAlgdaCav6d5jHA7Kn4oeByWXiIDXeBxK+oB9aeOX0cZy7TxlGvjBVMLa3V+kJT3R+mo+Rrc2TgKSU4jBgNhDmO2PnpRsIK8LKFzlSLaCE/v3T3rct899jpyCDuSl2iOf51XyqfcGPyV6TcAsPzRsrD3rAajORJfFrx0iFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkyoJb+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkyoJb+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781082303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KHpLRjzpwGKmiwk/zPO/cOdYmfizCDf0cuh4d+ia5yw=;
	b=NkyoJb+BPBoLCSO/LnDLDS2X4CC1zb994UFsaMIthSIKqlljU8aKAxqfqU8kABJA++DhOV
	RV80cELa6X9EJoNHsJarU+TScC/6F3GcVVkIus0BYwFxRbrETdgZ6HVr90/2GzpTikoTG9
	eo6b6RxY93MRqqpT6KAtLr5r7apYPbE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-RCX4qt4GN3CKsitOWJJBSg-1; Wed,
 10 Jun 2026 05:04:57 -0400
X-MC-Unique: RCX4qt4GN3CKsitOWJJBSg-1
X-Mimecast-MFC-AGG-ID: RCX4qt4GN3CKsitOWJJBSg_1781082296
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CE3318009DE;
	Wed, 10 Jun 2026 09:04:55 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.rdu2.dc.redhat.com [10.11.142.86])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E98193008B35;
	Wed, 10 Jun 2026 09:04:51 +0000 (UTC)
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
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	stable@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH bpf-next] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule
Date: Wed, 10 Jun 2026 11:04:29 +0200
Message-ID: <20260610090431.32427-1-gmonaco@redhat.com>
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
Cc: stable@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
New submission of [1]

[1] - https://lore.kernel.org/lkml/20260609094941.56122-1-gmonaco@redhat.com
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

