Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080D3A0B2B
	for <linux-arch@vger.kernel.org>; Mon, 20 Apr 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688161; cv=none; b=syniaVbaTVJ31mMgLPiTCBJPB1DKiCfLRBtmUKaWzbVDoUBNFuSzdNThDFEFlWUvbv822kb57IfhsHdyPJQ/jEgzmPDjazBKg3g3/5EP+Mv+jDtHyfVNBaVCVplVxmdLJzDOYJyFH0ZnEeVW28r1Cr+OxzU25GWrmCocaNxPitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688161; c=relaxed/simple;
	bh=dbQSC4BSME3eCMku0WzEnLwxciWEWu9GZ+riAUQr4Vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIz1ZDSgPyBHwD/1WeT2vui+PDEWeeH6ZUuxrvgIoZWyZY4Y+Bfm7/My4aBtqZ+gDsVuh14hXeUjdUPZsuyYz86otRVEiYzy/sKKtL7+OIS+X1edP4cNcrzZ/FmYjcM27XLUqpXLo+jpya1dsoCm5BrAy00tKFEA140AXPyLQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+FKpHA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+FKpHA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776688159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9wNNxm7+fJjttMUkZW8s7VuVwYypLZT4Qaeba7221k=;
	b=I+FKpHA2Mxqh4a3bJjDn+gllNOWddrWS5dcMYwv37McJQz6zcU26T9T4FyxdnK22A0WQ7H
	xWxqTWan7qplBj2pqUTy1OW+JL87bnEQSZFOaabSmm6EWM6iw528k/ZyUAE82GdMsh0LI/
	mKmJGB5/g0k17p2h/MXhqH3b7qJEu8Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-h_fwfMKoPlSYiXvnMsViIA-1; Mon,
 20 Apr 2026 08:29:16 -0400
X-MC-Unique: h_fwfMKoPlSYiXvnMsViIA-1
X-Mimecast-MFC-AGG-ID: h_fwfMKoPlSYiXvnMsViIA_1776688154
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8802519560BA;
	Mon, 20 Apr 2026 12:29:13 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02E55195608E;
	Mon, 20 Apr 2026 12:29:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 20 Apr 2026 14:28:06 +0200
Subject: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
In-Reply-To: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, peterz@infradead.org, 
 Guenter Roeck <linux@roeck-us.net>, 
 Linux Kernel Functional Testing <lkft@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776688120; l=2448;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=xJbFk9/mo8QSw4/wL3AlWKtaC4Q4ltW/+TVz3/PofkQ=;
 b=gVFlgGJk6seGtcX78y/BcpLHRxJDayUArWOoDfuMQw81TZcKi2J8oBj+UhcDZ+JfypZqXBzXi
 5RBbni2EXXgDhGPrcRd1ijE4rDBoFpecSLhiXfiSqkdNMu38m5nsbT6
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Guenter Roeck <linux@roeck-us.net>

The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
intentionally trigger warning backtraces by providing bad parameters to
the tested functions. What is tested is the return value, not the existence
of a warning backtrace. Suppress the backtraces to avoid clogging the
kernel log and distraction from real problems.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Maíra Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b76101..1dd7d819165e7 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(test);
 	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(test);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
@@ -420,8 +427,15 @@ static void drm_test_rect_calc_vscale(struct kunit *test)
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
+	/*
+	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	KUNIT_START_SUPPRESSED_WARNING(test);
 	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
 					      params->min_range, params->max_range);
+	KUNIT_END_SUPPRESSED_WARNING(test);
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }

-- 
2.52.0

