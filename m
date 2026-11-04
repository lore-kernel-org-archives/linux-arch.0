Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811506;
	b=jaj/TbQkgSjUTv0TLWoyvh+QWxeay2yCyIQZmZCVsTptqahLdpiL0gUnFq0ugVqWl5Y8
	 ir6E9is5KVUf4Cftnb+VPIpXnA6NoZmCy6zKRnSCoB5XwaYjYsMW3BZXo91ZTjmkdsYB+
	 erCwYxPd9OhvnqcWWRXnFkvZK5oWJ8oJYgn+y9GGK/dVvopgzx19sBCeYVAfNjA551M53
	 5VT8b5AVVNO0yKx3+jb087UHv5JywIxRgwdvGfHc6k387J0uYppmXKPEHmgnZmH+G1atq
	 tTRkllrLt9wVVpzyEA3FXNWIRru84ubkU4a6ZPZvoOqNO7wACaTurxYGfoF1+8SP3VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E3exnuIEn75Mzl8OzBk9yKBvPuDEfR29myhkVg7oSY4=;
	b=QY3pGUB70U/ypjVm3v94uEI9jrZHANdHApVk55Le8Sa8yLBtRoHnvIDzen+AxRgmwz+q
	 UMH3RPZZCH9DJ1Og/qUkraxIGdhjrHOyAYHbq8E8bfNaqZcc7MDbBc19aSgyO8uh0u6uR
	 AW1FXC3wmJK+thzfjLPB17HTXihlUuzo+lQg/YJ0Q4V046Cw/WLYADnayRt6Matn2zrtK
	 LpvYQM8SyOED14FUO3T8I6/JWm3CBOLJNCIa7cB3K0lfjb5B7JrfNpaUiyLT5NemKM1fG
	 ho4dLG6hCl9ZVVmO8LeYxZ9kLINGt4Yyu6VATOaKdf9nkHgPTNpddOGIg25Dwmqmjbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d4EEF2kO;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDE606A33E
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECDE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d4EEF2kO
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2055607eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811504; x=1794416304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3exnuIEn75Mzl8OzBk9yKBvPuDEfR29myhkVg7oSY4=;
        b=d4EEF2kOlJ9ZwT7ZAqTk4BEQB6KcUy0uA9+FyL4MbNN7Zu4rDZNZ0rp/SjEM1SHJ4i
         +t/vAUuu9SCQC3AYeOMIngo6oTmzHstQm5PfvbTiZo4E0zTT9V6oh0nnxsdi583LVoP9
         a7tSdg9pv18ePLJgUJJGIePmp4/HtLBlGIL4B4XqWh6wFW0yt6vcN7QL4y2SPKtHKdOU
         bs9e6FLPI+Lm9iDleUFUew9o5bRM5WOk+/D20EOyGWfHt0Q6311/IX/Ow+PfL0FIwOAS
         sJp03RdEH8YojNlrwn4RUuHSxdKSA/A8BAe5x43K6gSXTYuYOLC0EeO1Cb5cyDhrtx52
         4QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811504; x=1794416304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3exnuIEn75Mzl8OzBk9yKBvPuDEfR29myhkVg7oSY4=;
        b=g+Of2HTNk9FA2fty3rJD4FNLZvWfBffhj+9zh8d6Q3XLvEQZ9cFw/crnO7dT6zOhaw
         uFJ7/0LjsYoTT86cXRHWvf8BIaFpGqo5dbQ/MgUJlZZDky7HIvaAz9vNfCgPYfa5SPEt
         drZSt/FND/jYEpgLD9sBVUOqIcUs2GpfRB8AVePBDDPkVi0ZVvZcRB34gqmNKWSy46wW
         SqGeZNVviQ4ASAvTEBTStQ6e0jq4VZZhUDPKGlvTxti3TPGJNerVMiPKEGws/jJ2gmfa
         ZHd422KC9L7sYbtNr6v2lxXSJOuegIPrdgvV2SdgQ9VqjYQy/YFVVw3FvgSJHMaSXfsI
         odbA==
X-Forwarded-Encrypted: i=1; AKwUvBxxJ/YEL/Mj2p7verg/jxiKgFnoMxb1lWSvCsUSqaGfahhCZOMjJNmukJtfShj3yhnq/wXhEbMRusp5@vger.kernel.org
X-Gm-Message-State: APuU4Z9FT4zPcAOUggUZvITT1//GdIl9UThRuAET97+jkGLcfaNU88sm
	Axahsn8QuTQukQ1dgUTdvRF4SSZQuPAyVfxG6A35IlFzinm2H48MkPfM
X-Gm-Gg: AYBFou1oX8ickJgpF1fBObyFON6ERLUc401w8j8MaM9cIpqjzYm6OEZblZ7kINWgIJq
	gURZS41HcV2tJdWHSLea3u7Ms+rZ4CSIc5KurJ0DxI1KgL8s17XSr/r8DuTjxHhS8s8UcLsjNXs
	S866SG5SqHtCXz3sSfUFLT2uKVdQEA/pVX+UyH6vhrQsMOjP3LdexAP+N6xgf+yEj4UhMsGRD6K
	MG/EWEzbhYcGtwkspcIQwajPqCB1OK1IWcU5SDW0qV9sEeleQGm+6zvJPH4RgZE/kOPV38cyrbR
	79rovfJviDI3fia7IvpYoCPSn2LqUVTaScKfWdt1ZmigxIWBCB1M4790gx8C9I2dxw0Mz7MCphY
	x9iKGiSbcV4PzfnmJmfjyBEt5tcU+1lLbrg48ooVf6Jm1B6NQ9YgemWf7cWBgt2AEtrtTdFiZac
	btVNMlF2JLZZMWVFKJEUpU/1XGkTQFUHRIp0De3gTNXWcre0V7MlZXo4HZ0PY1BWvGmyI1B+9OT
	LOAR7qZyy8OIJOpKPJiBY6fvn/uIMkTLHzgbm8Mq0hHiwch4VE/c/EGkj8org/eiFi+n1L1p9TE
	fAvszc7E1RU09e6q3r1HNhg5tcdSAmZYpXzf5KA=
X-Received: by 2002:a05:693c:87c2:20b0:36a:6ae5:23e2 with SMTP id 5a478bee46e88-36a6ae52e67mr14054524eec.17.1793811503835;
        Wed, 04 Nov 2026 08:58:23 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:23 -0800 (PST)
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
Subject: [PATCH 20/28] locking/lockdep: Use hazptr to wait for dynamic key lookups
Date: Thu,  5 Nov 2026 00:54:38 +0800
Message-ID: <20261104165504.2430480-21-kunwu.chan@gmail.com>
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

Replace the system-wide synchronize_rcu_expedited() in
lockdep_unregister_key() with a hazptr_synchronize() scoped to
the per-key hash bucket.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/locking/lockdep.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c3dc84a7cef2..256f23a9041d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -58,6 +58,7 @@
 #include <linux/context_tracking.h>
 #include <linux/console.h>
 #include <linux/kasan.h>
+#include <linux/hazptr.h>
 
 #include <asm/sections.h>
 
@@ -1308,14 +1309,19 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 
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
@@ -6717,11 +6723,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
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

