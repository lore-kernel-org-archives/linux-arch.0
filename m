Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137D4FC8D1
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960993; cv=none; b=sIMpPhUXoJdN9UjhfXrysbEGOOJmmVIpz9Spwi/hkxP/FPR0OcyzS+E2uC8frCfu0YORi3EYOWsjGRj0UaYq5MDszf0IW6tie+aE0tsBsNb7OpoeIslKMOSM7yvljliuin7g4PtNPqX/VQgKuqOuGCTMRh8Y7PG3TkzBizbJTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960993; c=relaxed/simple;
	bh=8NuyF6qDUWQBXBIkLeP3/lavelfuwnWRCmtSE2YKnuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A67yseXO6qw2HFVcwGBA/6eW8VHWmGkAPRuxeCY2qzqupviJqUC2uxh/TFRzsk3GK6mJNgNtOzWQrh5jpF05RviFPpsqdYaADYtbfbx7wKBonbUC1dThbv7/Vimzmy4PfQdoqHCQPuoc8hmg/8gMosk2sloCfJeRj9ghBb1lk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNjFMNFv; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNjFMNFv"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6d9baf76bso668273a91.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790960988; x=1791565788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtL6vbzPvQXVWHTKwirmF+KIwLuuD5CR0v0OHwTiljs=;
        b=WNjFMNFvKfJ/1IDsq9qowgsjjFhOqzTdxDhAn5mfmVv2jV/R4X+ceVNQMQqs11atoJ
         Eg1fu01GcZ1ii0pJExuSRo2TUokI0P54HGPAELFfS0XSOVDlInbOQ8yt1Pix+BOWA6Fj
         KcH+2omNMQh2taPwqtDmr3TOElqqTnysA12XZ6MtS5syW7jcchtlCdvSpm9gmrZXYXyy
         fdGs7wPA4bWiRlyPt+H1It17NCvrQAag1XGULJl2wsfxYKjWWdGXqRDj2KRlvt5bKlPK
         RBXxJ8PCvkQ3dpQsDQ38sGOHY4qUVXU3SpcgE2Ds5k1nauOc9P4O0qyqpwSGpY/utol6
         aEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790960988; x=1791565788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xtL6vbzPvQXVWHTKwirmF+KIwLuuD5CR0v0OHwTiljs=;
        b=u7TjJmLiqg8WsxwH4j3RVBEYg7XOsDRq4QXuvWm1dXoj9ode8apNNiCDMGwT6dQmOJ
         GPOY8SZH5tjAU8pKeaEsFyiDLm2AmTqpDZP44CkXQu2j74XLXyIf7WSVSrkdX9yrLuYM
         2IWBX8FppcxB3Brv4BvoCpK3z8BbI/5PGyC5gTQ+0jnBQ8u3IoOoZgKzzznVW+TFmfjS
         168FPSukZDi50cbUesTAGLiOu/i6YVN+YdOf2fHlC/FjYlT7VKsWZf5ts8tpFdmlJD0V
         bJLWZhGa3WPo9C44DQS4w89ullBybhUvaDZGmPXI/+99boGsi41Txr/OpXWNiVOibguo
         lt3g==
X-Forwarded-Encrypted: i=1; AKwUvByWrkHf6fp6rjSHl/sNvXtaMToVpMZdY/PeweF/gCLBfnujy+3oFxeDCZcYEXR3cGOTfqGo+ELiWw6I@vger.kernel.org
X-Gm-Message-State: AFq9FYKvAGTtwJ/EfaGW7dUDN3ABMtQO17SGUhSDffcPMsDHszxlf/hW
	unG9wpe+e7vUzfM83h/DSQ+QHjeW3TZJHut17njXLxdePUS7ktXfI2iW
X-Gm-Gg: AYBFou3o7qE6/FMBKEL2CN1fAhM9gm1vabGtzVdWO+zBpZhwPuUt5GvF15L7rsmHjg4
	wmYHg+RH8SmDl4SuLSYUoeVj78LYhPb+8Z3A6MHzMF+HgSG0gsWqOabcIXZTlKpkiqJp3q+IKgp
	3MdMmzXTgBQbbGSHT+t5/mX8GBwtmC9qgeN0L4Y69JSj9AQRnQHU6o8uTEbPTAPfj4LrdJvHq+l
	61yVOg7wjyXqlK5LaU66VXj1vf8sCqAsK6AxuCqofjlLv9mcAGfGk2mA9ModcZZlPqLllgXRRFL
	TOJxYVX407RtJlNnoPq7T8N5Nhucnvemeia1FP5ch5zZ+yHCAk8W3YOdGI94OFpwXIg3MUEvOLd
	QX7+FjbkRA68KliI+LqALrIWB3xW82qBBakOmf73Vxu7oZuS+u9KEDlLgQcw/W9IqiKUse2FYAZ
	91gXToyWdF/PtDq1AHEFODflc1N/I/HI6Xmw/88DsB/P8VQrAXFQEFNUug9RL7eYVvFujxtnAgW
	eB3YNvL5TyHBmHnhA==
X-Received: by 2002:a17:90b:564e:b0:3a4:e9e4:37f9 with SMTP id 98e67ed59e1d1-3a6ceaeebe3mr3029048a91.31.1790960987338;
        Fri, 02 Oct 2026 10:09:47 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:09:46 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v2 04/15] hazptr: add scoped_guard() support
Date: Sat,  3 Oct 2026 01:08:36 +0800
Message-ID: <20261002170847.3653663-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002170847.3653663-1-kunwu.chan@gmail.com>
References: <20261002170847.3653663-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a scoped_guard() class for hazptr so that callers can pair
hazptr_acquire() with hazptr_release() on scope exit.

The guard holds a pointer to a caller-provided hazptr_ctx rather
than embedding it.  The ctx must remain at a stable address while
the hazard pointer is held because the slow path can chain its
backup slot into the overflow list by address.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index d1670121947a..275cbe54b075 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -320,6 +320,57 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 		hazptr_unchain_backup_slot(ctx);
 }
 
+/**
+ * struct hazptr_guard - cleanup.h guard for a single hazard pointer
+ *
+ * @ctx: Pointer to the caller-provided hazard-pointer context.
+ * @addr: The address returned by the matching hazptr_acquire().
+ */
+struct hazptr_guard {
+	struct hazptr_ctx *ctx;
+	void *addr;
+};
+
+/**
+ * hazptr_guard_acquire - Acquire a hazard pointer for scoped_guard() use
+ *
+ * @ctx: The caller-provided hazard-pointer context.
+ * @addr_p: Pointer to the pointer that is to be hazard-pointer protected.
+ *
+ * Acquire a hazard pointer using @ctx and return a guard that
+ * cleanup.h releases via hazptr_release() on scope exit.  The guard
+ * only carries the ctx pointer and the address returned by
+ * hazptr_acquire().
+ */
+static inline struct hazptr_guard
+hazptr_guard_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
+{
+	struct hazptr_guard g;
+
+	g.ctx = ctx;
+	g.addr = hazptr_acquire(ctx, addr_p);
+	return g;
+}
+
+DEFINE_CLASS(hazptr, struct hazptr_guard,
+	     hazptr_release(_T.ctx, _T.addr),
+	     hazptr_guard_acquire(ctx, addr_p),
+	     struct hazptr_ctx *ctx, void * const *addr_p)
+DEFINE_CLASS_IS_UNCONDITIONAL(hazptr)
+
+/*
+ * The ctx must remain at a stable address while the hazard pointer
+ * is held because the slow path can chain its backup slot
+ * into the overflow list by address.
+ *
+ *	struct hazptr_ctx ctx;
+ *	void *obj = ptr;
+ *
+ *	scoped_guard(hazptr, &ctx, &obj) {
+ *		...
+ *	}
+ */
+
 void hazptr_init(void);
 
 #endif /* _LINUX_HAZPTR_H */
-- 
2.43.0

