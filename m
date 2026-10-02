Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B654FDA59
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961037; cv=none; b=GZMw8dECdTI/UJXrbrEByeTx2Kmbfufx/xHIOb0awUZFR+fBKfXcraxFk+cKW0LnX4UecCY15AGW/RYDmtMRiwb8XBnN2hu36CcESuLmgXD/OfC0IZ+R4m5XHALLMUaHdKd9ACQGtGpiNKykc/V4b2G6TFclXu/9m7dM5/QBs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961037; c=relaxed/simple;
	bh=efWEPmj0Vc93yD7ksoAs6CSfVahXXbn88QWzVR/N9r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o85xtXPQwR1BjbjVN8W8zur8nFDxt13iV5DJMVVQT8hE5kC8bDN14KhhEpWmbb/K/9SxaDZJRMy/j99VU84QqevdTBGW+d4iw3wasembn3AXtVoUDZUo5xE4sEeyr4uioCytGEMRZL3lWF0euPgPyZpfaRPz+8klqt3sAaK8CGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc9hwhi/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc9hwhi/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so4100762a91.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961030; x=1791565830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aHGH1btHKyA9bPipQiTAK39EsUtmJmoqAt6kx41g10=;
        b=Zc9hwhi/muWpKPb1YQkRv8j3Lrxz8qHYxUikCn/vBZfDAga5Wfy6Bs323IcaMvkAlS
         uzFxtE0O/KKs3AHvUu4F+bxkBfoN230osEkRbt8rtVZbCXMzDwXY6Y9ikeKjfoXVxSZ/
         QWM1d+bYreYbQhAbZQbuOjOw/k4iEskLszWcXcoZNDs4otuZI/GjJlvECtwUvcMol3QT
         Tt6GBI/rYsNEChdK5Y0VTw9geNjQIr7E8W6I3XEP70hnIslyxCugqDb8LhsTS7vFwpDt
         Ue2cj4aiYboVa8od+cbZrNIgPWXqLQJ7JB6qreoGgRgjSCg9YurBUpC1u1d1iEzr4jpA
         gQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961030; x=1791565830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3aHGH1btHKyA9bPipQiTAK39EsUtmJmoqAt6kx41g10=;
        b=MZDFlcs/QWJ6nzeBqpkCTK2AXypuMl4ifP/qkRDKHf/3Do2kt5WTVnGlNA+ldD/cBf
         3MKemmC5KB+clwZThudoESAv65B0iGT4TmKD8Q0T49W02VuEDNDlPDzLkwP9AZe/SeDf
         VoILiUXk56Tz/hCw+2Z4ojtJrlSfwQV8AC5Pvxtbw27b/11hW+B2InZL3HWGmWl9yHBY
         HBIxej3DOU5N4fKdAhdLPViENPzI27iopKzy0ShBEuHOIvZSekNiG3nRVCmGcDlPN1Hx
         HtJdt2U30QttZLT5OOyXtMHMm3Qm1w2jgcW55f73FD+2Nt22xIsPSe9eEczDKxcH85uL
         gk+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy+3JFMAS4coqCVI5ARoSEDN4z5bAlKVhzRBA56tHhN5BgQhBT6dCzZFTJVmyZMPi6vXgLK/DGH49tf@vger.kernel.org
X-Gm-Message-State: AFq9FYKohhfNBFH23VKFBFHEz0o7QIrX7fZyjv1iVQVSgQ3jBbrwNI0p
	jiP8q25HAArK8nUvX4OZ3nnsSyAjFWsif0EQrzG7a0j95gTHRAxNU0ob
X-Gm-Gg: AYBFou23LSyt9UXCf12w1a1bONXGkXtDBb8tFf6UqmZGKX9RJrSIyJVg62B8OkpW1SO
	E29fojnVaCjS2HM5ny/4h2Svcq7Bmujz/GHRTgOj2ShT91O7zIAyFNKwh+a9tRsJj8dPrj5kL/D
	UCUUmjhS6TVkj/CcJjNw6bI7AmU67rB83S4JSgqgsgMD8BLGuydYD9JGaf19DGFlLHLohPKdR3C
	VYFx7//Q+PAYmjl8nV8VQiimxliOJe/lRzcb/DlzMhsXXwc4EyOBbzHsFct4Ue29/xBAaqcXLbk
	lHVm2S20GKKppf52bTBDY++hSVh9gGHftC1EP6EN40AqsI9jnDaxJXpmXJSlJSxiAy5qBG2G+6o
	r/CsDYwCpthlMo2urLV72QQSH4zrNuFLyC8pY71jp0dbIVEazxO/S8J31hs76IMJYzF0lPsJtuZ
	RasFePSKrrkk0iwv9hFG9A5nDSASsgRO0F+IuY42LcWhDRkrexhBt1wZAk/1l2OuBstK/NWxVhk
	TsE6xWbzG/FX9jjtQ==
X-Received: by 2002:a17:90a:d2c8:b0:3a2:b70b:9cc3 with SMTP id 98e67ed59e1d1-3a6ce5a1ad5mr3213022a91.8.1790961029453;
        Fri, 02 Oct 2026 10:10:29 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:10:29 -0700 (PDT)
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
Subject: [PATCH RFC v2 08/15] locking/lockdep: use hazptr to wait for dynamic key lookups
Date: Sat,  3 Oct 2026 01:08:40 +0800
Message-ID: <20261002170847.3653663-9-kunwu.chan@gmail.com>
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

lockdep_unregister_key() waits for is_dynamic_key() callers with
synchronize_rcu_expedited(), which requires system-wide coordination.
Make is_dynamic_key() protect the hash bucket with a hazard pointer
and use hazptr_synchronize() to wait for traversals of that bucket.

The hash bucket returned by keyhashentry() has a stable address, so
it can be used as the hazptr synchronization target.  Keep the key
hashlist lifetime RCU-based with hlist_del_rcu() and call_rcu().

Protect the traversal with the hazptr scoped_guard() added earlier
in this series.

This adapts the lockdep use case from Boqun Feng's shazptr series
to the current hazptr API.

Link: https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/locking/lockdep.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c56a7f91d72e..d1ce5ace7fbf 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -58,6 +58,7 @@
 #include <linux/context_tracking.h>
 #include <linux/console.h>
 #include <linux/kasan.h>
+#include <linux/hazptr.h>
 
 #include <asm/sections.h>
 
@@ -1280,14 +1281,19 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 
 	hash_head = keyhashentry(key);
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
-		if (k == key) {
-			found = true;
-			break;
+	{
+		struct hazptr_ctx ctx;
+		void *bucket = hash_head;
+
+		scoped_guard(hazptr, &ctx, &bucket) {
+			hlist_for_each_entry_rcu(k, hash_head, hash_entry, 1) {
+				if (k == key) {
+					found = true;
+					break;
+				}
+			}
 		}
 	}
-	rcu_read_unlock();
 
 	return found;
 }
@@ -6683,11 +6689,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	 *
 	 * Some operations like __qdisc_destroy() will call this in a debug
 	 * kernel, and the network traffic is disabled while waiting, hence
-	 * the delay of the wait matters in debugging cases. Currently use a
-	 * synchronize_rcu_expedited() to speed up the wait at the cost of
-	 * system IPIs. TODO: Replace RCU with hazptr for this.
+	 * the delay of the wait matters in debugging cases. Replace the
+	 * expedited RCU wait with hazptr_synchronize().
 	 */
-	synchronize_rcu_expedited();
+	hazptr_synchronize(keyhashentry(key));
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
-- 
2.43.0

