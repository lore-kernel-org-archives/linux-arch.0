Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBC1E51FA;
	Sun, 19 Oct 2025 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871750; cv=none; b=nyVaRkZB7IDaCAV+OetMOj96IUgT2JGlfAMaDoGBXeyektFHmN+AUrkYME3YB9quXwOpPArv+nKJzunU+atfbbfJKHsl44tDzO6apJuKQ6AKkS/w7g8M4e//saoR/old42A7lzEmw4kj0/lX7jJE+ukiDccJajMerWp6+007tSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871750; c=relaxed/simple;
	bh=CThnH2ArXxvqvI9FWX9AIdwSiaKRUpnSBMLyaBc58C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRR4qVdvxujaYiXLwDNsscGq6KP9KH6sR54C2lW7hgC8MJa0+mK5jGUEE9+W6jutCB1TpC16iK3hV28xj6+S/nFrOlq85mRiW+kVQN7tFpxocA20nl5fS3MWqOPdrfbl7MvVD7dCE6ep07WYebrS556QIz6VHc9W6DAtBMDHWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKwQGAx/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKwQGAx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853C4C4CEE7;
	Sun, 19 Oct 2025 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760871749;
	bh=CThnH2ArXxvqvI9FWX9AIdwSiaKRUpnSBMLyaBc58C8=;
	h=From:To:Cc:Subject:Date:From;
	b=rKwQGAx/KsmhE3mZc1/j08WN3lyNtntPwDGe6+KzZ/Fbt68wejKZ7+300qA3F9UuQ
	 jLu3HwgmItJd09+xndw5Gm5PZjdfke2lZkx4RSC11Fj6ik6XcOlF/Q7vyiujpvQEyI
	 gfC1acfQAU0jFS2wKpEifjl3IwpqK408X8gdB0ZiUwLtxj+OoLHkOoH3z8Y5+BD3eq
	 HIVNw2fvCeN2hWHiatd4iw8m8zM95YdEytUfqS8E87dzuA4BFBF9zn8sBKeZkJnsmo
	 GCs0k+uifRs9gih69Bxj5riDC5xO5DfXf7XJIdqj/KcuCUwkJ1xqNWioxFwr5AbCCp
	 gIzPUWIxKkcHQ==
From: guoren@kernel.org
To: guoren@kernel.org
Cc: linux-csky@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org
Subject: [PATCH] csky: Remove compile warning for CONFIG_SMP
Date: Sun, 19 Oct 2025 07:02:14 -0400
Message-Id: <20251019110214.3392011-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

When CONFIG_SMP is enabled, there is a compile warning:

arch/csky/kernel/smp.c:242:6: warning: no previous prototype for
'csky_start_secondary' [-Wmissing-prototypes]
  242 | void csky_start_secondary(void)
      |      ^~~~~~~~~~~~~~~~~~~~

Add a similar prototype with csky_start in sections.h.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/csky/include/asm/sections.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/include/asm/sections.h b/arch/csky/include/asm/sections.h
index 83e82b7c0f6c..ee5cdf226a9b 100644
--- a/arch/csky/include/asm/sections.h
+++ b/arch/csky/include/asm/sections.h
@@ -8,5 +8,6 @@
 extern char _start[];
 
 asmlinkage void csky_start(unsigned int unused, void *dtb_start);
+asmlinkage void csky_start_secondary(void);
 
 #endif /* __ASM_SECTIONS_H */
-- 
2.40.1

