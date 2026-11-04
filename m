Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811367;
	b=4lbVQPCgklvrrBkGmn6xc40LSxXp5T7N6fR0RfXbG59bJFIIeSzDWITkKRHnRCUsFkAz
	 jKLtSp22NsVa/m/+FIp5fw7ntRgIwobF3FAJ8ao9CrwR90w19FTj6o4EnyM9qWH23nKIz
	 auLgAMiNaTJf9tGnB742tOmJtfSdDXP85fyCDobfzdDPrPNBtLUndGaG23drlCjPNkmw4
	 K6d23vDfYUpyxwL6XMkTCaUO2UvJ4Y9ycRaf4Txn8YXkvZdFcGl5Ek0f1ebz/9uNg5hnw
	 8VLgSLUclA5+nxIQPpfCDy+F4YseEpFktINr2mKb3XFQmkyUjrD1jnfMCZKFUOy29Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K4ahvqtjxwDZW1z/zIOwgCxGi6bAPzcPods0jeXHn0Q=;
	b=yzOO3LJ+lsWGSfhhHA+FIfqo48k4w1CPycBNI4QPxgYAenqZtzYZuIOCTUyVTJyCzEiL
	 Y5S7KU8UsfNdQcy0UdvUjE7LNedr0APTk9xq/la7jSGGYqUgYW0YmxOw/MpsfShoxCrxw
	 brHOsvnSy2LRNNlZBK2nZGGlp8colxzwXIb9RFPE3s24I1901v4JpzTZffivLgsMmtq70
	 QPqqMnPxeQwlceXuEMupca9HALtNmYa4MOoYxzFKy8rrJKZU6Gvs3lqAsC9+N8hvSr/Ty
	 97VLQKe1aDeb9y3iqmZfGOOD78xwNzyxqTjinVGkfVRZemYvqvxu6gPW4lDpDSD5u9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGUkONor;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D76606A338
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73D76606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGUkONor
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35b2c599f43so1895010eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811366; x=1794416166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4ahvqtjxwDZW1z/zIOwgCxGi6bAPzcPods0jeXHn0Q=;
        b=UGUkONorfwM+zbVj6eSQLZ/CtHpB5o6WUk5r6DRCTGw9BsZ3jYHEXXgAeUMXpdkKHw
         rOZh0cr3KpIP5HIpA47NNa2SvdgBzVZO9ouBTKR1uZ7I/v8x7qERHplfE42RZ9WkV9rA
         WhTMYE7yMWjkIdRnqeFALhk6GGbkABiCkQLU/LhORN/exgEintJBo2+52BvPekR5iiCg
         JaiaFNJVcOrSF5SWDQcIfnWQzeik44hR0n1dwFRYF1zMjcPvRGBJLcLTj5Qezw261wSm
         VRmyrgJiAM2eYvZ3x5IdrrkO1UP6/IpCBNjSbQFnbFoLKEC4WWZ2HEP12RSgYhlCsYXq
         akpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811366; x=1794416166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K4ahvqtjxwDZW1z/zIOwgCxGi6bAPzcPods0jeXHn0Q=;
        b=cpN2QaA6bfuLjBbQYUvwlm2WaX3xQW3wYkvBZGk98wyjLQehgx3NAdzvIQvBG+LBce
         b/4xuS1SCGXdCJqH3ECMKrFcWBxvRdGp1VGt4BdPTv5lzQsv87WEN3mEA7Mp//DKlUr6
         Zx/wr7tOSsuDXEg+1m9YHp2FLWPBgaTz5vKVwjVid4fohvkeHYyjMcNcz854trieUo0N
         qZswnaxiGFXxPWst4oc5yYjYvPfe9OAP4v/1Y7tVENlwxoR3fsaAwst4HbXJelrs/CDi
         ph94YZMpuc5psE6WEsoJkRW97ZFhDPWSnQEnxigvXCXrEsEYNfdAgtqkEOQ1wtl/NvXL
         L5Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzzLnX1XjyIxhL6uYzKquWgfX2Aw33pzheUU5ctoPYp91MMSVHAFVxLQE8tDrX2iYn3SDKepXRs+0jh@vger.kernel.org
X-Gm-Message-State: APuU4Z8hEzfex3LShngvxs/0FpDOC3TLUbJaf+We38s/HIl6wSpGHH83
	vpx3WrSODT1FnMx9gK16rkMRalcgsNDjdkBcYBTmPRAi/VSrLUtU7tSW
X-Gm-Gg: AYBFou0zInXMhnjMkTqiLQeeC9dwo9i6N9s/f3N6MIrt7YfJ69o+i6OfpD5QGvMOVFH
	wDpS1++3JcYIsvPZjkRfs6qoVH3yX25a9kJ7sB2tM8+iFLRL2ifR0PvbUTHGadAhH3NCy3b+ven
	b7/36HxNaJYPsAmp5SXovHhRDqyi1Akeqe6THnWDjo1hHwSTrDwU4wtRhaen3aWrV4YCgRjw1jk
	QVgsK1BBfLTT5pXJCPTTJ2V6PPmL61WEVFRV5d5A9iNc7wsRrmejVoYJSYneYFD4yg2SUQW2RCI
	qXJypguctbDXZdSoHeglwzWzUTLTWUW7QpzbLRpDJ6zvDiZ07VHmDhTMwqgw3dzw7keKBlAfhSm
	/CguqP1d79N9YAJsGwvODcj5NG482b7OFFnfd2A2f9iA6ytKOv4KmjFvmpX9lm6e29BcFzeMXQs
	vXlROdV6ewD5WQ7RLPspOBZa2dql7gL1i3BsVb+qRxFWRWJ3rosYehuKBJ0iH6IZlchTOhh956n
	PU3GolHD03QeRpvlPGTucDGsQvfZtqRWPj6HrMRhXR32UJ4SsZXfsWFSpibIoQwl4kAkngsQqJp
	OVYYLW3KYje4yf27NGDAvHPvpaWNhqhzIRP3UXM=
X-Received: by 2002:a05:693c:895c:10b0:369:f05d:6c5c with SMTP id 5a478bee46e88-36a4240f66emr26391236eec.28.1793811366010;
        Wed, 04 Nov 2026 08:56:06 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:05 -0800 (PST)
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
Subject: [PATCH 05/28] Documentation/litmus-tests: Add hazptr wildcard-flip escape test
Date: Thu,  5 Nov 2026 00:54:23 +0800
Message-ID: <20261104165504.2430480-6-kunwu.chan@gmail.com>
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

Add a three-process litmus test for the in-flight wildcard window
of the single-pass scan: a straggling acquire which published the
old wildcard after the final walk cannot still load the
unpublished object.

Verified with herd7 (linux-kernel.cfg): Never 0 13.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 .../hazptr/hazptr-wildcard-flip-escape.litmus | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus

diff --git a/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus b/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
new file mode 100644
index 000000000000..de467bb82d20
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
@@ -0,0 +1,46 @@
+C hazptr-wildcard-flip-escape
+
+(*
+ * Result: Never
+ *
+ * Check that a straggling acquire which published the old
+ * wildcard after the final walk cannot still load the
+ * unpublished object.
+ *)
+
+{
+	int ptr = 3;
+	int hp = 0;
+	int wildcard = 1;
+	int enq = 0;
+}
+
+P0(int *ptr, int *enq)
+{
+	WRITE_ONCE(*ptr, 0);
+	smp_mb();
+	smp_store_release(enq, 1);
+}
+
+P1(int *enq, int *wildcard, int *hp)
+{
+	int r1;
+	int r2;
+
+	r1 = smp_load_acquire(enq);
+	WRITE_ONCE(*wildcard, 2);
+	r2 = READ_ONCE(*hp);
+}
+
+P2(int *wildcard, int *hp, int *ptr)
+{
+	int r0;
+	int r3;
+
+	r0 = READ_ONCE(*wildcard);
+	WRITE_ONCE(*hp, r0);
+	smp_mb();
+	r3 = READ_ONCE(*ptr);
+}
+
+exists (1:r1=1 /\ 1:r2=0 /\ 2:r3=3)
-- 
2.43.0

