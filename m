Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08E5237AA
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220740; cv=none; b=nHA3JQOpksRylA4BQDL0CXMPjnJ7r7s9bEqabPe++/Sl80nVJCrVErP4SQ487ldfa7a0VlJL0sy+GgzBagMar6fHPo1CmNAD8CPYYESKD6ZHAhgaTR1de6apFWNaKUzJEKNtRTd9Y1KXTBVJkPiFv//O62V17Sqw3bRK+yNWgKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220740; c=relaxed/simple;
	bh=ikRDPvJS94ZCR7PUsAAuEp28RxgBvB/t5DdR/IX8Lk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G93QLJ3Sc8KjTYCpBjZieQv77KJltsypyBS7HVzpTmMqvuoOryyyD4jtTXr5CYzRyGKwzjpayhupME4Ya2MnaAEYpOH5J2Gm2+9a3N+6DDUBycZAUCh/yzbwc9JfM1tUCrsaYItLS470qz2I429RiKBCIaCmFTQFwm2g7VUX68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDcH/Xg4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDcH/Xg4"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381b831d535so1882573a91.0
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220737; x=1791825537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JGfeM05iMohWhPKcbFv96DJOpIFn77eSNSRuB4K3d4=;
        b=kDcH/Xg4RjPEoEdcznaabc1cj2uwxJg4oniQl4A51j2bmvptrqvvHOf6DDAE8q80wo
         3yoLGzDuz92YOw7q+wa5u/qhtrYL+yIxtqWgxVgPj/JSkIm5JBVNRFHu6msivq1EH9Z6
         m3zbvr+9epLBV5yBHxuxmzIuDTURGKhSgWyEZg1t+pHpgZCn5M4rhct10VPvCpsfMLkG
         G0jKFtqAvGByfEsHM2fhut8K6OxF0g1xu3jrsjifJXDAY1fQzxe7J+Kcn4nefAlXesfP
         LLR2G+0ZXMZNfSkC0DW3SRqsLlKwuJt63H/D/lVgSDTvXB1lRrR/3fYJrAiE01HAeOSw
         hsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220737; x=1791825537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JGfeM05iMohWhPKcbFv96DJOpIFn77eSNSRuB4K3d4=;
        b=bFQSStYwI1YP8IsoaS3nYePZ2G5wde2POF+1hjEBSYh/5q6FZX5jK/0lxdn7ZoaMPl
         qbf9LW8DlvbQg8wtIrKFwvlfj7h/Bq3KJ8luntdByCOawubBvovbDzHU0Gj3jnZupFFO
         NBxQO8yOML/JmVU3iwgqmuQobdpMlO9lrzoosWqXLTQW0/1ETlZG7bkaxCu8YGgJZ2Op
         eDnzM5fLmBBDvXAMg65ui2mmRZpmMIJ8ZKvewEqN/jDP/4H6hVHaIh4YaE3GIoD9o3Fb
         4ZN9edNBpQdd9HMkHtlDDeUE4+mymRKJrXSQCDwRYcZkq24bWEkkMqx+y+D3ojbhDWiF
         fQzg==
X-Forwarded-Encrypted: i=1; AKwUvBxiTYjnk7s2uXiB2GH3OAbr/1iMNmwEDa38Yl5Xc/FCrHzRAEtGNCDy0u36S4Nw0MEeOFMU5GZza54J@vger.kernel.org
X-Gm-Message-State: AFq9FYLzYXIIudDwLejn8XgA15OdBR+3E7/SN5HyNd3an4kqbXXEmKtm
	R/Dh5dbDVEZEXWZqzGie45vvF92n4CJljmRQn+kQ4x7TSVk7pOmlQZ/E
X-Gm-Gg: AYBFou2bRb3C8D8/wGVf9AzJvrxXJ/gNq784zCrp+15JXYrn9mL+GSAIyGOAj3BuNJ+
	O+4f/0aFyfQofhWoz/TafEWM7dExHDrjZMz881TYMdi+1WJwh7heKn/rhjFHUq3j9jYNQerBFAC
	xKo9pNfvjKPdwvcjbNKXiQZkx2j+ogopPPId6a2yT5c8xbotLESFhryjRfwsgVH1/G9SU8l4HMA
	pFI7nNNfzX8iXqaYOY5QxZmvDAbs1+HWkRRxzGhTj7gYr2LH8cVHdoYlXf8qpZbhaigsXsjqSxT
	S5Ec8uhwkhPB8Hlp+xtsaVgfWna2Sy8j8xf26srFKx7hBFdPGd4tGxH8gEXQGJm1MM6nbUam33V
	hv0A8kSF2A2kX2CcjhFcQzi2eNPNliOW975GwIDwqJfU9S7ZyfzujnAkQdIRXOW26+1tTigQNz+
	HTC0eVVrWUaTB6VICubGS2cuRyZvIx+uIhp5Z/zaJIVwc+VxHYmQZ+ucARuO2M+Kt1QBQ459Jv+
	m6H4qNwzEW09VmBVTCSteV0rTvqVQ==
X-Received: by 2002:a17:90b:540b:b0:3a0:7cbf:b8cd with SMTP id 98e67ed59e1d1-3a787182b90mr6948956a91.14.1791220737102;
        Mon, 05 Oct 2026 10:18:57 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:18:55 -0700 (PDT)
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
Subject: [PATCH RFC v3 13/15] hazptrtorture: add READERS4 and READERS0 torture configs
Date: Tue,  6 Oct 2026 01:15:27 +0800
Message-ID: <20261005171529.1378809-14-kunwu.chan@gmail.com>
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

Add READERS4 and READERS0 configs to cover reader-active and
reader-free synchronize paths.

Both use the PREEMPT baseline and hazptr-stack torture type,
with four readers for READERS4 and no readers for READERS0.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../selftests/rcutorture/configs/hazptr/CFLIST   |  2 ++
 .../selftests/rcutorture/configs/hazptr/READERS0 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS0.boot      |  2 ++
 .../selftests/rcutorture/configs/hazptr/READERS4 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS4.boot      |  2 ++
 5 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
index 380b8402ccc9..1826be30c066 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
@@ -1,4 +1,6 @@
 NOPREEMPT
 PREEMPT
+READERS0
+READERS4
 SLOWPATH
 LOCKDEP
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
new file mode 100644
index 000000000000..c5b12f3bef74
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
new file mode 100644
index 000000000000..f5564c218902
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
@@ -0,0 +1,2 @@
+hazptrtorture.nreaders=0
+hazptrtorture.torture_type=hazptr-stack
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
new file mode 100644
index 000000000000..c5b12f3bef74
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
new file mode 100644
index 000000000000..0d0df3f7dca4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
@@ -0,0 +1,2 @@
+hazptrtorture.nreaders=4
+hazptrtorture.torture_type=hazptr-stack
-- 
2.43.0

