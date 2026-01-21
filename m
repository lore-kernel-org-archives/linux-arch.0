Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4548C40B
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007483; cv=none; b=aRcqX0sciqV58A5ev6Hjtemyc7BJc/qFEOUvB0b91VwTXkbv+5txQUubzHKe1iJ8tSw2eDoQUEKXaSlziyYU3541b3tEYzPfiHdre0q8GnBWc6wK0a8kmVKj3ZDBNDmP/lRV/aTjifR9yCDpqNsonRn/qZ8ifibYV+XE7BNPwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007483; c=relaxed/simple;
	bh=KnD6lUbvGcRchKcNZZh/x1v8Ivn5Z3m9i5iGppglY/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7jmP+47ph0eOhp7Re0EqoxH2wOwf6h6PIggi7rIYdh6FBdTrY7dExTz1+jWw/p7VX/XM5zZOl1myb4fRGn/0kWD727h82nUgHjPVLQcpOH335PpCp/A/JCthLQRkpfwSEsUvY3KvYs5oxQ+j+ROVLTJqw64EeERO3TkyyhKLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=qLagF0dg; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="qLagF0dg"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeV-008Pd2-AA; Wed, 21 Jan 2026 15:57:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=woWiGteby0nhO3keCjO/XMIhwTt+aq04kL0xpr3EbPg=; b=qLagF0dgYYDg8S2PrryXBn9dXe
	u01E9/j0t8fFoNRWbmP4RGYkd+TC6D6c5H6/89a7J07kehtzHK9KPDgjicbrvupq9p2WeZOTS3gaE
	kcgsBJE76RHSrMnfXTMapxfAYRhqcrhwA74jf0EMi5cpiQh8PIZow/HG88vb2LC6H/p6JGH4chQsp
	ajzohJd8YBsMuEGeJt9KFxBCf8ZxeIOuugeVNYtV0bkLkwIuJSjzg4eIHRg5Ii23WljRXk2eLmkZR
	Q6EA0su+3xNKD1hrJTN12c43hYnK0Rz5EDTzk7TGUnbSbtq3SqggCVYiQFo2d7IRQHGu9KldnK+9S
	h4Dx+60Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeU-0006kD-JG; Wed, 21 Jan 2026 15:57:47 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeT-00GH6h-4t; Wed, 21 Jan 2026 15:57:45 +0100
From: david.laight.linux@gmail.com
To: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 02/14] kbuild: Add W=c for additional compile time checks
Date: Wed, 21 Jan 2026 14:57:19 +0000
Message-Id: <20260121145731.3623-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121145731.3623-1-david.laight.linux@gmail.com>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Some compile time checks significantly bloat the pre-processor output
(particularly when the get nested).
Since the checks aren't really needed on every compilation enable with
W=c (adds -DKBUILD_EXTRA_WARNc) so the checks can be enabled per-build.
Make W=1 imply W=c so the build-bot includes the checks.

As well as reducing the bloat from existing checks (like those in
GENMASK() and FIELD_PREP()) it lets additional checks be added
while there are still 'false positives' without breaking normal builds.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 scripts/Makefile.warn | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.warn b/scripts/Makefile.warn
index 68e6fafcb80c..e8a799850973 100644
--- a/scripts/Makefile.warn
+++ b/scripts/Makefile.warn
@@ -2,8 +2,9 @@
 # ==========================================================================
 # make W=... settings
 #
-# There are four warning groups enabled by W=1, W=2, W=3, and W=e
-# They are independent, and can be combined like W=12 or W=123e.
+# There are five warning groups enabled by W=c, W=1, W=2, W=3, and W=e
+# They are independent, and can be combined like W=12 or W=123e,
+# except that W=1 implies W=c.
 # ==========================================================================
 
 # Default set of warnings, always enabled
@@ -109,6 +110,13 @@ KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
 KBUILD_CFLAGS += -Wunused
 
+#
+# W=c - Expensive compile-time checks, implied by W=1
+#
+ifneq ($(findstring c, $(KBUILD_EXTRA_WARN))$(findstring 1, $(KBUILD_EXTRA_WARN)),)
+KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARNc
+endif
+
 #
 # W=1 - warnings which may be relevant and do not occur too often
 #
-- 
2.39.5

