Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C45331ECB
	for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791340166; cv=none; b=GE53zRTb3leUBjqJacDeQmCccCq9+ipsx6urCN259wUVi+Aq0SZrxKR0wcAKSMTTELCyerlIQYYx+tSgsahCVwkTBRZzylQo1LmwD812eOhPfn3DEQq3QgutT2sj8GxP4A8bJMHhrQwIHww7zEXbJs5ggDTVYlLLfSzGGALTSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791340166; c=relaxed/simple;
	bh=9T6d1BZ8/LWdQTJFhtX7GkFtSnfVgUks/xtRX7qiAOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAfnHTPfv9Y8WFVwpYMtRKn97yVu7uNMODn1lEjaF8kBobR39qZyVqrp6FDaCQncKCnHMRB/2vbzQpCiFIyzZsSAdqxZ3BqFJLKf3byCLX6nhIOCn5Pt8RvH/Yimf8Bbkz+mxTrnCqZAZpr6xXUK5qUbJZD4cVJXIQ6pQOHPq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTYYgQo5; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTYYgQo5"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso580427a12.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2026 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791340163; x=1791944963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxeJdMFoW0J78hQBPAdY2BYch+3WAegpP1Gcc/5JA+k=;
        b=CTYYgQo5Ka0RLAdsbHsAwyd10k7YxJcd5F52KrF4lv/1Zf0w6Wf0HbDE7jExZgbWXG
         6BPCDavIpCYCxq0veX4vTFJV6/nq1x/vbI/NItAnMe04jlC9BkKumfVp6PI2jQcz7nRd
         CKRq8OH4fWB/YvnWV2jWvev0OyZ5rfh70ibJEv48EQUF4BsrH4u8Ifioi/kSUg6A4Na7
         k/L9ojCdNIosrZ9KQnU95RU1Hozs5Ztcfe5C/xX3PnTEiihTgzxQtsrrz/CEwshMXfXo
         t5JHNbnk74JPaYx+xMra3GfgnF79ujTpbWQqh2O9ARAcp2aFlgtjr9O+0bPIXqHkvY3/
         rPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791340163; x=1791944963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dxeJdMFoW0J78hQBPAdY2BYch+3WAegpP1Gcc/5JA+k=;
        b=nwNRZLvYWDofMz54BkZKY1wpkM4C25a3qJ7IAk8wrgTpzPlCPGF8CFSl6eh0kXpWBN
         V+W4eGiWv6vXtxgvXDTZsyRhBUfySz7HlB0DJCwiyB6ro6EGEXbDoAzrex4Pg3zEOQZn
         ULmyzS8t9DITHrbvCYKeKOGGii/n2MgtEOfS9+JQ9yGqgVyTmTK7TITsXlbenZj6uXWr
         kyaxLFDMF3dehDX9VvDkVIYr5kF4zcGuj6Ar0om1iHMTDBLeN4h+2f1aUEGw6yxjwLjo
         3166kOHCQFi/TLdShHLs52YoiQ0/5bl8e3Eylxd8N0fy1ZMiMQxeS1XcBZYnqvYdjAJV
         rZhg==
X-Gm-Message-State: AFq9FYK1Li9JpWwh4dh5D/gB1EcERNc20SB3aQmDmhL960ZWljJJgil2
	PkjkuNiGRrV4DziODbGSV3T74h0joQfHyahOqKvWvyQrs/FnUQR085uO
X-Gm-Gg: AYBFou2sRZPBg2n5AvnvLTnq7jpcsdsF6UzYmLR4tOygPc2q/ZmrzKCQ4n0thL0+QpQ
	PeBrKsdpzz/YGd2+tcyMr7/WFTNAHXhcCs6exg0h5uIDIcWasODE0a0vuDI1R1rO8rPaytynJ89
	PsictOOZrr8k606j8AowzNffnjQbCbM2aPM+vgfKfM5mRq2Ly+cydSEUNz+xceK88eqoq+/sf+b
	mme0SxT2rCT+HNmCevQ19dg/MOEpWq7Ut7b1W0IgriKfnJ8ilOpkal3WvfAMGAx8oT3SSmx4+Gp
	QMwbqoodm1DYwOdgQMOR7W2FlXm54hawe/dA3baof996KnaF90bOonpyYlW6rxOrvHb4/yT6bLI
	OFXD8k5lPHDWW+ejcRV0LLIXYrqBlh5i5kyVWyIHKe5Qs4R5EBp/w/iV13i3jvS+vsEV/y6Yvhd
	scpeyXYYwXr5jEbqG76wY+JaS0T7WJJiCyBGLx/PAPrdYPYyjlwdZbN67u3uh30QD5fa3y6MCU4
	buxi92Bd8AC9SnQNAGPGfGGyHATSA==
X-Received: by 2002:a17:90b:4a02:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3a8a12c36efmr870489a91.50.1791340162941;
        Tue, 06 Oct 2026 19:29:22 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89b5c5d9asm2090836a91.11.2026.10.06.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 19:29:22 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: arnd@arndb.de,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v3 2/2] timers/nohz: Mark got_idle_tick accesses as same-CPU races
Date: Wed,  7 Oct 2026 10:28:59 +0800
Message-ID: <20261007022859.60101-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007022859.60101-1-kunwu.chan@gmail.com>
References: <20261007022859.60101-1-kunwu.chan@gmail.com>
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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/time/tick-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6c3fea386..a136bb247 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -269,7 +269,7 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	}
 
 	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
-		ts->got_idle_tick = 1;
+		WRITE_ONCE_THIS_CPU(ts->got_idle_tick, 1);
 }
 
 static void tick_sched_handle(struct tick_sched *ts, struct pt_regs *regs)
@@ -1248,8 +1248,8 @@ bool tick_nohz_idle_got_tick(void)
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

