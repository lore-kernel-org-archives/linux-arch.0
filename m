Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE833F5B6
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954293; cv=none; b=ewQvCHwuTtLOhAS54M+HO5Dt2Nyx/bDWwBPde0m/lzFo//ng6dzyuWgglfDWJvwG0PlnwIl3NsD0V//CEFWqIrjOGWu8Z15Q8Pi9whl8azdCol1is8TkrgL3wIyMuGgkGaCWPVAbT5CVrxe6pg6LSVRafbJauUOBLsEYKthF2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954293; c=relaxed/simple;
	bh=7THB1bL6y55WFNbY5y6Yh5aafq0UxTzyNixj6H7ABJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyChZujQbVxq+IHTN9XXbrAQYzP27rh7vzAFooe31rO58g40aaxG98JArcqz+ZuqQBGsQpjvYg7VMl2N9heLHe07nK1A1LtCOXLuZhRdIGjk5pH0C3EQ+Mq4JEkLPytBdacablYraUfOwxIT/56RfPS4y3N77Xr8cGlTStAyf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RecOqUnP; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RecOqUnP"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e36so2740804a12.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954291; x=1791559091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CaFaqYtL6ykn5j8JV46Jis92rLHH6YNIdL4TlyVyI/Y=;
        b=RecOqUnPMDxGl+jyQlRm6qyroTQmhwUPJ8x9PWnbQWMGOZrRGcf7lyh14d5I1Wew5L
         di2PaEIZdhdtcQHXt4v7mc3vS7uD6osTfidS+PopK8rqUijavsUkNdp0zwwXMUDaXZ6g
         s3d9cobbl5tP3VHdvmW+PvfZWkVR/+R3zNd+zQwOfi1Hk9HYPYqVo02OTEaqtM1jXr6Z
         qdn/XGfR5eQ5nSb6P8nY1OWol4yzfmr8auKpfh2deyYdrX3r4/VU6RJqHBFiZXdwX7mR
         EN3Ry2lnQGdljpbrUjcMo3tksT0nBHchCOBazF/bS0EgY+0lmMEpOv7+b2JypG/7Vt8v
         6LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954291; x=1791559091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CaFaqYtL6ykn5j8JV46Jis92rLHH6YNIdL4TlyVyI/Y=;
        b=CDAuFmTNW/fVPRcAvbBnbyFAK/7qwyAOpqB+BXQw/upBMi4A41b6mZV6e1zPbKwIr2
         +VpVbaeZYFZLj/MV+hMcltXrqePKCTcUyxJZV/ZIqa6bpiufaVyJ+XKxv/oWfgA8kbK+
         HWp64s+NhkcVIe9eOw6ytoV3HBqWsPIDp0eGOFTOol9CacMZalD0UnyooQBWQpn1hKEA
         yxauSJcnNArQqa6pO07/QbQu33RebCUgWzPrrhXksOwFNC8D3lzxW8vFSZN9cCGn4cu0
         skBid0+oXvZxLLRKg34HcJKitmwo1RrHROdsx0svkRqozFkuSJB/alH8V4fpKNtDRXyz
         q1Rw==
X-Gm-Message-State: AFuF++myOHq4/COW8CeE5zpyo9ruXmCNebhePl3mEf9vDBR3Y8nY76VD
	4bePcc2noHb+mJs8yXdJn02Np5PaF82ATT7fDMmlaDPt9Jq0XK3QcXYb
X-Gm-Gg: AYBFou0fMoBVgImAKBu+QWd/B5QGAprAp2jdqY0GTeihZO8fsKNmwW8JdG9uMxNVY7q
	vb/by9MwuL/Mhv3e05OX5bklpYnNb/2u83FU7ZhaH9YS6JXsI5E1+3LKhpf+/dI3uILKyMmR6uD
	ss0F76tA6e9CNezBkIQXxMcwBr+U/4KM6CfA7Uen6PTF9NS3BZSjPgaRhJVXBLQGTeFLknuSnwJ
	eD2B6k5mIFWHLO01jDOSnhtMOu7nsyStf5IZ/2mbZDKHrWRTV5fuyCdYbSTs0M8HcslYDCdHAJy
	Nw3vI1udeL3k7uaGOj8gt1/rHehX0uJTXnLWAHarI7UpvY2NHqcbQX2qGFo5RRQvlwfhG6I8aZk
	5lr6AMAwT8TsECbAcMGf4Mrbnf7gFlrisUTpECd3dJRiimMDohx38AriJ89MCGoRI+3bIuv1lYa
	IJkutZJYDeMyckt71oimShfhtk4r8IpNTGuYYCBbv35I5Ix156LhAiz/47Hx8Qb5cpLWEj3zBbi
	VPdz136sKO7zWe27w==
X-Received: by 2002:a05:6a21:670b:b0:3d2:df:1854 with SMTP id adf61e73a8af0-3e0bcac222emr2755480637.6.1790954291088;
        Fri, 02 Oct 2026 08:18:11 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f73551f2sm1166635a12.7.2026.10.02.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:18:10 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: arnd@arndb.de,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 1/2] rwonce: Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU()
Date: Fri,  2 Oct 2026 23:17:55 +0800
Message-ID: <20261002151757.3605081-2-kunwu.chan@gmail.com>
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

Per-CPU variables are sometimes accessed from different execution
contexts on the same CPU, typically task context and an interrupt or
NMI handler.

A plain READ_ONCE() or WRITE_ONCE() marks such an access as an
intentional race but does not express where the racing accesses are
expected to come from. This distinction allows concurrency tools such
as KCSAN to tell an intentional same-CPU context race apart from an
access that may race across CPUs.

Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() to identify accesses
to a per-CPU variable which are intended to race only with accesses
from other execution contexts on the same CPU. For now, they are
simple wrappers around READ_ONCE() and WRITE_ONCE(), so generated code
and tool behaviour are unchanged.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/asm-generic/rwonce.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 52b969c7cef9..4d4e009a4489 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -61,6 +61,17 @@ do {									\
 	__WRITE_ONCE(x, val);						\
 } while (0)
 
+/*
+ * {READ,WRITE}_ONCE_THIS_CPU() identify accesses to a per-CPU variable
+ * which are intended to race only with accesses from other execution
+ * contexts on the same CPU, e.g. task and interrupt context.
+ *
+ * For now, these are simple wrappers around READ_ONCE() and
+ * WRITE_ONCE().
+ */
+#define READ_ONCE_THIS_CPU(x)		READ_ONCE(x)
+#define WRITE_ONCE_THIS_CPU(x, val)	WRITE_ONCE(x, val)
+
 static __no_sanitize_or_inline
 unsigned long __read_once_word_nocheck(const void *addr)
 {
-- 
2.43.0

