Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24707364EB6;
	Sat, 28 Feb 2026 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263093; cv=none; b=Np7Oq7iaXfohsKhwZLIwkIVui/rpoRInPQOVudXq5D3gp3Eqn+3IGy9OrNNRv/RMraNHQtf+uMkLVrfh5WWO1kSFQVF33uPmDrbincacZdnxtpAUuHFMe3sd2wnNzmyW2ULR+UHF0w9vTsN9PGGrDJZiMHmlSYiVpP165+tmIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263093; c=relaxed/simple;
	bh=rtPl1GSidCj9Q7S82rpjXcAkDzTVMlpDMIq1t2hnTHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cX33w5lvtizBeGag+EZIob8tkAzmAXh+UZgI2nFLh4oUFW9uP6fgBHwnsbOITenzG82T3kENuwSv6a5PcqY8jna3HZ2J+dPZZgoSx+/s2P0Kjqi0L2d/2DdxLgcph7jT5HV6KWwhgxiMZEeWvoCdMOFuoGi6O1Lng2cNP4wQN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XEb1hoyd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XEb1hoyd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sM40aNoxqrveVrrmPbC2AFwNvJUNyHgEDPFS40cj40Q=; b=XEb1hoydGXAEq1pqQwQjplTYCU
	pz1akGqlkpZYEHkJ5ePOgbcVEdlmub3+Mxckj3qeMcMZzduxq8PCGoU2uFabDN1VS7JVDQd5EECn8
	qm8fbrUea/PqJOTrmA+aj67586klif7ePYuVTDxP1yeleesUl0QyNkXXieqFhygJULQMr0Cig+9+v
	JvBq5v+8PWTzPc1tD/uvwfhh0R5I4qz3aId5k5WdGAxVCMgBLplbLpBZyGOndnzvxhPWcnEy5AncR
	2xJmSnDMd4k84dEP366iarOrPMJMf/Eg6qVXr5yhLfaU3vqiJSj1pH6QIib+G89VH1oGfpMCG7sjX
	cgEg21+A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEaZ-00000009bmM-2ZP7;
	Sat, 28 Feb 2026 07:18:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/barrier: use correct parameter names
Date: Fri, 27 Feb 2026 23:18:11 -0800
Message-ID: <20260228071811.2663959-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct parameter names in kernel-doc comments to avoid
warnings:

Warning: include/asm-generic/barrier.h:245 function parameter 'cond_expr'
 not described in 'smp_cond_load_relaxed'
Warning: include/asm-generic/barrier.h:267 function parameter 'cond_expr'
 not described in 'smp_cond_load_acquire'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>

 include/asm-generic/barrier.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260213.orig/include/asm-generic/barrier.h
+++ linux-next-20260213/include/asm-generic/barrier.h
@@ -235,7 +235,7 @@ do {									\
 /**
  * smp_cond_load_relaxed() - (Spin) wait for cond with no ordering guarantees
  * @ptr: pointer to the variable to wait on
- * @cond: boolean expression to wait for
+ * @cond_expr: boolean expression to wait for
  *
  * Equivalent to using READ_ONCE() on the condition variable.
  *
@@ -259,7 +259,7 @@ do {									\
 /**
  * smp_cond_load_acquire() - (Spin) wait for cond with ACQUIRE ordering
  * @ptr: pointer to the variable to wait on
- * @cond: boolean expression to wait for
+ * @cond_expr: boolean expression to wait for
  *
  * Equivalent to using smp_load_acquire() on the condition variable but employs
  * the control dependency of the wait to reduce the barrier on many platforms.
