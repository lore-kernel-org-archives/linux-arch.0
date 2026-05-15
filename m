Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8F47DF8F
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848220; cv=none; b=MuZSj8JHfnDVVLCfz2/GCbOo3EC4QfOIYs+5ECYyPnQM7fzcfJ1Zysy9CehfvMmpB882QGI7hgOSrUqnDWUxU9myH76jluojq61VMZJq9/TSOih72T+++uEeCdnVXtXtPg1YHLnT1JsN3asX9NZ+mKULJ+95ngtcYy678f5Y7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848220; c=relaxed/simple;
	bh=ONi7awMizuGRTA2HeQXx+Qo6YyDHROJic9zzskpdn4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tusrnJXhD04G2/mjR5XZ4jj7y+JgFlvUsTEn/F2Q8lt2gyUmfZ+KGwj3hHk3ukfgx2m/jnn6b+NAq6HBmx7wRj/hCudC0D2IOYLGMd/kJKIzufehbMIUn4ooHXUAGWFPOnScG7u3yTIodIRLBZuqx9fk8XKvR5zHMEOhx0h4ILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqHye/1J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqHye/1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778848217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEBwBuDymXqtgfipLBoE9xL2mtSkar53Y4il/kQ0kJw=;
	b=BqHye/1JAY8VDIWnACC4cg1HfnD1Dj0vsspZKAx4brzq21Vd0yVkVsxNI2jgPCk076hq3Q
	9nQ10uGr/m+eiafwysFs1p7mXOEA6eaJy8uqet/S66XEFfwpAvnl9sSmYAD8kxbpLtYlBo
	OoYPuXCcYbopqH5gh/oaVjvnf1k0kGc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-UybKAniIMAeexXl0cBYm9Q-1; Fri,
 15 May 2026 08:30:13 -0400
X-MC-Unique: UybKAniIMAeexXl0cBYm9Q-1
X-Mimecast-MFC-AGG-ID: UybKAniIMAeexXl0cBYm9Q_1778848210
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB1411956062;
	Fri, 15 May 2026 12:30:09 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7939A1955F2D;
	Fri, 15 May 2026 12:30:02 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 14:29:34 +0200
Subject: [PATCH v13 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-kunit_add_support-v13-3-18ee42f96e7b@redhat.com>
References: <20260515-kunit_add_support-v13-0-18ee42f96e7b@redhat.com>
In-Reply-To: <20260515-kunit_add_support-v13-0-18ee42f96e7b@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778848177; l=3810;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=rPDAUA5/eI1GmSDx2demf6AeqBwHHnfPFpVSMTL5AHs=;
 b=CiGtWAj3Sxok8xNBwNJhHUScegPnII9dD6Ao+Xj/BNFA55q4TmXHafnZTUAqUJuFBz5IHJJV0
 5zFsDpaeNgNBckO3B+KYyas5tKSbWBvU1wk6LFUULAn8R+ahjSwKqRm
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Guenter Roeck <linux@roeck-us.net>

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing invalid parameters
the tested functions. Suppress the backtraces to avoid clogging the
kernel log and distracting from real problems.

The suppression API also exposes a warning counter, which is used
to assert that the expected warning was actually triggered. On
CONFIG_BUG=n, WARN_ON() is a no-op and the counter stays zero;
the expected count is adjusted accordingly, preserving the return
value check on all configurations.

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
 drivers/gpu/drm/tests/drm_rect_test.c | 36 +++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b76101..5aa8ec5fc4d64 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_mode.h>
 
+#include <linux/limits.h>
 #include <linux/string_helpers.h>
 #include <linux/errno.h>
 
@@ -407,10 +408,22 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
 	const struct drm_rect_scale_case *params = test->param_value;
-	int scaling_factor;
+	/* With CONFIG_BUG=n, WARN_ON() is a no-op so no warning fires. */
+	int expected_warnings = IS_ENABLED(CONFIG_BUG) ?
+			(params->expected_scaling_factor == -EINVAL) : 0;
+	int scaling_factor = INT_MIN;
 
-	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
-					      params->min_range, params->max_range);
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
@@ -418,10 +431,21 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
 static void drm_test_rect_calc_vscale(struct kunit *test)
 {
 	const struct drm_rect_scale_case *params = test->param_value;
-	int scaling_factor;
+	/* With CONFIG_BUG=n, WARN_ON() is a no-op so no warning fires. */
+	int expected_warnings = IS_ENABLED(CONFIG_BUG) ?
+			(params->expected_scaling_factor == -EINVAL) : 0;
+	int scaling_factor = INT_MIN;
 
-	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
-					      params->min_range, params->max_range);
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

