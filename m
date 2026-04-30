Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7B3D5640;
	Thu, 30 Apr 2026 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592373; cv=none; b=nDDJhD/vVIkPF/40pTF45P8cPPYH3AHfhEX0XXX1xW3LtIXQhszJ0/mcgK1dvPxS1yYIzZ+SV1KFKRPdhfSvKbFQ6UIldEuMPcCyalbwppi0P94ZxmGBevv4hffrlKXED2wLbKxdxLx5WDk5x0MiDrif8ZfbwmW5Frq2g2MYuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592373; c=relaxed/simple;
	bh=zAlkK7V5A05VJj69PgOqC4zqbnknZ+jcy3vFhySGxCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWJtok1k4VoUa0iVxvpoiNJrjTekeqXZQnkb+t01qT6NtfLqw1EML1VN1GF07c2Vw0nFhdbuZ4l0hS0HQXv6PRYyTjnbgMHkrgtM7JvDihTYgAxj2jthR2WeMCSnBieKcN8Nt/NcKCwpEpVhG2CrwANMA9clEEaijCXFjfAbsm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ifv1N5P5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifv1N5P5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UCVDWxa2BbMxDfj4MYehjnOcZfyD56Rp80pXwkIjW4g=; b=ifv1N5P5tZi/VXR5LCcI3OarWF
	al3XMhgoXp9AdSAMMu9xOCUU0BEAfxluBVaf1Gs9Kn+BeI2ZwfQ0lr8hm6+6MCfxjDX7rvdckI+kI
	0/sz54Xs1JwwoQRkJWmREBgfUs+ZyBdU33fFeIS1TzbsluWE23NXpyPyq6xkl8ImarTVLsR2wGcca
	j9CRIV7az63INcY8SDaZDztW3n9smAhfrKFutKdDucJ9lgFgmWf6eIAq6XDu3XUegVbC+EmY+Wa3E
	FMrT451PQYHXp4vLqlnYrI2H0Sh9KFgfN00DwAl/CwrniDLvXqxVmiXmjBY6l1WQgtK/62LKkOtli
	NaK8bKUA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIaye-000000067uI-2Eci;
	Thu, 30 Apr 2026 23:39:28 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/barrier: use correct parameter names
Date: Thu, 30 Apr 2026 16:39:27 -0700
Message-ID: <20260430233927.2620050-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
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
v2: rebase & resend

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>

 include/asm-generic/barrier.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260429.orig/include/asm-generic/barrier.h
+++ linux-next-20260429/include/asm-generic/barrier.h
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
