Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013549;
	b=2+1A25cyeZN+N8KJmgTJL3GPOoyz3wT/fOAKWtRaUTSggQZW+tcYs8LsXTgikM6a5VsR
	 U1kcGk7iNnOAlwa7ZURLt84wK0YJQMeNShjbIITJ3QCWAE/EjYG3DB6pHIjfuMuXDZ+cl
	 dAgRC28733diCU07AMtE7J49DldHR0UivzrSwZtF5jNMuT7dxR6B0ru8Hoq/VJ4AcS0aD
	 lX1tdukNBbDW/of1+TfxHsq7+i403WKYZ3tJytCJ0wydh5u0S/daD14F1LQe0z3SKrYmN
	 S0iPgGKY1TVkhXiA2L6wlZ7wjh6oersJgr6VLz0RXBqY+Xpe2DcSDaKq5OpZKlErLNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013549;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=J0H/xxIbCIwLmHjLOcIQ75jlbiqruovqTlxwP/qTOlU=;
	b=hp8M2b4zpZRxL8TmM58X1w0GJLJ0C9S7eq6oXkyvfd6fAOBZl9GrUskEnxw0yspRI8Uo
	 1zJ9Xs2kfttmwPMTd9t8oTqH2JhPAuOUN3PLgZld9x8WqRJp2SkKH4teQlPkvIRF6PorF
	 91Lt+zwaiZ0K6U3JL4VkfHBHtmfEaqbF9chE8ae88K/WW/X0L8Ms6IATRD9lJYtWj9OmT
	 RoonbZnkleye4ZK/2SZ6PTBTIU/evzqYxHo00IhxOk3DkXuXG9AzKhgqpD2btE27v6Odm
	 +64rgQNNm+2BlKOfp8TMVPRlDUzFdCcsEZpDSXyx/3aihpDP17fa4W3iNQRYtTEAOeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzJ9VCcC;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2C606A322
	for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 11:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D2C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzJ9VCcC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0H/xxIbCIwLmHjLOcIQ75jlbiqruovqTlxwP/qTOlU=;
	b=SzJ9VCcC1O417alNOocX5DMa5tPPlklt1fKzFKHwiDh/Co18M8El0aXiKaFF3hmZNfG4BY
	sp/WOXWk00IBCcJXr09D7SMxc3XY47LgLX+FKyvyL2GJrOYS/Ehwi0kqmLO8JIgg0FTrBB
	KYqBE00IAFhPIKQBdbry1CZ4tvb95Oc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-bMNloqC3PyWcCfI9gS9TKQ-1; Mon,
 26 Oct 2026 07:18:58 -0400
X-MC-Unique: bMNloqC3PyWcCfI9gS9TKQ-1
X-Mimecast-MFC-AGG-ID: bMNloqC3PyWcCfI9gS9TKQ_1793013536
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4904D195604A;
	Mon, 26 Oct 2026 11:18:55 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E458195608A;
	Mon, 26 Oct 2026 11:18:49 +0000 (UTC)
From: Jerome Marchand <jmarchan@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH 4/7] powerpc: Remove the unused non-atomic local_t functions
Date: Mon, 26 Oct 2026 12:18:19 +0100
Message-ID: <20261026111822.458404-5-jmarchan@redhat.com>
In-Reply-To: <20261026111822.458404-1-jmarchan@redhat.com>
References: <20261026111822.458404-1-jmarchan@redhat.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

While working on a fix for a tracing soft lockup, it came to my
attention that __local_dec() was broken on ppc64 and other arches (it
actually increment the value). My first instinct was to fix it but the
fact that this function was utterly broken for so long, decades for
some arches makes me thing that those functions have not been used for
a long time, if ever.

Anyway, they're not used now, so remove them.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 arch/powerpc/include/asm/local.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index 4c033526bfb0d..24ac534cf809a 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -140,16 +140,6 @@ static __inline__ bool local_add_unless(local_t *l, long a, long u)
 
 #define local_inc_not_zero(l)		local_add_unless((l), 1, 0)
 
-/* Use these for per-cpu local_t variables: on some archs they are
- * much more efficient than these naive implementations.  Note they take
- * a variable, not an address.
- */
-
-#define __local_inc(l)		((l)->v++)
-#define __local_dec(l)		((l)->v++)
-#define __local_add(i,l)	((l)->v+=(i))
-#define __local_sub(i,l)	((l)->v-=(i))
-
 #else /* CONFIG_PPC64 */
 
 #include <asm-generic/local.h>
-- 
2.56.0

