Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE824CDDF7
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954298; cv=none; b=br37uW7g7W15BeVQZAPXYHL6t+joCI9P+Ahkrd64JmVVq40Ou77wZEH/QzRkAVYy5mjdZXT/EfuWtDICreCTSQS9+23mGUpowvldL8lfZ6ERdnNbhjo1F6amBeSjf7ayCgft4I88jVSq1gObAjAJ4vzJsYoQ2dBCral0kkMeY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954298; c=relaxed/simple;
	bh=48pnpLrsNRRFw/BuDP4IQLUokASxIvtg9aK2A4dG4uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFk2AwdUhvRzc7q9jhAO3hkk3sueLBGcx9k+QIsvQJVbviNoJyqyAcZmzarVVNj8ao+jGSwQCTjexYSkfseYSDD5miVj7HEmAdViyFA+26PC87SL9YkEktBwCWgvzi/pkprp6IAEnDEQ9RXNWjXYJjHPhnQkVBYWVXC4yOKbCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZ30wt5b; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ30wt5b"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d7111700so1423908a12.1
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954297; x=1791559097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZO64Fd7np0oAanh2aG6LBLWQXHVyyFIOZxkTvF0HyE=;
        b=EZ30wt5bO+s3XYB3QHtBaphLY6SvJu2sZc5zUQKdyAr+ACgHRxyO/h2kSa/iqKjkjN
         sxobQRIYtj78Iwrxxv3C00/5Yc2Can/DMhaqhgQgRnCn4yga3c9Hn/K8+CYIAqCxeety
         X/9YBh4GPFm3MQDSKWWZI99EXCpDPcuUVcJ8Vyoyrxb/wkc2rfHzG5K8OD1T7CxKZrVI
         RvR6TTnSJtaDESd5Zr32Np6xszcMDLPPTBhrkt27Jboim+YxhesLRA1RNHHqZWGrxTfr
         76l1Tlo+txkNPrwU5IILEJDLMuOowytrFdf9kAGUsPIjcUKaWVs48KcOgzpJOpW+DwGO
         UWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954297; x=1791559097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rZO64Fd7np0oAanh2aG6LBLWQXHVyyFIOZxkTvF0HyE=;
        b=2dO5xwBcd7nU+1HOGhjNKt1C590/fzOeMvYEAx1EXROjJVo7650bxvwlKQ+QRdiHyG
         g3ebEm937YXopFUr77JVIfRF1s7SrRAuUl51EFj7MNKetpSUqP8Aqx/L5iuuVGxH1Gep
         KahtRu7Rh/q5o6wAmr/ek4TvTD3cR+RBjevNLQN6Q4REe0bQYAD6cKHT6Ek4DRm9QelS
         wyn3y4qtFCp0eG8mvgeulyd0ehB6tnuEu9D5jDb+3+1vk0IXJWUL0DSHW5qsDJO6Xw/a
         opDzMjaSoxvB5S9CeNiyW5M9Lmohos9RG9BatBStE7klbxN+AdvGBOFlgwnypwMojV4W
         03Hw==
X-Gm-Message-State: AFq9FYLilp++PEfcIxq1DWqyedqivUEl2qr8Yj/7MmnyIDHagrl8JKR5
	3m9dZWp2ROTAkKyPrLKF8cEdk8XA/QWv7a0M+Am1wAuK0sUMUAlG3dbe
X-Gm-Gg: AYBFou0gdNYefhYJvlnSsqRcQ2nuAWsn7APGulppAPjvzIwZef1BWM/oC47K9SCLJq5
	a0LYdZXej5rjeD1ZKvixhMSUfu4VUjWNRhw60QrN+gWgXl7edx2Y0MgetJQjkpnP7Rgc0lcTBjW
	5tARuVJZqlCsSWc99qaOHD2INziWuaLURrdVzxZsvBBaefi1k82dV3glXBMqZWWqm93zzXABAUm
	9F/0yIJvVX4zk5zJKT1AP+4wWHUvXoHPi8Bwk2PrJjkjdh5Z+7gmpglVoBb2nw01n5+h5iwpyrm
	bEViQ/fM8BFtGoBvTrL5JbgFbclNadCk0VlW1qc8WP34IJP2+oRh+SDc6viaLe4BwPSE0Pi9puV
	gaEHYoj95j6RQ4nJc5kfYjx1X9uFoaZpVr5fKY1GmjO84uUKqgh4HSBjlvIU60a2WnujbkZEz24
	1hNLDlWYDUxMikNKCMjADwweZrJdXwKdAbxg6HWkyv8EWCBtCQ3OoICtIXWVbegRCbhEIA/y2DI
	gMy/cAFp4s9HflfOA==
X-Received: by 2002:a17:90a:d60e:b0:3a7:a34:6f98 with SMTP id 98e67ed59e1d1-3a70a347737mr571685a91.54.1790954296137;
        Fri, 02 Oct 2026 08:18:16 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f73551f2sm1166635a12.7.2026.10.02.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:18:15 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: arnd@arndb.de,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2 2/2] timers/nohz: Mark got_idle_tick accesses as same-CPU races
Date: Fri,  2 Oct 2026 23:17:56 +0800
Message-ID: <20261002151757.3605081-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002151757.3605081-1-kunwu.chan@gmail.com>
References: <20261002151757.3605081-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

got_idle_tick is a per-CPU flag set by the tick interrupt handler in
tick_sched_do_timer() and read and cleared by the idle path in
tick_nohz_idle_got_tick().  The flag is intentionally accessed without
ordering or locking; a concurrent set can be overwritten by the clear.

Use WRITE_ONCE_THIS_CPU() and READ_ONCE_THIS_CPU() to identify these
as intentional races between execution contexts on the same CPU,
rather than accesses that may race across CPUs.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/time/tick-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a7893a079a83..eb6065c8a90d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -269,7 +269,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	}
 
 	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
-		ts->got_idle_tick = 1;
+		WRITE_ONCE_THIS_CPU(ts->got_idle_tick, 1);
 }
 
 static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
@@ -1246,8 +1246,8 @@ bool tick_nohz_idle_got_tick(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->got_idle_tick) {
-		ts->got_idle_tick = 0;
+	if (READ_ONCE_THIS_CPU(ts->got_idle_tick)) {
+		WRITE_ONCE_THIS_CPU(ts->got_idle_tick, 0);
 		return true;
 	}
 	return false;
-- 
2.43.0

