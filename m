Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E013093DF
	for <linux-arch@vger.kernel.org>; Mon,  4 May 2026 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880534; cv=none; b=Dtn2O4g0lpFNGM80VIhpXRdBnEBqOBKI/dyGfIDz2yiVzeU1eMaF4M9gf3uafKEYchhRfaCZO2kCh4p4fY7hTWBoS4Ka2dcOFQYG52YFM5Ry+vcquSyErF9kp9aagtci7yVsFbAyssCG5Eesh6buSxxS2x3gKozx8CqCSMjeMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880534; c=relaxed/simple;
	bh=8CmZDGYXicehtCZjE1XNTtDp93zzvSMc/ymRifgJo64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUlAgW2MAiOE1r/gwe/Vl1fcrfiR3idGAGFaCjEynKyWjPexcSt9qlWXr+mwp3oEhoeu4fbW/R4jcPXECuyEo+rma3783FIowlQVhEfZZp2MkchIoh0Y2meFQbxTySbtbv14sUdeNyQXDNQcbtrL/sH6z0mf9OE2p6akwaXw1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzyTVGeT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzyTVGeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777880531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOKf73DcJr3/JAze0LuQpsRljfWR1d0ve3pogQMoikE=;
	b=MzyTVGeTvjkVe7Zoa2wZTLtgQPUOD6PpNRJBryEDtjH+N3MW3WqukeddkNRw87hqJd4giH
	iLwT+Eo/ynr+KzA/pCpafYl1kvx2EjgDB0MACVkANsdqA848lvQorbylm70TUVofHw4Ey0
	C8ds56qXt4cDTwEYqwkE3kc1F4Hg2og=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-oRkOntUwMsyWrjHIIS31fQ-1; Mon,
 04 May 2026 03:42:09 -0400
X-MC-Unique: oRkOntUwMsyWrjHIIS31fQ-1
X-Mimecast-MFC-AGG-ID: oRkOntUwMsyWrjHIIS31fQ_1777880525
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE5E21956088;
	Mon,  4 May 2026 07:42:04 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE79D1955D84;
	Mon,  4 May 2026 07:41:56 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 04 May 2026 09:41:27 +0200
Subject: [PATCH v8 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
In-Reply-To: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
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
 Dan Carpenter <dan.carpenter@linaro.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777880489; l=2693;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=bGqCNzhIOGnVl/NfnUqExLX0/n0ZkI03UY6zDNsA5Oc=;
 b=Jb29iLKaaVTR7v5Dlr1/i2Ay+tOHiXVtL5zSM8WqXh29zv8ysgXgUHMDrE0l6z7IQH7slKIiX
 vNIBwlPkSVqAHz8EpMgT6x8oGYb3Y71H/+mI7IaMSCNPTqLSIsvuS26
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
Acked-by: David Gow <david@davidgow.net>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/tests/drm_rect_test.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index 17e1f34b76101..818e16e80c8f9 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -409,8 +409,16 @@ static void drm_test_rect_calc_hscale(struct kunit *test)
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
-	scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
-					      params->min_range, params->max_range);
+	/*
+	 * drm_rect_calc_hscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	kunit_warning_suppress(test) {
+		scaling_factor = drm_rect_calc_hscale(&params->src, &params->dst,
+						      params->min_range,
+						      params->max_range);
+	}
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }
@@ -420,8 +428,15 @@ static void drm_test_rect_calc_vscale(struct kunit *test)
 	const struct drm_rect_scale_case *params = test->param_value;
 	int scaling_factor;
 
-	scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
-					      params->min_range, params->max_range);
+	/*
+	 * drm_rect_calc_vscale() generates a warning backtrace whenever bad
+	 * parameters are passed to it. This affects all unit tests with an
+	 * error code in expected_scaling_factor.
+	 */
+	kunit_warning_suppress(test) {
+		scaling_factor = drm_rect_calc_vscale(&params->src, &params->dst,
+						      params->min_range, params->max_range);
+	}
 
 	KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_factor);
 }

-- 
2.53.0

