Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24539FCB9
	for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739521; cv=none; b=X9329Q5VipGxW/Jrf1NEHijJ+YqMgN4TQfUY1Tz6dRWFwihTsUgb+7i8nK1u0ssWjT+tFU0k6q3rmX9dI085bc25A5u2+OUh5kfkY0NZNHiokrh6J9kswvHk31I8J+fBf1j18/HWZCC6KFsmZMzjJB8XyvOtDeGnSIkqNPnT5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739521; c=relaxed/simple;
	bh=5cUTuyT74M1ojJ8O1F2DSZ1Z6HcZkw/+k+1xRs9jdDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIPgRHGTFE1vR4bp69rnTt8MncqriDoXLTDGj7WNtWdW4Z9JYnDsyvGAmOYYm1Lb/MktPJ2PI8tqLccCSLAb5xpohyBtHbt+aFqbW0Bmk6eYYWJNa0uNbkSJKIabkCpO8bBzDG3C5zHCI2FV2r1j+l+17pFPpg0NIWe4zlJwUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J074GBZ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J074GBZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773739519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu26JzW2BE1qFVqqYnDWECATcFEfXbKaDpd4Fk/QFDA=;
	b=J074GBZ2WPxv/syIHfJ1HUnqt0xSwhuOp0P8Q/KsCO8OwzoDpbEWQIP4McSPlnEhzpYVcP
	WHNBr5PAFK/F1WKA4ykjt0Y6zydZwEmLckiLbZwwXks7KycDztxNy5Xwv9oQCpDtRQ7BAX
	l+1pbBwW8Pa5byvWQU/71uWjnbS9eo8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-m6g32FopMQGMpxkGZtozOw-1; Tue,
 17 Mar 2026 05:25:14 -0400
X-MC-Unique: m6g32FopMQGMpxkGZtozOw-1
X-Mimecast-MFC-AGG-ID: m6g32FopMQGMpxkGZtozOw_1773739511
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B782F195608C;
	Tue, 17 Mar 2026 09:25:11 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92BED1800361;
	Tue, 17 Mar 2026 09:25:04 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 17 Mar 2026 10:24:42 +0100
Subject: [PATCH v6 2/5] bug/kunit: Suppressing warning backtraces reduced
 impact on WARN*() sites
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-kunit_add_support-v6-2-dd22aeb3fe5d@redhat.com>
References: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
In-Reply-To: <20260317-kunit_add_support-v6-0-dd22aeb3fe5d@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773739485; l=2494;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=HqTbvkL2qatyFCLaW9ftzFuA7IHBU2Z5TfsvY4qRWpc=;
 b=2JcEn3cIAWR6YXbKBW2zwURhD/Aw/6CbCOWAfArN7xelgYYKJca/lYt8/khkA1n+x7960ypP2
 FRPzHMfTCn+C+Ahx7ewn70h7UCKtoGC5FuTcRNNhd7uqMfuYTaR9xXg
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Alessandro Carminati <acarmina@redhat.com>

KUnit support is not consistently present across distributions, some
include it in their stock kernels, while others do not.
While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
features, the fact that some distros ship with KUnit enabled means it's
important to minimize the runtime impact of this patch.

To that end, this patch uses static branching to minimize code size
and runtime overhead when no suppressions are active. In that case,
the static branch compiles to a single no-op instruction (5 bytes on
x86), avoiding any memory loads or branch prediction overhead. The
branch is automatically enabled when the first suppression starts and
disabled when the last suppression ends.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 lib/kunit/bug.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
index 53c98e225a895..9c2c4ee013d92 100644
--- a/lib/kunit/bug.c
+++ b/lib/kunit/bug.c
@@ -7,17 +7,25 @@
  */
 
 #include <kunit/bug.h>
+#include <linux/atomic.h>
 #include <linux/export.h>
 #include <linux/instrumentation.h>
+#include <linux/jump_label.h>
 #include <linux/rculist.h>
 #include <linux/string.h>
 
 #ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
 
 static LIST_HEAD(suppressed_warnings);
+static atomic_t suppressed_symbols_cnt = ATOMIC_INIT(0);
+
+DEFINE_STATIC_KEY_FALSE(kunit_suppress_warnings_key);
+EXPORT_SYMBOL_GPL(kunit_suppress_warnings_key);
 
 void __kunit_start_suppress_warning(struct __suppressed_warning *warning)
 {
+	if (atomic_inc_return(&suppressed_symbols_cnt) == 1)
+		static_branch_enable(&kunit_suppress_warnings_key);
 	list_add_rcu(&warning->node, &suppressed_warnings);
 }
 EXPORT_SYMBOL_GPL(__kunit_start_suppress_warning);
@@ -26,6 +34,8 @@ void __kunit_end_suppress_warning(struct __suppressed_warning *warning)
 {
 	list_del_rcu(&warning->node);
 	synchronize_rcu(); /* Wait for readers to finish */
+	if (atomic_dec_return(&suppressed_symbols_cnt) == 0)
+		static_branch_disable(&kunit_suppress_warnings_key);
 }
 EXPORT_SYMBOL_GPL(__kunit_end_suppress_warning);
 
@@ -49,6 +59,8 @@ noinstr bool __kunit_is_suppressed_warning(const char *function)
 {
 	bool ret;
 
+	if (!static_branch_unlikely(&kunit_suppress_warnings_key))
+		return false;
 	instrumentation_begin();
 	ret = __kunit_check_suppress(function);
 	instrumentation_end();

-- 
2.52.0

