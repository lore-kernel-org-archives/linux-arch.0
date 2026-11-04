Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811487;
	b=K956yW57OSjqSnXLGqhtHZILmDOGRhryH0sSq0wADVLwgYmwHUlyWdc+cgzjAaJ5cpO1
	 eVAUHy1tpWsUgnT7I9fONISnSI5ypWxgoDeqLjPsDRzU0wWw8/fNMLI55JCasfF19l7p+
	 aBiDNw1YuozQoHuGmphjinnztNFqysrZzQGXx9Abihx3m/aZVMcpy5tB/K3DtocX6W+oD
	 EcRNIXEQnhXDbUFuA/gzbjNl0kSoZCW0JDWMVUnpaG8XX2JtYaVHgqc/ZPUlQNJLgFmf9
	 NfXOPtCSFqmEwv5SY7z8PHBDwcfws0h+sp98CAgR05JwEaQJ020+tUL+H7tb/gkZdzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MX5bYyRBv2xWDRuJgCQ6Y/+Akj3zDi4J3TbhhKtB2VQ=;
	b=iuSRIZuOBw3aXH+W6tyyzParIlP2YM7mluvb7+Xeqip4hDC3sjzKtxws1QxjBdtKfFpo
	 F1kWcGFMQAYR5gQi+e0uzf4WvMeGx1wXfH0t7qTVhhh/OH7t3XrYL/EcX3PLDalqMlPBq
	 Pt8s3q7h0evdgI1amDyhrCBJyTL7Zeg60jHKdGG11fc85teZvB4/qogGKnMiTlqw0kbrQ
	 Ih2dChdITS52qEiGIvGRDzepibZqyh9pYj72Dry+G47Pu5qYysk1AbB6sA95BrwW3gU+C
	 3PAHkVX1s8jGaPg5u4RaRym+tQyUkgsDjDpvZLzPNP4pp0tXQf+hPFdbBDKYn+P2leg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lotFQVZd;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59672606A32F
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59672606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lotFQVZd
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36a315ed211so920996eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811486; x=1794416286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MX5bYyRBv2xWDRuJgCQ6Y/+Akj3zDi4J3TbhhKtB2VQ=;
        b=lotFQVZdNFhgVBDY7gna/kQwMt63LK8lZz7tMqJUIb8zH+l9m73GQU6xHgD8P4ZvZr
         1OS5T920Lqtt5GrJdQI/O7A/6fmemqaErhCNIlByN/wbXf/1XFlPVuCPkBuVcHrspK7l
         h3axa2N4YUH/YCY5LW1xycCedkvGXaq+AfvA7G+sdphoY7zT9z147BkTQr5zcfQaGlLK
         txraV1kFET4Rk4EEZPaTRDD/LKciGdu0jFc1pqCztMxzKSExFygfUyHNWNADpSIHVKQA
         jg1Ytx+JWO03LhIPjRtRyt+v8z5i1u4FBwFF4KovX6GB812JLN5y62qTJhVW97+uhY6Y
         YAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811486; x=1794416286;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MX5bYyRBv2xWDRuJgCQ6Y/+Akj3zDi4J3TbhhKtB2VQ=;
        b=Zr2IZh1kC50yiqEifwA3TFdU/7ukkSlZ55epR1HfB9bp20JKOZWutn1aHvxTKpT9M0
         +UeehysYrTOj1gW/E2TH6LEd1nSGEzkqvD88qRVLs5J4gKthv/BJcd6oN2ey2cLsMhIi
         rNAP1dP0to7MCg+4zP+C/oeer+u4xaBixzS2MfWd0tfNjg/5jUR2EOK5ZblVcawNN7ys
         Pvkz2vqCGZKK5yxkb6NVRuRGjJG1csskrDNeTrDQGdNz/kvFzRGfJtC49iKHS2iZwtvA
         vYr5sQA0c/oJ9C0bVOOCxtBEu1nCs3728Vo2cYDpxP6i25FD+24vJPPyru0SjYqNKPMX
         fX4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwB9ygLQDYtfZBMZCwWAQbbXyafxnpTFwh1jvTPmA1Z/ycwLRktTC1wlVkrAK79FbMCuMmiSfsxmTIv@vger.kernel.org
X-Gm-Message-State: APuU4Z/YHcR2x+mfWjVGZ0p6jW2TXD8zxc2KEIi5FfACq7sACFjJexpA
	t9EcIDxEaUPGh4RGO4mp07+8c4pOWNDOChqi5tVioUWj58KdVG+lTtlb
X-Gm-Gg: AYBFou03vaG+q5p/IyXWd9MNAhzNlJU2t7kU80KV6F+NCdmggSNO7Um9/VmszcUGkZZ
	TAKPkB2U02Cb23oORjvfwXUU5rltd+5QEJd0Bxjp5rTTlkRXC1TD6OlsbDOG49zwmRMDZx55AqJ
	H+2NhNJoR7ZE+AGIsxDyTcIXDnW8uFQmKmwjQyp3VOIwZwP+IPwaXpQUA2PpI5bD00ANK6i3t60
	y6Qq3RX8cpGvB9tIktvOb7bhC4OjrVk3TCLz1394Y6q7ilOYruFG78e7X1abJBlw9f1LX8ewcv5
	LmckmtTSV/m+AwhXAJYNa3LMTjvJYFVH1EMBeuoBxXg3Y7n/CDxRxNHwsGsxYbgVNi1rnRZOtel
	oaZH2Fs8hsDeevabu93nUji/MO4F5lCVwrEhoqtlYSAdFmv7p0OIjQ5sX0Ap7Y1t+s/izQVCsfS
	TrrCeBL5ZeYKKRfTCFKMorWOCGN0BPtWw7ajMjVPnyC+8MJYrVdMKZwYzSfjoK/nlgqQIYT2uu9
	UgpD4Xem7hR+0iD9/hPiEcjjbu9gdN7Eroc6UCAaop5FgC6ek/I1Np2RRBzn+mU6gOoC76cnDyA
	0ut394U8dQVDXrtcXwhBZtHppduJkVKOoQ6Wf1LL74mCVYSxaBA2GWlgHyDd
X-Received: by 2002:a05:7300:f78c:b0:35e:af84:bf1e with SMTP id 5a478bee46e88-36de479614fmr127613eec.7.1793811485795;
        Wed, 04 Nov 2026 08:58:05 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:05 -0800 (PST)
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
Subject: [PATCH 18/28] Documentation/litmus-tests: Add hazptr drain safety test
Date: Thu,  5 Nov 2026 00:54:36 +0800
Message-ID: <20261104165504.2430480-19-kunwu.chan@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Model the drain engage snapshot race: the engage may read a
slot as empty or wildcard while an in-flight slow-path acquire
still sees the pre-unpublish head.  The Sometimes result
confirms the window exists; the engage's wildcard check (see
the engage-wildcard test) closes the gap by deferring
(herd7: Sometimes).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  4 ++
 .../hazptr/hazptr-drain-safety.litmus         | 43 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 02c26d6bea50..604c2c0025d9 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -119,3 +119,7 @@ hazptr-drain-engage-wildcard.litmus
 hazptr-drain-resnapshot-slot-race.litmus
     Test the marker consumption race between the resnapshot recovery
     path and a reader release: only one path may consume the marker.
+
+hazptr-drain-safety.litmus
+    Test the engage snapshot race: the engage can miss an in-flight
+    slow-path acquire, so completion must defer on wildcards.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus
new file mode 100644
index 000000000000..a0ec1a063642
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-safety.litmus
@@ -0,0 +1,43 @@
+C hazptr-drain-safety
+
+(*
+ * Result: Sometimes
+ *
+ * Models the drain engage snapshot race: the engage (P0)
+ * unpublishes the object (head=0) and reads the slot, while
+ * a slow-path reader (P1) publishes a wildcard (1), then
+ * replaces it with the target address (2).
+ *
+ * The engage may read 0 (empty), 1 (wildcard), or 2 (target).
+ * Reading 0 or 1 while the reader sees head=1 means the
+ * snapshot missed an in-flight acquire — the Sometimes result
+ * confirms this window exists.  The engage's wildcard check
+ * (hazptr-drain-engage-wildcard) closes the gap by deferring
+ * when it reads the wildcard value.
+ *)
+
+{
+	head = 1;
+	slot = 0;
+}
+
+P0(int *head, int *slot)
+{
+	int r0;
+
+	WRITE_ONCE(*head, 0);
+	smp_mb();
+	r0 = READ_ONCE(*slot);
+}
+
+P1(int *slot, int *head)
+{
+	int r1;
+
+	WRITE_ONCE(*slot, 1);
+	smp_mb();
+	WRITE_ONCE(*slot, 2);
+	r1 = READ_ONCE(*head);
+}
+
+exists ((0:r0=0 \/ 0:r0=1) /\ 1:r1=1)
-- 
2.43.0

