Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B8D36495D
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848228; cv=none; b=J8LZ+SN4ifikucZo9EmCEMoGuZUa4dqy23oJch1gxV70tQHzNnPcKrJszyjcb1ddYB3nsqarvsXhcycv+xVC8Mm9sNC1Q1bDlvhxOnZOcp1TyN0cKrG2OGzDCr81GltDNA0S59jIm4dpliZGwFDrKScvQh8Nnw0hNQ6k6aQ1fNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848228; c=relaxed/simple;
	bh=95rnVbuPoEqYoOgOEmXgRRLmt/DgdbJJ5HiCjeQHGDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f0uy2h2XrUyvzJZ5bjs9nTOD/V3Crknpq8z9X46rM5cm215vB05j6fL26908GI/lXrCmqIyT7+eCHcaxqvK5SFrRI/Rxhgw1rEKJC9oWxmRFcQAX78E1CyO/jqV3NqHfwuE5Xxym10+7Rq++QJ24n0sp95UVgKeJVJt7NF/fgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9iuksA7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9iuksA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778848225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmxOVGUrnxS/H09zubyapT22aA5Jy+w6JF95xU/Ftgg=;
	b=B9iuksA7D9voPIoqHKEqcFm36pUoS0VdUimQ4A5n+NXUZezEutVi7xMqy4dM9Ur+jRpY2H
	g4FVEBYRlgmLunTDpReChsdxTrFDjtyZcsDm6gIjFCahYORoF/EzH7ygOX4kaiDlUsbVfj
	prNEjCLa5DGjpAp5oWEYiBb6TRJqXcc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-3Vv-EyRsPmip27TNJEM9QA-1; Fri,
 15 May 2026 08:30:21 -0400
X-MC-Unique: 3Vv-EyRsPmip27TNJEM9QA-1
X-Mimecast-MFC-AGG-ID: 3Vv-EyRsPmip27TNJEM9QA_1778848217
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 276EA18002FC;
	Fri, 15 May 2026 12:30:17 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09B401956053;
	Fri, 15 May 2026 12:30:09 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 14:29:35 +0200
Subject: [PATCH v13 4/4] kunit: Add documentation for warning backtrace
 suppression API
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-kunit_add_support-v13-4-18ee42f96e7b@redhat.com>
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
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Dan Carpenter <error27@gmail.com>, 
 Kees Cook <kees@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778848177; l=2728;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=YX7AMC4Z3qCvd9o2GGoQ6LMsoUJS/dulVvDsXv5Qzg4=;
 b=T/lO3tsthHpXkQtJqjkRl6FeIMwW3FihLvtB6rwG3WXQKPuvaApLNcK6qS/KJciDqiMrxuTrH
 dsR5X2uIaZ7C4ER7OAqHaQ6ky5bCHLmTstRZ1MCaXxbm7toeGhFe5C3
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Guenter Roeck <linux@roeck-us.net>

Document API functions for suppressing warning backtraces.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 Documentation/dev-tools/kunit/usage.rst | 46 ++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index ebd06f5ea4550..1c78dfff94e8a 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -157,6 +157,50 @@ Alternatively, one can take full control over the error message by using
 	if (some_setup_function())
 		KUNIT_FAIL(test, "Failed to setup thing for testing");
 
+Suppressing warning backtraces
+------------------------------
+
+Some unit tests trigger warning backtraces either intentionally or as a side
+effect. Such backtraces are normally undesirable since they distract from
+the actual test and may result in the impression that there is a problem.
+
+Backtraces can be suppressed with **task-scoped suppression**: while
+suppression is active on the current task, the backtrace and stack dump from
+``WARN*()``, ``WARN_ON*()``, and related macros on that task are suppressed.
+Two API forms are available.
+
+- Scoped suppression is the simplest form. Wrap the code that triggers
+  warnings in a ``kunit_warning_suppress()`` block:
+
+.. code-block:: c
+
+	static void some_test(struct kunit *test)
+	{
+		kunit_warning_suppress(test) {
+			trigger_backtrace();
+			KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+		}
+	}
+
+.. note::
+   The warning count must be checked inside the block; the suppression handle
+   is not accessible after the block exits.
+
+- Direct functions return an explicit handle pointer. Use them when the handle
+  needs to be retained or passed across helper functions:
+
+.. code-block:: c
+
+	static void some_test(struct kunit *test)
+	{
+		struct kunit_suppressed_warning *w;
+
+		w = kunit_start_suppress_warning(test);
+		trigger_backtrace();
+		kunit_end_suppress_warning(test, w);
+
+		KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(w), 1);
+	}
 
 Test Suites
 ~~~~~~~~~~~
@@ -1211,4 +1255,4 @@ For example:
 		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
 
 		// Everything is cleaned up automatically when the test ends.
-	}
\ No newline at end of file
+	}

-- 
2.53.0

