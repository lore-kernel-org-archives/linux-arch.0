Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AD3C09E1
	for <linux-arch@vger.kernel.org>; Thu, 14 May 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756870; cv=none; b=hbeZfbxGXyJevyS6ismSASqa1zLATmtfTV8YKi0DMpLxYZdzl+/SzWI9IgvgNddIXuKVqzveTLek689dU5Zwc8DzZmV/nnTpA6Lf1BqIq3jy1sLWkP9FFqha8WJJpVl0Oxf5/MaBIUy/WaIxnCPp2jyDYF1lx02azQ0uS9A8tNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756870; c=relaxed/simple;
	bh=BCX6kadJBC/BZlzwxVviNpiXSTspDqY8H13/iFxWWhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jkXfVW1jipsfp7TmjVLX4xAHslQ6DKSWELP4WrhmH/j6cFbyexP/AN1PBcoPQAdwv4w6tvNvEUN5rzcdKEznTCesNjzOwT8BaGf+yevKFhIQXk7ZabYCHCW20ypxZMHECFal9/b3ZNvFGR519BJNv2VKGXSjji4cyZySiGmBb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUW54Whs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUW54Whs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778756863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8CY2YJsmmGngQxdG/vGLXTsV2/RIfN8ZOdCKtJtf1o=;
	b=KUW54Whs3K6XWu4X187X5OYB6cM46/v35FpyNjy+QeuUC2Em5zYsl6zCY/qZxl4srruTgv
	qgl1gYOL5OVUPpRadIfQCGvih7yKn4wQDP5CkvpGN03WwV293fS4TpO4Ayvuvo9h6j2z8k
	/OHYq93sDc3cEL2eU2aUPaLqar37v2E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-7jUcZvu6OcWTLEitMjFjZg-1; Thu,
 14 May 2026 07:07:38 -0400
X-MC-Unique: 7jUcZvu6OcWTLEitMjFjZg-1
X-Mimecast-MFC-AGG-ID: 7jUcZvu6OcWTLEitMjFjZg_1778756854
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E360E19560A7;
	Thu, 14 May 2026 11:07:33 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D4F119560A7;
	Thu, 14 May 2026 11:07:26 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 14 May 2026 13:06:39 +0200
Subject: [PATCH v11 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-kunit_add_support-v11-3-b36a530a6d8f@redhat.com>
References: <20260514-kunit_add_support-v11-0-b36a530a6d8f@redhat.com>
In-Reply-To: <20260514-kunit_add_support-v11-0-b36a530a6d8f@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Dan Carpenter <error27@gmail.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778756819; l=4041;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=Klk7dpYGfEKyFoYh8y/kwk/SyyLXG0VtsYE7Yd//vl0=;
 b=n21eaqCPj64RYBkQPsGq+uqVssXX70+qeWpaAZljGDE8NIT2cV2KTcaH6tKcsFPddVREEQ5ky
 6Cnkc9pBoEDArrWbzlE+mg4FQd0Mz6CIYVfZbos958n1vhgA8/kB5+S
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Guenter Roeck <linux@roeck-us.net>

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log and distraction from real problems. Additionally, the
suppression API allows to actually ensure a warning was triggered,
without parsing any kernel logs and keeping them clean.
The suppression check requires CONFIG_BUG enabled.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Maíra Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Acked-by: David Gow <david@davidgow.net>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 46 ++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b76101..3402f993d7d33 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_mode.h>
 
+#include <linux/limits.h>
 #include <linux/string_helpers.h>
 #include <linux/errno.h>
 
@@ -407,10 +408,27 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
 	const struct drm_rect_scale_case *params = test->param_value;
-	int scaling_factor;
+	int expected_warnings = params->expected_scaling_factor == -EINVAL;
+	int scaling_factor = INT_MIN;
 
-	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
-					      params->min_range, params->max_range);
+	/*
+	 * Without CONFIG_BUG, WARN_ON() is a no-op and the suppressed warning
+	 * count stays zero, failing the assertion.
+	 */
+	if (expected_warnings && !IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	/*
+	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects unit tests with -EINVAL
+	 * error code in expected_scaling_factor.
+	 */
+	kunit_warning_suppress(test) {
+		scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
+						      params->min_range,
+						      params->max_range);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, expected_warnings);
+	}
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
@@ -418,10 +436,26 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
 static void drm_test_rect_calc_vscale(struct kunit *test)
 {
 	const struct drm_rect_scale_case *params = test->param_value;
-	int scaling_factor;
+	int expected_warnings = params->expected_scaling_factor == -EINVAL;
+	int scaling_factor = INT_MIN;
 
-	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
-					      params->min_range, params->max_range);
+	/*
+	 * Without CONFIG_BUG, WARN_ON() is a no-op and the suppressed warning
+	 * count stays zero, failing the assertion.
+	 */
+	if (expected_warnings && !IS_ENABLED(CONFIG_BUG))
+		kunit_skip(test, "requires CONFIG_BUG");
+
+	/*
+	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects unit tests with -EINVAL
+	 * error code in expected_scaling_factor.
+	 */
+	kunit_warning_suppress(test) {
+		scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
+						      params->min_range, params->max_range);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, expected_warnings);
+	}
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }

-- 
2.53.0

