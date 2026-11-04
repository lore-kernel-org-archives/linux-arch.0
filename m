Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811468;
	b=eDdELJUuBtVIP8tMLk2YY7iSVFOz8cOU36cF8iv83cL87rtX/Lrhf4WxDd+8ngaVm6CM
	 H2wuDkyLTa1YPJNlItqUPOdTrl7pCVFH7q8V+Y9QHhh9lxG5iwJzfx+0nYCtpWXak8gEP
	 TDgOLD6fcdbMeyzmYCRAPKskGgaPVtdc72rokU+W8yNgNADj9xL0lzEYgDrDfqeAMYfrV
	 WjQ670XyVvwc4kolk2nB+///1PPilGwbEWtTsNWPpnq+Q7nVUaiNXf1O35TXriSuzLtf3
	 sR0vctNojDA40QwvvFi/eo0yWqfjI6G56Jxzces0FPaCazvBgoVGqUVLp74bbA0l+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HYFy8sOOELLyqP//oMKFGSpOITyv86S+D257oV2UNCY=;
	b=sN7B0ELDMo7J/Zat6FgSukVQXQDMM2Nc6rGqijMMqCR3s8x1Uc4Db+KpOh0KCP/4st+6
	 z4nsr0wsjZJFhwTpHDHBBP2hWioxN84eUAcSZXbwlKy9xt0520R93+DW9T+WnsQLe68YQ
	 ZuMY1A9ywOEAR/xHM2HkSFXGnrILp33eZ18PL43YGQBf2IJrpkpwqN6JRjLdusyc6DeX6
	 PlKkpPIESR4aQeb+ptDFQ1G2kHOCrq9VLA2Y8VaB7jfBs4WME7wARf8z+lbPSjjS6/2Yh
	 /GDEtHEnWxQfmEaVRYfPtqYbbwINq2LAUQkOM6ajtFYJ1vI2PGN1ouziQN0UitZsfXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+yZfRyu;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D416606D81D
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D416606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+yZfRyu
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36661f953e4so1259124eec.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811468; x=1794416268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYFy8sOOELLyqP//oMKFGSpOITyv86S+D257oV2UNCY=;
        b=H+yZfRyu1YpjAqnbnHiKh5xNTmCDYDOnNqBVbKlooMK+sxvVJEQXqGJdt2ppEr1oHx
         t435KiYlxJLi6R2A+7xJQKVHU0bpd0p4PwvDNarn62o3341CZREK7JiPVkwmMKTVkZNz
         BPuL/XdarsAwqfDbJv8Ra0M5t2G1eDT8Op+OY5grEIwd/imbjAuY5jPGa59Euw6GYLM9
         GX5rT/byFl19eCTBAowU9TiUfPVTY8CrphI0yYByVAzBDZsS9lwj0htyPQuwfm1cCYSJ
         jFIBEzQv/l9itvS6ELOYrAx7w4GDmZWPFyGVpIPncbIFaiHeSVl0GE9j3rCjCkbMz4Zs
         sfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811468; x=1794416268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HYFy8sOOELLyqP//oMKFGSpOITyv86S+D257oV2UNCY=;
        b=eFP8I9nF0grF9su0OV6E3J/POnsCYurHkY4EM2oGSrXV7cEfnM28akLsIya+SwkWkO
         6dDRdCU4WYycBRTsXeNQPcDveo3d0+fZRIpAlIc4N0sB+3oQsU9oZLSGFqWi+qifTSbi
         g2A9mfM2WLFKNnkPqd6jVV7WYcaO0y+eA87m4IBkhVwHMIQGgz36IkSw7BElzNwkrxjT
         58n0vFl+HwiMYfYsEoKnFbyJncBOs8vNVVHF1GiJe638sOz8Ceq+pAgHH8lw9/J/0maP
         P8hSwZGF7DKEnatPXkZWwae20ewaXcawEf7ml5kBnzyAroaGSJ/quddFO0xFDQcWZsnS
         x+dg==
X-Forwarded-Encrypted: i=1; AKwUvByOR5DCsLOqUwNkyQKdOGmyipESBz1gVr8JsbsQkr8afhdwZGs25Vy+V5/+bM/8tegEDWjlCv1taZU7@vger.kernel.org
X-Gm-Message-State: APuU4Z/s0HCsE6TMExLeP1D1UiZM0VZCuSn+zn0LyZ4vgqD4DrBb33WD
	B4iqxeRUkTSK3Q+JQ3iWN5soTvpwCdFyvr0+KZqY5D3CAbtAZIeGID8/
X-Gm-Gg: AYBFou1gxKgvVGZUjtok+dDAUlT9kGEsFajDbgNALE9yN/kvNhaBtMIAYxSlwFjz/zr
	UCUHGJcLSp6yI92qSDL0DmW6aaFOYOR+YlNGp2yexuGZP9+03FIMslSgLjFMypVxGlCj8A9jOV4
	cwhebTAi7BU4Xjkx+B9AUs/7n/VT7/Cp9tBcJsutnx0+yGU8qZKteJiBPbnDXfNhq4xm/R1XkrV
	KDPaYFjfdSP7wKsXgU0zQCSxwF3qTLY2i2vYX13eqolFdDyfkXso7v8kRcyfkQ+kDl/ZB95S59x
	SuTmGZwFLmlIqgU13rQymVa38Y9PODZFYM1H9T1SSPaXC7PNs+g3t+OT/SNe+9suwjLwgKTVUVS
	3Js3sK9xS6dguk24omfa+gGoORIBL0g0Av6Fqcg10EsG5j1h4KP3KIHBKf5AC+1OkYidVxJkS2m
	91PFnwnxy9bvR0tbjNQq6wsnuJTyqMx3K0u3OXuBGWfN8X/R+yhl22Ux5XVCNK3B/N2B/XmVfBX
	j2hDMGFhK0Siq2NwY+jbuxyML+rZXgoBxFNHjRxA+Hncm2ytEPD79Eo+xY1aA2mnCh8SBCSPmHs
	ChUmTLq/F2fuRz+0sjWNjJtSm7wtV323suKZ4UQ=
X-Received: by 2002:a05:693c:87d5:20b0:35e:7bfd:4613 with SMTP id 5a478bee46e88-36a42425470mr24210020eec.40.1793811467022;
        Wed, 04 Nov 2026 08:57:47 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:46 -0800 (PST)
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
Subject: [PATCH 16/28] Documentation/litmus-tests: Add hazptr drain engage-wildcard test
Date: Thu,  5 Nov 2026 00:54:34 +0800
Message-ID: <20261104165504.2430480-17-kunwu.chan@gmail.com>
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

Model the drain engage's wildcard defer: if the engage reads a
slot holding a wildcard (an in-flight slow-path acquire), the
engage must not complete for the target address.  The smp_mb()
pairing between the reader's wildcard publication and the
engage's slot read forbids the completion interleaving
(herd7: Never).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  5 +++
 .../hazptr-drain-engage-wildcard.litmus       | 44 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index c2bf20fa4092..daab126e45a2 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -110,3 +110,8 @@ hazptr-wildcard-flip-escape.litmus
     Test the in-flight wildcard window of the single-pass wildcard-flip
     scan: a straggling acquire that published the old wildcard after
     the final walk cannot still load the unpublished object.
+
+hazptr-drain-engage-wildcard.litmus
+    Test the drain engage's wildcard defer: an engage that reads a
+    slot holding a wildcard (an in-flight slow-path acquire) must
+    not complete for the target address.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus
new file mode 100644
index 000000000000..0cee89893dad
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-engage-wildcard.litmus
@@ -0,0 +1,44 @@
+C hazptr-drain-engage-wildcard
+
+(*
+ * Result: Never
+ *
+ * Models the engage's wildcard defer: if the slot holds a
+ * wildcard (transient value 1) at the time the engage reads
+ * it, the engage must not complete for the target address.
+ *
+ * P0 (reclaimer): unpublishes head, then reads the slot.
+ * P1 (reader): publishes wildcard (1), then replaces with
+ *              the target address (2).
+ *
+ * The smp_mb() pair ensures the engage cannot observe the
+ * target (2) while the reader still sees the pre-unpublish
+ * head.  This verifies the publication ordering that the
+ * engage relies on to defer when it sees a wildcard.
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
+exists (0:r0=0 /\ 1:r1=1)
-- 
2.43.0

