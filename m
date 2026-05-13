Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510E2F8EA2
	for <linux-arch@vger.kernel.org>; Wed, 13 May 2026 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657507; cv=none; b=qnPCU4TdxYMlnC2I6RUlZqxnOt+VJzYUTh88b3RY4UEQ5+jBTqDwYSiOirEjr9CFwg8TBPQmmAIvKidGqPZ1uLjaEs3SvrX71HGM+ICNW3rrArlx7gwR9mROaTt184lc/0+mQpMjLMpU0caM3/2AmfhxNj2Fpyr1ROgGNtp8f/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657507; c=relaxed/simple;
	bh=Jiy75zbYAgeKNuIygnOMQiUSxx3UFwsadKkA7BaRfmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9OFCTY+4Ei7Azjoq7xMBLIdptTGhGDWIN/P03G3jEyll21LX0RdJY5cX5OvvMR1+4H2AI/yCeY3R1nOg8TnImKK8CVdxPmNqSui5n8/4GJ8W20CZq6U9DO0SKN5dc2VBF0D5suCXUmFd1Vcia7Vuu5zJkKabqSYu+1ZIo7+UuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIe2cK5F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIe2cK5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778657504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VmwbyIr43DI9aBRn14iL8hIHXkG+/dVlVf1GkheCho=;
	b=WIe2cK5F+Jf4di6Z+fPdqSRITQz3gxNvuKdinfoBufu0e98ZWW9TfAQ8b2Da5W4NfJSxR0
	uTyWIYZ6byad4dSMhgYCzbvtt0ZT95fxpq+1mOyh6SPt12B9qPEWLGcFstGGDZD9pDBkfF
	serfc7pq3Kye5njr49VdkiltIOtfq+A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-psgeaDq_MP-F2Pmj9CSbBg-1; Wed,
 13 May 2026 03:31:40 -0400
X-MC-Unique: psgeaDq_MP-F2Pmj9CSbBg-1
X-Mimecast-MFC-AGG-ID: psgeaDq_MP-F2Pmj9CSbBg_1778657497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF693195604F;
	Wed, 13 May 2026 07:31:35 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FF3B1800349;
	Wed, 13 May 2026 07:31:27 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 May 2026 09:30:53 +0200
Subject: [PATCH v10 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260513-kunit_add_support-v10-3-e379d206c8cd@redhat.com>
References: <20260513-kunit_add_support-v10-0-e379d206c8cd@redhat.com>
In-Reply-To: <20260513-kunit_add_support-v10-0-e379d206c8cd@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778657458; l=3516;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=hoEgYTpw6Lu8CA0ZeNX0w091KWR/npNvIhz8UU+VX3U=;
 b=agey8CnWb/SCE3tMfZk9IcrGlaI6GwN6tZSlAkFyH12f++g9/Ja7BQ8Yx0+OjyEqIIxpX4or3
 1oeBpAafhZYCkAZQrVCO4cP2MnR5k0dvrPmn7V1ua/Ag9RBSfS3mZ0C
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Guenter Roeck <linux@roeck-us.net>

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log and distraction from real problems. Additionally, the
suppression API allows to actually ensure a warning was triggered,
without parsing any kernel logs and keeping them clean.

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
 drivers/gpu/drm/tests/drm_rect_test.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b76101..ccc741b6191ff 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -10,6 +10,7 @@
 #include <drm/drm_rect.h>
 #include <drm/drm_mode.h>
 
+#include <linux/limits.h>
 #include <linux/string_helpers.h>
 #include <linux/errno.h>
 
@@ -407,10 +408,20 @@ KUNIT_ARRAY_PARAM(drm_rect_scale, drm_rect_scale_cases, drm_rect_scale_case_desc
 static void drm_test_rect_calc_hscale(struct kunit *test)
 {
 	const struct drm_rect_scale_case *params = test->param_value;
-	int scaling_factor;
+	int expected_warnings = params->expected_scaling_factor == -EINVAL;
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
@@ -418,10 +429,19 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
 static void drm_test_rect_calc_vscale(struct kunit *test)
 {
 	const struct drm_rect_scale_case *params = test->param_value;
-	int scaling_factor;
+	int expected_warnings = params->expected_scaling_factor == -EINVAL;
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

