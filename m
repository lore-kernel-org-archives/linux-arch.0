Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811440;
	b=yj56pF8LAmUV9gl7EXkuF0WoAEYXRp4hF25CGlkSs13V74WiKqzOCigbbBKUY9M4hUhl
	 imFNSXKE88YEhTdb7JTOBi2ffpc9D3zvIYw62OWGJFe9dnQRhbaOh/plB8NYK+i4PHN/F
	 J3HL+MAKthwsuaZhAVkLQpJaW2lIgC42jXMoLuYHxlZ3KpxOecNq9eCkLV3gKRUSl74Jn
	 998wSDFbkoaacy01yFND6Fo83yG2Y+2K6Lvqureub60gXeg2X7/s2k+Xb/q2EADNKwfBp
	 6Q4Sluo0q+g5e3yIfdtzhLIxjwXTlpHEB23RS9toIHVYVcGt5itxgx3CqVPbmHTNCuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T7J8ny2XgS4VVLgay75kRvU9FcVv7Jejhnbg0Ab9f3s=;
	b=A/m6sZeA0/32Pq6gD/ur6LNnk5dZAF6wFXW5Xj2RxjbBe+0Au0mGH3biNTPXo75+bjrH
	 UaXxN+RWmeZh+KpyIH96rgCUBv9JjWdemg3H9tOw4oKvFikO2RDHRLTr7b8NcMlhfNThB
	 EbEBxUuSgpgfOx6O19HJ0z7kjT35xP5Yorjw1ONCMtvyeCdXuk4SN89kg+UCLJ8zNaXWf
	 vt8dIcSNhFy83NgfJYgTEyP3ieBNqwRpjIg6pyLvDTndH4N4Ck6viNejm4Wt37lQ/3AAq
	 MTl2UA0hw7G/hC2tUBDrF9vS8pH6wZvxkgLKOkd5YfhCEG0dtDzh4saHTpc1tataDtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2vGqyXw;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702D606D824
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5702D606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2vGqyXw
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so1615349c88.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811439; x=1794416239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T7J8ny2XgS4VVLgay75kRvU9FcVv7Jejhnbg0Ab9f3s=;
        b=s2vGqyXwPr8s8Gwnu+VGfdfhZQeEInJKusCv7m1LoH8gsWmASFBvbyNMs9FBKJlW4O
         w/PVKNUu/g2ucDcu6JfiST2Wof2Fl94gdHZ4+ToBlnIzT/4AIJVZdBXNtfPGgAsBSqgL
         1/H7gD79joZjeV2l7BTgbhHhmsrcUArqUyxofoaxNIRNKZ6pXyvjQoIzVqbOhoi8nuhZ
         fkgYG+m4CXSEayHsN/tPLXn4fNqtbBO24dqtc4eImBmZZc46UFPcDPz6pSP8397LHEzs
         VPar8yqhNIXgw10k7ke3w5+ezHaZBRs6WLV+x1r+x1dxeu/U2t3tk2qW6oum4qlCYTQ4
         cs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811439; x=1794416239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T7J8ny2XgS4VVLgay75kRvU9FcVv7Jejhnbg0Ab9f3s=;
        b=vxAG2VIGslfSrAqOHi2ZFEIUYfKD4OcLGvjroU+434oDuI7S+3R1tPsiscOY2dhVAr
         bgV5pQ5Jzgvj/JTxz8NT0nyuv59YzKbV9409ZCQAfdTFLKhb/g8Yl8KcwVx5fhbpZeKl
         ozao/RmKbCK5skqEwpczKs6HZ5y0WNtZxC19K1RViPi18CHLV1DBSye8rsZQvAiomTVF
         +9qohSgJ9UrEKM73ruZx9mpq1+i8y1wmYIGfL26KHk05N01eteQgVsrf1NoIShTyraN+
         Ug9lZa4jmCbYYYsu4BHjSZl5jCk3OAgvkJ6QCTzV4vdedgXALOPGU/H1gNMIgD+Rrqtk
         jQ7w==
X-Forwarded-Encrypted: i=1; AKwUvBxPeNcVK6ayxuWIDU+EGXjE7mXiFRfSwrI963/lWOsNF60Go8SU2IppXzOjaJO7XT64JcPQalCTSg0d@vger.kernel.org
X-Gm-Message-State: APuU4Z8Rla9tPytQcKHC+VlZ0/cWFSvUFOg2cWMbtSWEsXq0ZkUDlae/
	ycb+RDeFwo8GlUUAqvX8gpjfLdaqwlDpcvpQlEyS3wKLrQBD+eVQ5gLW
X-Gm-Gg: AYBFou0E1eRtUxFPzhdVNj4DyZk5NRWjQI7g58/X3Bs7tCLYhBAaBt52mMrzXw+dj5z
	auyD4ueDArGTsAQ1cyjL0/UikAzpQ/L3zGaqjMk6anb3mSP3fjD4ym85EbumR5/Prbm5KTrF5pt
	mCd5bIJlhO9TBkU2FwvhvnCM4jf6hF+bnEiMUcvL44Hi10O8c1RDusZk6sxW/vlzre3ss5EaJbS
	8a+tOek6k6b69F/munrQ7LJGbpHw+knU8U2LnrruLWn4WL7DnKexmhZMd9F4oZl7jvgGYZUkZZL
	2pDv6aNYd2Jl8iAZUgcUzkESD+lS7mjyhn07xjEhVWI/ppGE5URkQ3WEGW9RrKwQcfdCfT50Dfu
	mQqlYcy+lmVnJMGDZbi2NBRyceUSI8/fwemMTUB/+03zb8R1f9kF1H5vSXbS03u53XkFiV8nN7j
	ovr35wy9jIyrXPH9nQEjZ4BXYpRn5zr+oiQvKcJ2DtEZ4VjqSVZ02gSf2tY39fsj1EQhxA1znem
	WwP5zLEt2VnQeLg/o78+RqeV3sTxAE/z4mcWYKRr/ZCkDDCsTBsPCI/tCNMuKDidbteVVS6YuaM
	jZ6ql2JpSBBcKENRhrM0RPkT/tdUPx59WgumL3A=
X-Received: by 2002:a05:7022:eb42:20b0:190:3950:43e2 with SMTP id a92af1059eb24-1ac5a0b8867mr24847940c88.8.1793811439033;
        Wed, 04 Nov 2026 08:57:19 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:57:18 -0800 (PST)
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
Subject: [PATCH 13/28] hazptr: Add waiter-enqueue tracepoint
Date: Thu,  5 Nov 2026 00:54:31 +0800
Message-ID: <20261104165504.2430480-14-kunwu.chan@gmail.com>
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

Production tracepoint fired when hazptr_synchronize() enqueues a
waiter onto the scan kthread's pending list.  Downstream users
include hazptrtorture's staged hot-address scenario, which uses
it to confirm enqueue before running its controls.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/trace/events/hazptr.h | 29 +++++++++++++++++++++++++++++
 kernel/hazptr.c               |  5 +++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/trace/events/hazptr.h

diff --git a/include/trace/events/hazptr.h b/include/trace/events/hazptr.h
new file mode 100644
index 000000000000..1eed4c9fd682
--- /dev/null
+++ b/include/trace/events/hazptr.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hazptr
+
+#if !defined(_TRACE_HAZPTR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HAZPTR_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(hazptr_waiter_enqueue,
+
+	TP_PROTO(void *addr),
+
+	TP_ARGS(addr),
+
+	TP_STRUCT__entry(
+		__field(void *, addr)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+	),
+
+	TP_printk("addr=%p", __entry->addr)
+);
+
+#endif /* _TRACE_HAZPTR_H */
+
+#include <trace/define_trace.h>
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 4784df78be4e..16f6e2acaf87 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -19,6 +19,10 @@
 #include <linux/bitops.h>
 #include <linux/bitmap.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/hazptr.h>
+EXPORT_TRACEPOINT_SYMBOL_GPL(hazptr_waiter_enqueue);
+
 #define HAZPTR_WILDCARD	((void *) 1UL)
 
 static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the list phase flip. */
@@ -411,6 +415,7 @@ static void hazptr_synchronize_queued(void *addr)
 
 	mutex_lock(&hazptr_scan.lock);
 	list_add_tail(&waiter.node, &hazptr_scan.pending);
+	trace_hazptr_waiter_enqueue(addr);
 	if (!READ_ONCE(hazptr_scan.wakeup)) {
 		WRITE_ONCE(hazptr_scan.wakeup, true);
 		swake_up_one(&hazptr_scan.wq);
-- 
2.43.0

