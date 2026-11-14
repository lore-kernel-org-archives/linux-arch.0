Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675424;
	b=algvf5anOsO5y8xD3f7c3li+v9qfsApwj8nji9/UTPDRLnAroCXLlx2hu4fNnECn0PM1
	 yrTdu8tbX98c46/GPsroUpjXWjpXYuXtYiBfgjAPPWSfAGnrmnRH4R+1QsK4fC29xUAn2
	 PRdinNzaeFS/Q0dAIfOGbtPXPp2y1AYqHKSMvjACMbmF2Qk8BXFc3wxBvluydq1zVjEGN
	 oEysmDvJ0Cs6hs5a9fqFLUKaiJly4nHI5WIZdgODQNa1Ip81e6SH744/ZktywBxgTapkh
	 oKojOnOxN8V3sRSN+HsmLLRFN3kc2LkQJRbs7ChXTdhdveJzB3wgw7S3bAXUfR9+Gkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kB2P63pySpY4bHLP3FK3dbsTPUwHpQNshikdg21FxNw=;
	b=kRWY5kvoiKO5n/7T6MBU+PcCUIYuHmFEv1QNw3+s/ajJVzswy5WC9NJNfHbMxsUSDnOQ
	 cyssTV7H7q4l2mOEObB9FAaFokU195YZ2zLMzF7UPcclwltPVfdJCc6rjzxM6dklhBXV4
	 tD1R//go/jTc6KQNxvOFyos4knMI4Q+UJT7CECgjhGhso1RoUDbpLhnQqodIrilxqKKUn
	 g+QdxR17i+4hxB6tFMKOKeGqeBfnPdSdrLLs04Oqgawf5DHbtw70fV1vc/+y/1EWjkMtu
	 41zr6yNIbB+di7MkhpizOiY07CEw2sIKyO73nCpwlg0c+vgXrBBtmmsvXQiI5U2ZnBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fCTyKEyw;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC9606A32D
	for <linux-arch@vger.kernel.org>; Sat, 14 Nov 2026 16:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CCC9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fCTyKEyw
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso2831981e87.3
        for <linux-arch@vger.kernel.org>; Sat, 14 Nov 2026 08:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675422; x=1795280222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kB2P63pySpY4bHLP3FK3dbsTPUwHpQNshikdg21FxNw=;
        b=fCTyKEywbFb/Gj6ArD0eixh3rczz+J5hMJOUnzIxzf+M+jbIyDqq2e1drzpk82isGw
         oa9eqzP4nuQo3Ny03XdlMLljsWhDsFF0UaqhbwBUdkaxvHe8A3gBCbKf7KZTEQaJHTSB
         wm8sql6dTAsaQOI/qK+c/dZSA0ppTyEAr1YxLcfxxxpav823KpMziGWO/fZpgHKBm9jp
         tsnz6Yhu1xXqxUEZH6dJhWt4vhgZIOT5e1ifwVs9KkpDKSAfa3JPjBhgfrU5fxQkI7ad
         JgK+EuyJ0QX96OfqdGytYfz+pjFggzzhkX8yNMrfvkPswYxJdJu2ECp8iZlTpAk2xSoy
         uO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675422; x=1795280222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kB2P63pySpY4bHLP3FK3dbsTPUwHpQNshikdg21FxNw=;
        b=TpgYpyifuJCA47cWklSgZCREVB/gl7/itwwBzFl3uRq2mS+6iuXjWgcnHqZ3z7RRQb
         m9j55jnmJQfQrBRgpacS2AiNee+zr11RzlZ1w93H7mgPnsoUTO2+tKzMWnyxdk9BpAuV
         VQn507ErPkTee4eGbfs6FzvQkooxFhXRUBRpTxe0iG8fWyoaIAkGlhsGAGyN6ksMAT11
         rQ5dg54X+jXfKKZ4l5JryNk7GPncuofyXjBl9U7e6sNtjjSRL3GxVjI0hLSjYESFDatP
         dujRQM6pnP7YY4cvKNACro3u4a2FvyAGhK9v5Ae+QcZH7AmR53U5NOERMCNx3VGtHtRc
         31qA==
X-Forwarded-Encrypted: i=1; AL+hErFH4Sof6vqQtvxuZ6zeIe03MJRnPpV598P+t55F1lZ4eeoTLUmLUjMlcQhJSq7izhXzHcY47IEC/ZgD@vger.kernel.org
X-Gm-Message-State: APuU4Z9ovqAnNSyce7WH7JbFFVtFV2RfwNlSHm0Km5tgYPTjSviNvw6O
	IPbpPOPWT4Gv2P9tH42PU5rMNZMmLVJnMsSjfEvE/BaYL1oA/YzZfJIAI8ZkzFyYdNnCoWaC
X-Gm-Gg: AYBFou1G7RDQ0nchkEVGGrMZGK/dFcGMwBCC9JP3o3bsFFQLar1EmPBCxb7hlvDmopa
	u7txH71ufDrBnB24e4hX5x+snmAjvRLRQxgGxHE5Tv/QJYHS0u4qcO5lMCRxfcRHvHPzn+S/vpH
	hTMo4/blAULslcuCacYqjH8oOJKcLE+4vKeXPaUtpoYrYLHOEydBs0DWazM46nF1qp4bqeL4RZm
	buh+lcMZUBBkj5OqNlUKV89pesS9LGb2W5JW15n1LueBca8J3kX0BEs0rv2JYXnM7fwsmr3Pzr2
	NBaVKZPnUzwxKfxm+1RVqjDenGBEbx5hwoKEtp+jkTTOpOCjimHSZsuCy9FtuqFm+tiTwgTVcvm
	PDccg7/+nqBo4OMdDl1qTAj2H3K7qfvMDcLsnZKXslHPRhf7RqyMF/0YeV0q2GISMraDd4+addU
	raaRioqrH5J2pQ1zQeBYJjW9ahrkQgXOF2iJWtFVDmbjWFes9sHADVOMavDHEGewZAcG3DyMuR3
	wd0PmhemH73r3+2Vi8Qxdi4qBPOGvatCJ7aNgOMNzPKoaWYb/yRvqgSCGJHYkDdh+xzyrRcYmys
	Eu10aC8G9EqswFaeZc7KXnmjoplpSAKikNY+zRdN0TdZKOAtYbvQAlaOB0yFF46Yxqhxoi8tdho
	q+T0M/7PIRQ==
X-Received: by 2002:ac2:568b:0:b0:5be:4754:22a1 with SMTP id 2adb3069b0e04-5c170b68cabmr2134942e87.60.1794675422319;
        Sat, 14 Nov 2026 08:57:02 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad26sm1792051e87.8.2026.11.14.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:57:01 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 09/14] sched/preempt: fix duplicate extern declarations
Date: Sat, 14 Nov 2026 20:55:49 +0400
Message-ID: <20261114165612.368785-10-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114165612.368785-1-safocl88@gmail.com>
References: <20261114165612.368785-1-safocl88@gmail.com>
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

Compiling a kernel module with a C++ compiler results in a "duplicate
extern specifier" error.
This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
expands to `extern C` when processed by a C++ compiler.
Since the code already contains sections that respond to a C++ compiler,
I believe it is a perfectly valid approach to gradually move toward a state
where kernel modules can be compiled by a C++ compiler without any issues.
The `extern` specifier must be removed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257
Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 include/asm-generic/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 1adddeab8..fc0da591d 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -93,8 +93,8 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
-extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_notrace(void);
+asmlinkage void preempt_schedule(void);
+asmlinkage void preempt_schedule_notrace(void);
 
 #define __preempt_schedule() preempt_schedule()
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-- 
2.56.1

