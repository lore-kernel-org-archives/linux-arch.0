Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890104DE73F
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220619; cv=none; b=lo6mf5SbPX4Hvar6DXwvW2CtsV10iCDptS40OO6hGvjJZkkj2b96H3ZJ3tRCExXfDE/mJq8Dz+pxA80KMxC4yZe1bXxsiriNiL0mzA1FAnpfTxkBkiTTVpjq1jUr1qmZ7Izf5S3vxm/BwOOV9UZ21cmLdko4u4CD7JWz3EqfqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220619; c=relaxed/simple;
	bh=9wEbN2n5LQFaWEnfgc/fjcdj12CgL82mEepIN/jxNKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNhlsfxs9+xK+8QT5g/hyDwHlmGpjKpPGMjGMOrjSksWVFqM0Calwkf6+1X8hqbwGho+/8Cq6LvcEEOwUNAja8Kv42gxqwLw5WPwwziA8AhRpUkxsZFyMopbLipAHZoSz91dbvkia9By75UA+4WGB5pham1SDOR8eLZbCkuzrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbL07d6a; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbL07d6a"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so1124687a91.1
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220617; x=1791825417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InVY38nfxVAqb/WmgYkdpIBcCwx01OQ8UJwYgwWPio4=;
        b=QbL07d6azUEZP/YgXxJwnZHrBE7Emtw9fZ9uAoWdNta0PxzGeVEH9cdyBwnP0kM6nW
         NhPhFcVGXVi52g3tTCcTgvhZjgV1scowezYg8/MdHe0QydTs66hR7bIQ3mcWDtioq6Ht
         wTtjOohdhBnmATxJJ9ny3J4xzb99AGqW5DWp3WCVnfPpBA4HA7iFFwm3QPM+szpCRkX+
         nD6oV1fLhYLz9h5rYwwucbcvd/170kFqdeK6Fd1y76IoE7fWWWeNnZA5ZfwiJZ5Mvm9D
         1Vwe6lJLcknwrDexGy2Na0LwWbqW6sRuVQ+Fwb+fEt/50MEDUSNtU0kiGCLKteSvHbMS
         64LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220617; x=1791825417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InVY38nfxVAqb/WmgYkdpIBcCwx01OQ8UJwYgwWPio4=;
        b=tDP2lESIxwui8ewMPUEvK+ShUEeTMdhTZBeUfqzVCscDLrQhNqbUD+UyUDein+j6Dh
         vJQBCJivtjxhBCMkdySGbejMBIdxk+ixYOhlM4LsyUSo5gsIyc92zuo3pYrbKQQjrnzZ
         m7bmufcfykjpfq+HRR2VN5mNxKLJnt5zWmNj0zhlL1ae0H5HznUeRfA39ZEnQrqkwrKL
         YcsGhMjVoS7mCoIq4cQGd3qr6rGF4R8f+qapJ5FTJtUg4RP3V/COzFYDooY9KLiyvr1w
         G8Jkrn5qHjYnPqUmaXYV7j7DHFRbc9FvUrYq5T7aUpoO+RMrkWL9Oxa/GAWLQp1n7pUi
         j9Fg==
X-Forwarded-Encrypted: i=1; AKwUvBwvvSeZksunjTnDawrSLWywzYYd+fqNVHU5qMAFjXMlEkAgwmeZemb9RCSibDoOwBGSYUeSecEWrAf/@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ254ktMiP5RMLZJwwnE1b8AOfa4JrGerUwRw5aIo+96+viHnR
	h4efYPGbeT2biUYP8IH+M5vt1GC6DvG9J7lyXO6j9GmgK9nedr7GQy81
X-Gm-Gg: AYBFou1Jpln+/Kyr1Oiua0f6Y6qoUqshoIAWgEyOKbz2oHprdpjEAw1zkdGJxk4Cy6n
	QiEQhvx9ed4rv5ZxavgVeMuWIU7gwYo+vunReiecyBi3kkXnF6GplX5Wg5ZopzGhrLHMgaNZ57/
	ClmUv0QddY+KTNKB9eXeVdktfDAwDO5UgU0/CYrpqfrM34k7ZsM5AC+hpXOs/XGyBosclFnWNy2
	ouaXE5YYgqNb4nQSk9gi8Z86ZQTb3q6gK/4sw+6T3AsfTkFwFWgzs4UWEB4dDRMIkz1jlPny1cd
	Bt0e1zINstBeWYRYJUb6Iee8PzGjUuJ/owst4xlWzRPR/QBoxl5wHCBbGEHenISOeAWVA2DnwFp
	WdWcAHJaiuCfn3BQOlW2GTJt1RbZskTNb6hTLk7Du9gvcYZmqMLQMqZx/VXhT15LhqrZxLaulpg
	pDNp7gPBFB69teOb6VtPryhvDNfufkXP6AxtMEc7/3SwO5XvC8aYzRLOEpFaSw50fk61oFgzdq0
	jUoRuPKyJtSFW5NgursM/TptDNUwg==
X-Received: by 2002:a17:90b:3e85:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3a783504695mr5636453a91.44.1791220616043;
        Mon, 05 Oct 2026 10:16:56 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:16:55 -0700 (PDT)
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
Subject: [PATCH RFC v3 05/15] hazptr: add debug option to force the acquire slow path
Date: Tue,  6 Oct 2026 01:15:19 +0800
Message-ID: <20261005171529.1378809-6-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005171529.1378809-1-kunwu.chan@gmail.com>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debug option that makes hazptr_acquire() always enter
__hazptr_acquire(), even when a per-CPU slot is available.

This allows the slow path, including its lock acquisition, to be
exercised by lockdep-heavy workloads.  It also lets hazptrtorture
exercise the slow path without requiring the per-CPU slots to be
exhausted.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h   |  3 ++-
 kernel/rcu/Kconfig.debug | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 275cbe54b075..4ee02d23abc9 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -245,7 +245,8 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	ctx->acquire_cpu = smp_processor_id();
 	ctx->acquire_caller = _THIS_IP_;
 #endif
-	if (unlikely(slot->addr))
+	if (IS_ENABLED(CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH) ||
+	    unlikely(slot->addr))
 		return __hazptr_acquire(ctx, addr_p);
 	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
 
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

