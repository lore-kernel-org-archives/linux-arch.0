Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739F84594A;
	Wed,  4 Mar 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772585411; cv=none; b=C87GCNWeMMZlf/aPkd4ZMIaK9QFp5hSPQCDSibKGXmzkeRGE9LafrgnTxrEaBfxHrsbGZY1Jgp3mSwnLYO0jNP1sLye40D9/T/opf/T5zyKpqbFtS4l/BEtmuN4itS6uizNOekxediQfo9Vxkg3FGkENuBjdaodQacWJpgiOjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772585411; c=relaxed/simple;
	bh=tghgoRdVx1Wu5cFf4gcpa8oLY8fuL3jhRm4M03f7Li4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LEitstmppiNEpFwL5HiHUM1FNzKBdTvsOV3HDuChoaBWO4PbwGDajLwtkZHEoEgkHjSEvlqwMmvVaPBozdaEhEFsNmiJPWSP7AXTvyH+uEKGSAVWXrSPOZMylwafMCCZw1eHM0wrtcHJYdFz3Tj8Sl8vH++FwGzr91ym7VgBZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OjAy/CUB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OjAy/CUB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=b7Ktm12Ia7mymNYEoqYtS66SI6284FUIrAD8tUKVZ3I=; b=OjAy/CUBHSjgRP/xN7yyBFcY2J
	niyOq1JJVFOCeGavPg+UEAjQd/b9pGihao58gFNuGQ3qFDXDydLxFayj/QbhhA3CCwbb/2p1ekwJh
	RFlxwQyACav8sSFOhHNtaHmbQHWqUJGbo9/EZ/vDbyXoQCzM9dW9Di7SzqW7gsSkWUdIav+DCNtQC
	rAxnQa55WXJxDjoz8VxnJZQmwE9WIiDP4Ko3IR3MZnqhoEqixrxJAU3l1c9Pay298vk1Tbgmk0qBa
	6fSPx7iLKpzz5EmPUizwkVpCsDqWjQrqSYD28BFakjsmqsjgj+ri314NFw/o4a53Uir8UJtkzPc8r
	0T7Zf+tA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxaRF-0000000GBmG-2nrm;
	Wed, 04 Mar 2026 00:50:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH v2] futex: add missing function parameter comments
Date: Tue,  3 Mar 2026 16:50:03 -0800
Message-ID: <20260304005008.409858-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct or add the missing function parameter kernel-doc comments
to avoid warnings:

Warning: include/asm-generic/futex.h:38 function parameter 'op' not
 described in 'futex_atomic_op_inuser_local'
Warning: include/asm-generic/futex.h:38 function parameter 'oparg' not
 described in 'futex_atomic_op_inuser_local'
Warning: include/asm-generic/futex.h:38 function parameter 'oval' not
 described in 'futex_atomic_op_inuser_local'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: clarify descriptions (André)

Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

 include/asm-generic/futex.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-next-20260227.orig/include/asm-generic/futex.h
+++ linux-next-20260227/include/asm-generic/futex.h
@@ -25,7 +25,9 @@
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
- * @encoded_op:	encoded operation to execute
+ * @op:		operation to execute
+ * @oparg:	argument of the operation
+ * @oval:	previous value at @uaddr on successful return
  * @uaddr:	pointer to user space address
  *
  * Return:
