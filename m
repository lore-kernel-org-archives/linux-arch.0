Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87053B4E9D
	for <linux-arch@vger.kernel.org>; Thu,  9 Apr 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728078; cv=none; b=bFiYfwN8fyoMpYiywmCUGKVuiPClHCyvNQSXNczXr6Bn9YcI8dA/BYCIIvLqm1SVdDiDsgsNG4VXdAzMrnzsI3DYeSK+dwI03lPbe4CfkTzMEFyBwUeWyONp49zfoc6CYpm8ecJzlNyu8Vd/XKPlcBvMBgtu19GvJGVkf0eaUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728078; c=relaxed/simple;
	bh=iCdzSnfIHg7hu83jvH0NINgMijuXJ9uGjWs8VBxB6/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1jxIZmphLxQ6Jzo/9wC0qhaStIigDXPEoRZr4VsVDYboIBRMSvB+0d0oHsNLffdMBHocgdnJGnL0F3UoAeSe+3lTNOnQLSHfxESVPN6hGtWiYEoiDdajq/iIjrZv+dkpN4DjW7RNmsv48/fAm+fZb2SodazuOQGVoKhWHJces4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSENG23K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSENG23K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775728067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArqqKVyWIMN9eczDpfd6+1wQ00bc1tFZsdDTLBAVmAY=;
	b=DSENG23K+tRhzrR70CEbj/ciht6X17PkDaTx6qBKgLUqrPEpyPB6HBv03QaZA3Jufluqiv
	jyWNrNG2dpy7LahlqzQn3k4XZ6lUXEzqQZZfa6cPH96nukrJToysv2vFMXUek5nNTqwJUU
	UgEX7DUI6T7E8WZIe1ykhck4dFM+rnQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-nKOs2kagMxmW02h-ffOE4Q-1; Thu,
 09 Apr 2026 05:47:44 -0400
X-MC-Unique: nKOs2kagMxmW02h-ffOE4Q-1
X-Mimecast-MFC-AGG-ID: nKOs2kagMxmW02h-ffOE4Q_1775728063
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE5721956055;
	Thu,  9 Apr 2026 09:47:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.155])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07B4B30001BE;
	Thu,  9 Apr 2026 09:47:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 5/8] kselftest/riscv: Replace __ASSEMBLY__ with __ASSEMBLER__
Date: Thu,  9 Apr 2026 11:47:05 +0200
Message-ID: <20260409094708.1687376-6-thuth@redhat.com>
In-Reply-To: <20260409094708.1687376-1-thuth@redhat.com>
References: <20260409094708.1687376-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thomas Huth <thuth@redhat.com>

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize now
on the __ASSEMBLER__ macro that is provided by the compilers.

Cc: Paul Walmsley <pjw@kernel.org>
Cc: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
index 1c8043f2b778b..184df6903d01c 100644
--- a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
+++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
@@ -56,7 +56,7 @@
 
 #define CSR_SSP 0x011
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define __ASM_STR(x)    x
 #else
 #define __ASM_STR(x)    #x
-- 
2.53.0

