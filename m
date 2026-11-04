Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811478;
	b=wTDWDgNuNKhuyBpSgtP91frzGuA6bDFQwfkvGNpxOUWzWN/ADohSRATbZNRVjTgaBx0t
	 H24DrWMfquOuWPQcV1SdteO/l5JV/oiK2W2JDRbmtI+7AwJJ7W56+Qp+OIre/FMHzthj0
	 SWd+2LzxvwgEs2nv7hT9b1CQmawiF7I3KfHSIJ6xJedPmkFHyxTjHTis2WxNARuuTY/rI
	 r1uYixsV333DPG6H6B7Av0UD6XL9JP0holk9zZFgRXJB1YeRpFaDyCOK8NKwoBEwDyjiD
	 qIXYA0hsftJNI1Rdt9nFjBOPRjceinRrgQFX0qc7xQxsbnuBBeOEQFUv03uzWtI8fGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vZX2J2F6ScsUN9tYZ3R0cEhAjGjvMCPd+3MYzWgyxI0=;
	b=ALzWSldC78QXg8b3RlIEvuj5E4G6b2Os3Cu6DCPIqE5uztVZ0BXXWt+WpFcuvo9sacOe
	 QP/YiNAMm1uofZW6zJXYwVePfXzeu+8dMRZfc1Pw4VYHkNOzlM6T3dlkuoojuVp1YQJSP
	 ZU3yhYeUlR+hUV0qWA26wWgH+hzeD2pZoVCDaJDF+h0hybp6Y9ES4PSb7EnQ2OPSexjeo
	 ktyaelhoPB+p2gGl4Xk5isNUNljNEs4iGhUNndkVrZr278fAhLZYdFtXJkjR75RWvoqzP
	 QzOJQGgal9eGNQzXNaz86oxObfLsg+kKZy87x9XPoq8KBEUHKv850AjxKqwP12yLqlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lpDOW6AD;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE851606A31B
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE851606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lpDOW6AD
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so1343754eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811477; x=1794416277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZX2J2F6ScsUN9tYZ3R0cEhAjGjvMCPd+3MYzWgyxI0=;
        b=lpDOW6ADYu851lyuivuLo7QwlZhzKTNs3PLF10Rp8myOxE5BpOBWhjm7Q4MqLXHeCx
         J52PFqv0AaxfoECHtzUpZMoovnjGHZgtZkxUez8M9SYQzp1jWB3MSam8LxY2TDtwtYM4
         i3YsZK1YrUlfkTefb9OYyeuUQ2dajq19tol+OtKNoLQ+MTKFu1lkw68gpHISoAjLNrX5
         GeRbxOyi04N5JeHjXQ+yP+UlpAEd/NKnQVYCH+cBYLKUSrSb3q/aJt4+3rxkSRyjQBnC
         YQ/20uVwMzwVNPsexHWcF+BUwyqNK40THR9TTrc2B1//qZ3wuMYu1M/+MQKh2WT/05Xl
         Q+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811477; x=1794416277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vZX2J2F6ScsUN9tYZ3R0cEhAjGjvMCPd+3MYzWgyxI0=;
        b=ZZyaI+kU6+RaI3kMU2juX6D4DWSJNToSg5SPETq/EKzC/VmDrbAPwo0NkFXkENwYRm
         8HAS5NzKrbM5bDzPgunQGaDGejqTQJMS1akE4Wtg+unQYvEYK6es7vHrSAzTrFbZD+0q
         ySb0CYe/x9jJEkmA8xRXVMkmyMOiSlgKWVaeKwzkH0FHfDmmBidiZeEvWNvNmcFXLqDB
         BfFBGX8+V++TsvqmFlZctSCu5snGWDT3SH0r2U65OVFT5Mk/1pE+Oevk1cxYJyzJWxnB
         fLDGwQRpHRjPFwIOUeHj8s+vJRFwYln2M68XAumDQIUS39odVSmco2THK/0J/WB4/zJw
         yRbw==
X-Forwarded-Encrypted: i=1; AKwUvBxG/hdYy38g3Byy+uRGH/aGtMTR87t4cFW736Vv5MNae30KKD3pTwienn135Z54nNpkqQ/w0WqnjhMn@vger.kernel.org
X-Gm-Message-State: APuU4Z+HO8hI/Ud6H07jipmwAqshT5Fn5FML9pP/rTGCyFb6b4PntGUn
	uWK6a5YMqgdaArJHR597B50lDeTUbWcgD5CKPuABqIkx5b2GXRZ+0tjt
X-Gm-Gg: AYBFou1lTMws44STNlBuU36txCalTEz611hyEhg5G4/mAMnsYPioDFYRn4L8wm2Pzty
	YO4KPaJHLsELvSyvUV+JlocVztIF3KkvIskv3hyC8FjLHQIeEa3WJaej7Oxmagj7PLZuumbRZiT
	Bve46sZOaDU3QWCsr2mKvbxCdwcAp4XytGhPxJDFtxB/ig6l93Hu/WyLOyyo961AYMrdWolv6wH
	gT+eBqq04LBFhoAlosj11/qsPqb/Jv8puqd5+aBq9at7lQUhRASpXwZzCxrw7uWV0QK8V24py76
	8lU3aonv57TKTX2ne62Tdad/M5J+6sjx0+k2AbjqCSbAttswE2wYW3CY8uzqFrWcMfg/CN6Rnur
	Rj4WeAIM2xzoI0urYgqvKF1n/kzSu2GkYnfcVoImASoBkbds4zz4IhVspIRgr6giDmP/FROkCOY
	Xzmi98uvXJF08MLxGagT2tqirY2yIqp9J1IrtisWhyzKsyg1GHBDmz8eY+2mokj3Qt6MIm3DZqy
	+xxy2LuiW1iCMl63DnTrL7SrPxnJxZ+Wn9faYUiqWQiKJZhqaERXwVRvQBn9UCx6RgiQAW1ibt/
	p3S7hutyJE0rsz7OV+T3sLzTso7Mo4/QD8Nvf+Qnj9TxBVEisjSZJPuFT8Qc
X-Received: by 2002:a05:693c:42d3:b0:36a:1452:8dad with SMTP id 5a478bee46e88-36a4244dbfcmr24088619eec.20.1793811476479;
        Wed, 04 Nov 2026 08:57:56 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:55 -0800 (PST)
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
Subject: [PATCH 17/28] Documentation/litmus-tests: Add hazptr drain resnapshot-slot-race test
Date: Thu,  5 Nov 2026 00:54:35 +0800
Message-ID: <20261104165504.2430480-18-kunwu.chan@gmail.com>
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

Model the marker consumption race between the resnapshot
recovery path and a reader release: only one path may consume
the drain_gen marker (the cmpxchg in the implementation).  The
Sometimes result confirms the race window exists
(herd7: Sometimes).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  4 +++
 .../hazptr-drain-resnapshot-slot-race.litmus  | 36 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index daab126e45a2..02c26d6bea50 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -115,3 +115,7 @@ hazptr-drain-engage-wildcard.litmus
     Test the drain engage's wildcard defer: an engage that reads a
     slot holding a wildcard (an in-flight slow-path acquire) must
     not complete for the target address.
+
+hazptr-drain-resnapshot-slot-race.litmus
+    Test the marker consumption race between the resnapshot recovery
+    path and a reader release: only one path may consume the marker.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus
new file mode 100644
index 000000000000..699cbf0e3d7a
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-resnapshot-slot-race.litmus
@@ -0,0 +1,36 @@
+C hazptr-drain-resnapshot-slot-race
+
+(*
+ * Result: Sometimes
+ *
+ * Models the marker consumption race between the resnapshot
+ * recovery path (P0) and a reader release (P1).  The shared
+ * slot_gen represents drain_gen; only one path may consume
+ * the marker (cmpxchg in the implementation).
+ *
+ * The Sometimes result confirms the race window exists; the
+ * cmpxchg ensures only one of the release hook, resnapshot,
+ * or unchain path decrements backup_outstanding.
+ *)
+
+{
+	slot_addr = 3;
+	slot_gen = 1;
+}
+
+P0(int *slot_addr, int *slot_gen)
+{
+	int r0;
+
+	r0 = READ_ONCE(*slot_addr);
+	if (r0 != 3)
+		WRITE_ONCE(*slot_gen, 0);
+}
+
+P1(int *slot_addr, int *slot_gen)
+{
+	WRITE_ONCE(*slot_addr, 0);
+	smp_store_release(slot_gen, 0);
+}
+
+exists (0:r0=3 /\ slot_gen=0)
-- 
2.43.0

