Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4F3ED106
	for <linux-arch@vger.kernel.org>; Wed, 21 Jan 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007479; cv=none; b=DTU8cglZd1QPgawsz63q6M8ievj6pCA6M8ar/1fcFeeq/nNqyMMegLDn5ZTdVihUeov8Tqr3x5266COvVb2X1NCGtZr52JVAq5S3S8pCMySvxQScU60Q7y/7eEu8E1QLakj19S15XXbXmx0hqq9aTeMnDoO2lQf2CSqTiCA7kmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007479; c=relaxed/simple;
	bh=foIGQMOAHWwCNroXsDE7jRsNmbGSBwa8yV3vFc2z48A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dt1lojopm9nS4kvgIqq/dqSu0VhJPUxRLWz/67DUSYlMpzUWrl9C89ADn7z0KnZDxRJE0BrC97BKhaOQqMOV70mM0wbMeaMl4evf+8GJtQcaJLv4sKsPKF6s4WIx296OJZ5Hx3zVAxJu+toLXHJ4cstvbHUhlPaFxKmIF8YwFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=HaW/GUkV; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="HaW/GUkV"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeU-008Pcw-I2; Wed, 21 Jan 2026 15:57:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=2gq8v9rIKK/WZOVtXyQBP19csssyxOXjWNwk4Hfn2/0=; b=HaW/GUkVH2w4hPqHQaP/dYVF2Q
	pVkYu5IGc+XLh3/i5cXUCnSAfy0Xm5x7V9eMiDozvHjyngPjaJzW8UHxjEwW+1wVpXM0zfssdvF/a
	joU2beF7UXXt+0JXuf7VT5YFS4IXiXU+0rLoPpEZddPrN5PoMs+4yuyMN5p9v4a4EsI5XLaDEdqXP
	yNjzgUcGeQWmlqiJnK2cxfEf2+KOyMEMtiKkKBmxfrg3FohGyOzL80P07OCIADWwQH1/PuR4FnPwf
	jYshxnA3sFoNJS6huJURh5MkMccTOEnv3GWSileZr/JiuF9eLENz2MUr8fvzIlum4zg5Wsk0jnEYk
	a4znAFog==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1viZeU-0001qf-4L; Wed, 21 Jan 2026 15:57:46 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1viZeT-00GH6h-PY; Wed, 21 Jan 2026 15:57:45 +0100
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
	Andrew Morton <akpm@linux-foundation.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next 03/14] media: videobuf2-core: Use static_assert() for sanity check
Date: Wed, 21 Jan 2026 14:57:20 +0000
Message-Id: <20260121145731.3623-4-david.laight.linux@gmail.com>
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

Compile-time tests being added to BIT() make it an 'integer constant
expression' rather than a pre-processor expression for W=1 builds.

Change the BIT(PLANE_INDEX_BITS) != VIDEO_MAX_PLANES test to use
static_assert() so the code compiles.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 2df566f409b6..90dedab2aeb2 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -37,9 +37,9 @@
 #define MAX_BUFFER_INDEX	BIT_MASK(30 - PLANE_INDEX_SHIFT)
 #define BUFFER_INDEX_MASK	(MAX_BUFFER_INDEX - 1)
 
-#if BIT(PLANE_INDEX_BITS) != VIDEO_MAX_PLANES
-#error PLANE_INDEX_BITS order must be equal to VIDEO_MAX_PLANES
-#endif
+
+static_assert(BIT(PLANE_INDEX_BITS) == VIDEO_MAX_PLANES,
+	      "PLANE_INDEX_BITS order must be equal to VIDEO_MAX_PLANES");
 
 static int debug;
 module_param(debug, int, 0644);
-- 
2.39.5

