Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B93081D6
	for <linux-arch@vger.kernel.org>; Mon,  4 May 2026 07:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880544; cv=none; b=fPls1+NaPQIVPhrMGrEE5XG/xmLbhh9DAkJKJm9HtEJm0uON2Xn2DawMxrP8PaG3fjw86UORSVNd9iPsxOFGww+V85TsxgSjVnvZRsWELH1Ub6Nr9Y2PWkLOqfWFdq4dSeiT3/AmUxIRamu1MfsjhdRS2D83L9FoRxEdbfsmUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880544; c=relaxed/simple;
	bh=A80E02qU1TS6z15q14xBiSQVueYwuoIuM7q+neSZq1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S61Ip/FNaIwLpAfitW8u4L8YK1VhhjhQjZ5eW4fVxtxl5CBPHYM4yCQNGEfn7SDdh1KLAx5UFREZRPEGcJoxKMJ4ufQczOIEjTU6GI9KH1Ll+My4absteOFgjdJqINJfES2IEiIVafi9Yny9pyV5CdjpFObOwl8N1toh4M7jhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCfNOlSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCfNOlSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777880542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17DG/jFD4UJY3jOr7jCFbgLNy+ifxGIJEYAAkiazHmo=;
	b=gCfNOlSyoucdmz1drV046SNC+cNw4Ywj9sPVd2l2FysW12raWkio3yGyas99TtF7gDE34r
	iQyalUZg9Tt89kZJQoO+ngE7q/X53u9lpogx4YSWlSz7SwKUnsa2M/w4M44gUrtYjVk+Wu
	Rxrx3vNh6OmDkjYU5xMGMBZzKE+5x9k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-QAvuwnggOIKkmeYZGApe3g-1; Mon,
 04 May 2026 03:42:16 -0400
X-MC-Unique: QAvuwnggOIKkmeYZGApe3g-1
X-Mimecast-MFC-AGG-ID: QAvuwnggOIKkmeYZGApe3g_1777880533
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2A4AF19560A1;
	Mon,  4 May 2026 07:42:12 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C9EA1953952;
	Mon,  4 May 2026 07:42:04 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 04 May 2026 09:41:28 +0200
Subject: [PATCH v8 4/4] kunit: Add documentation for warning backtrace
 suppression API
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-kunit_add_support-v8-4-3e5957cdd235@redhat.com>
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
 Alessandro Carminati <acarmina@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>, 
 David Gow <david@davidgow.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777880489; l=3385;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=2r+YaNLYekCHScvfkm3SGKZhcNXhOrPXur/abYPqMto=;
 b=pimAHn6mKykigLlO10+2vvAltRY7TPIdHOYgqeW98bdEc+ZK26YT7z1+cMMQAe9pp5J0fvRMB
 Egmh5d5sKOyC8rUTjiV0qZJLE2iKtU53WjTgAs/8LI4pkK+8kn5azN9
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Guenter Roeck <linux@roeck-us.net>

Document API functions for suppressing warning backtraces.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
Reviewed-by: David Gow <david@davidgow.net>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 Documentation/dev-tools/kunit/usage.rst | 63 ++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index ebd06f5ea4550..25724f7e72969 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -157,6 +157,67 @@ Alternatively, one can take full control over the error message by using
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
+Three API forms are available, in order of convenience.
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
+- Manual macros are useful when the suppressed region is large enough that
+  extra indentation is undesirable, or when the warning count needs to be
+  checked after suppression ends. ``KUNIT_START_SUPPRESSED_WARNING()`` must
+  appear before ``KUNIT_END_SUPPRESSED_WARNING()`` in the same scope.
+  Limited to one pair per scope.
+
+.. code-block:: c
+
+	static void some_test(struct kunit *test)
+	{
+		KUNIT_START_SUPPRESSED_WARNING(test);
+		trigger_backtrace();
+		KUNIT_END_SUPPRESSED_WARNING(test);
+
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
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
@@ -1211,4 +1272,4 @@ For example:
 		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
 
 		// Everything is cleaned up automatically when the test ends.
-	}
\ No newline at end of file
+	}

-- 
2.53.0

