Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811359;
	b=VLQqbUpWyAEsTcP70mWb/wPSC16sWAuMh6cnIlrA53h7VehonMmBZAG2bx4lSYCYWF8L
	 4vKTdw/GQ7A+miV3SUjtm/8jumzyrf6eqv9Fsua62IgQhjSrEEZCEYxI2Fr1Anpn80yOe
	 oEw7cZt/rEpAWcnGZYJVxJIJGZHscp0PQ0w1iE5Y+nI+EHaXG7J1zK543Odz9JR6OH/YU
	 W/yaJa2tDiLj65jv42xFGJnqdhWwivhYIAg/8/4wr9D/56odldNsRooEjTHWIh8VfPXD9
	 braUWt5y4maEuqP+M3bhpNvl+CPOsQTJiUiPHjnAQuHZQG4HZ6oolPkxMZ56U8g3FAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+8KQWyBKBxvk/GyclF/OXvG/qT94C95aX0wcu8sQa/8=;
	b=CKAfOK5Ls+pC/5/wzJqmMaF3ks4gab8Tm7CRGlodoQG8zZvNU6axkLvm742sRISGBpv0
	 GcvZXD//MVPoPjyMYUtP6/WaicA18Nkj2ZllXrbrfdzrW4L0yrEeM97oh/9d4fV6lghVD
	 6rE63Ke/PD9vaeawT79VlZ/Yv1b0hiKuJr9ZFlR+40XWzIaqRN5xdN4ID2FqYGShXzWbv
	 Snn/J+YTfo8yYSh0XAyCISCFSk+HuhgzM8DoOcUFcOFDpkLvQjeo7qwgp6z01rxb2iiGa
	 ct9KFJ4kgwYbcjibOl6BfDuji5DD165DFkwr9FFTIGZRovPZRrwTJcmJ3u/KXxzBQCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EycCfHSE;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA3606A32C
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02EA3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EycCfHSE
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35b2c599f43so1894596eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811357; x=1794416157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+8KQWyBKBxvk/GyclF/OXvG/qT94C95aX0wcu8sQa/8=;
        b=EycCfHSEmnC3CFQscfhGc9K6l+n6dnpWstzvFxbY/sgIPYFykCn8zDBIa+oXgrvcMa
         lATgPV090nSh34SBkcJD2o5P/IAiOOUJZ9T6EqjWYQwtHFYs3+jJlnP0aSl5YJKnBvsb
         D3HZepsIez9R0xsqvqmbIkK14qdC8qmo1F+tt9+MY4Mgn2c1pNCmzYLqFkK7IcLSP3Ez
         nMiNU6HJ72wXlRUFfjTnzD+XvBK+8GXYnpb8gQh44yzEnH5gO2xIhUy2Ajro6+0/H3a6
         LV4ZNH2ZAQ2mJ/pmbz/77D2ocF1i4FHzguQLCPdF4LogdcdszkoGbHdgKYSUFDWuTs9G
         pCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811357; x=1794416157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+8KQWyBKBxvk/GyclF/OXvG/qT94C95aX0wcu8sQa/8=;
        b=CPDnKNn0P+AeK1GV/QsnbkgJcITjAPrbNNU49CgpRZ+sXdJFHJU4blYL3tNHFDWp9w
         xv5/EmC9h1EpLT81bOQk67I2J+6ab0tHhqaevyGY4HxZZlBFEV9ciEofQZkbY8P6nwdp
         xN3JUhJ7cpDVyd2K36N8aTUjTRNImPh9Uvk06o/gXIdJXUI5X+McEM6nmVSmW987Rpj9
         4+iAd9ArwOS5HLInNcmUD6psUPk+XiFF3NwI6qoGjfKmyq+w/a0HXJB/d5nDrusJJGFi
         pY8PYdnjEMU10c9SQj23CXU4AToBZbL0KTntJ6QoOh8lnI4NQa3mdDpX2htu4uVqegTZ
         U7pg==
X-Forwarded-Encrypted: i=1; AKwUvBxbqL4w1yRzovc72aNTwd0oeTqY1MzTXNepGDlanprdZg3t1QJH/uWCrXBolKiDhOROQK/7k4XBoMBv@vger.kernel.org
X-Gm-Message-State: APuU4Z9OoZylPXLy4mp9zstNeB7hJF+DcTpOhVQulvKjDt+MJV9pLcWY
	IexOucoDDhrU9Bz6ojRj3Odcina3ws4lxbCnST2TB+iRGa3NeZRwI1DP
X-Gm-Gg: AYBFou3LYSoRiIkPmjVGfdTtQhbKc2dStFHcmv9fQOsFeiHEFaFGXBb2dqTSmweb7LA
	R7dimvWDitBbdBPcaXN9zuej9WjfUiQBG4H8IdLvwvazN0WUCLVRCPtFP9hNkpnl+qiWC0YyZ5+
	DDodlSANzileBVmAQXARXvCv8TEdP1B+8Reuu6oPj7YT6fZegxWt5FzYRHQOb5j8zHyNnaaol99
	Oi+LQ5Pi06GVMpdutJsMQIuM25Xc/YToCIsMNgxRTzd2gcQv6YLZ58TC2owSrHRJpBurLgf7QHc
	vwtnLR7VrrKjnl4mVlicYGe4dS5kLNA60qaMgGWRXTXvDkwAbVx8nlO/foKSMT7dXdYwTCNVHC3
	n4vQXYiKqChmH1ZmhutwU64EOtrk45a2XTqW80q33xuhMXsR/FvhfAtro8pgjTzSXYSz/DArYjn
	tf6BV5xWzBtrQacpEaWYbGcb++CvkR1ngZFWNoRlHR6eO6lUVZrJXTXxK3MAf+PwKe6uIEH0+ZS
	OT2EVQfUO0OoLxoj3kajqOB6M5AalXyjzcGhPAAbRpetu3csMxhSZovzpvWH1YWm5mluYMnhq1L
	rjolFXH6EcAqGXQrcOsnq7bs6auqQOaZIexwRy0=
X-Received: by 2002:a05:7301:2a95:b0:36c:9afe:fcd8 with SMTP id 5a478bee46e88-36c9afefe8dmr5108211eec.30.1793811356604;
        Wed, 04 Nov 2026 08:55:56 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:55:56 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
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
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 04/28] hazptr: Add debug option to force the acquire slow path
Date: Thu,  5 Nov 2026 00:54:22 +0800
Message-ID: <20261104165504.2430480-5-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH: makes hazptr_acquire()
skip the per-CPU fast path entirely and enter __hazptr_acquire(),
even when a per-CPU slot is available.  This is useful for testing
slow-path locking, especially with lockdep.  It also lets
hazptrtorture exercise the slow path without requiring the per-CPU
slots to be exhausted.

Note that the forced path skips __hazptr_try_acquire() rather than
running it and discarding its result: a successful try_acquire
publishes the address to the per-CPU slot, and abandoning that
publication would leave a slot pointing at a stale ctx, which
hazptr_note_context_switch() then dereferences (use-after-free).

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 include/linux/hazptr.h   |  2 ++
 kernel/rcu/Kconfig.debug | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 3372b1cdbee6..299ad8a07156 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -271,6 +271,8 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	ctx->acquire_cpu = smp_processor_id();
 	ctx->acquire_caller = _THIS_IP_;
 #endif
+	if (IS_ENABLED(CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH))
+		return __hazptr_acquire(ctx, addr_p);
 	addr = __hazptr_try_acquire(ctx, addr_p, slot);
 	if (unlikely(!addr))
 		return __hazptr_acquire(ctx, addr_p);
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 7c3c6017b266..3a2e9d7f58f8 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -265,4 +265,14 @@ config HAZPTR_DEBUG
 
 	  Say Y here if you want to enable those assert, N otherwise.
 
+config HAZPTR_ACQUIRE_FORCE_SLOWPATH
+	bool "Force hazard-pointer acquire into the slow path"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  Make hazptr_acquire() always enter __hazptr_acquire().
+	  This is useful for testing slow-path locking, especially
+	  with lockdep.  It also lets hazptrtorture exercise the slow
+	  path without filling the per-CPU slots.
+
 endmenu # "RCU Debugging"
-- 
2.43.0

