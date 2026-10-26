Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013550;
	b=lC++XqC1kFTNHnVF9hDF8laEm2TWtzOTlFzwiNnNvbF7YZv4Kj9XW/N/fEHC2ihAOT0w
	 vlfRd/y869lINUnCsskjTSsIl9kaAvtKy8preveBrz1o5z4gScmcmak5fiBJOkqjY0wes
	 +MXvxkvs/XPGpd1+U/ZXFtRAiGxCyyH3x7wnT/gNVy6LT9nT/vLI2Q7b99A6Qlc+p8Z5c
	 UUKXd+rrWtM+REcAHrZhMmd3YIPpKr760g6USj+HcQ2W8anzkxsPzL9GXzfj69HVkX49Y
	 4t3B1wHtaaOYVLaKeC3+Eo6wHBX5BC9MRZd46GdlbwWH39ERMAikn5tK7hdMj7lIoCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013550;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=NvY4ae/ED+MtOy03cyKJMlG3Ts44d9nHIMF7xjvLS74=;
	b=mjQ6sWrS6qtFxqjG5PrZ1CF9qOQ3VyLt2bP1no8Lw6Q/EZGfCUgxLFzKxJqwyljy27Yv
	 mHL4khjgQXMzkqtnfUVxfoykP34JeHPL8XMkhSVdy2C6jFJuORn2j0FFVFjMFPUmQyine
	 S5hhb6kWjEeh+RClnr6aWWu/ot3Ag46F9dmh5BREnxdpO1NEzUWRn4Qg69q8MzE/aDLYZ
	 GVBDCZ/uADnRCkbNdanJhfxFMh2R1RYpAMpEDKiniTMeEpQ+kPgdXcoKaBSyJ3o5Pb3Bu
	 ydijdOYxCprb8YdNyfsExY9IreDeEEz3AxqGtmwU2XkbV9fI1MkEwK2n5ddN/RwoTbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bWiQUOy8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2768606A329
	for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 11:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2768606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bWiQUOy8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793013549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvY4ae/ED+MtOy03cyKJMlG3Ts44d9nHIMF7xjvLS74=;
	b=bWiQUOy8Iv+FGyP3FW4Pd6A9YMNU2gj5APsiDhRp+mhHuESIlZ4M7P9pWadLmsc2z+XJh8
	64qOeXtB6OOxxyu/B7tk4Zhtj3VkBq0eU0CKTqIm5drjK0PYlTmquEQFbdpRm98uMkAOo2
	yYqXcYBfIVJKKPsk7G/JHK7YAWgEmt8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-8T1mK9NyPHKuQWwejArigw-1; Mon,
 26 Oct 2026 07:19:03 -0400
X-MC-Unique: 8T1mK9NyPHKuQWwejArigw-1
X-Mimecast-MFC-AGG-ID: 8T1mK9NyPHKuQWwejArigw_1793013541
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB69D1955F19;
	Mon, 26 Oct 2026 11:19:00 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A52BA1956087;
	Mon, 26 Oct 2026 11:18:55 +0000 (UTC)
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
Subject: [PATCH 5/7] x86: Remove the unused non-atomic local_t functions
Date: Mon, 26 Oct 2026 12:18:20 +0100
Message-ID: <20261026111822.458404-6-jmarchan@redhat.com>
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
 arch/x86/include/asm/local.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 68af7b74450af..6d0bca91915cd 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -170,13 +170,4 @@ local_add_unless(local_t *l, long a, long u)
 
 #define local_inc_not_zero(l) local_add_unless((l), 1, 0)
 
-/* On x86_32, these are no better than the atomic variants.
- * On x86-64 these are better than the atomic variants on SMP kernels
- * because they dont use a lock prefix.
- */
-#define __local_inc(l)		local_inc(l)
-#define __local_dec(l)		local_dec(l)
-#define __local_add(i, l)	local_add((i), (l))
-#define __local_sub(i, l)	local_sub((i), (l))
-
 #endif /* _ASM_X86_LOCAL_H */
-- 
2.56.0

