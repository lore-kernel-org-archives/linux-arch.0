Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFD258CD9
	for <linux-arch@vger.kernel.org>; Sun, 21 Jun 2026 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782079171; cv=none; b=D3SU0wGgny8eUpSHTiytqF93+9rDF1JLZa6O7jQ6kUMY5yoj94AoPtMZyR+yh9rSmJ/926gDPtfYlg4A98odymDgT0cjSVTULzQGHIy0WqbIC/oZNYJzdiJSAzfW6CwI136vmIgYD1Wmv5z8TEVhMJXRRXG9408hndGKD0PPSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782079171; c=relaxed/simple;
	bh=N3VU06eEnyF9WK4ZnjJx6OotfsXDkORp6L0N5LXN9MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/ptTAlTphcLKfE0nlbpxbABVZmp2n0PLF6v9PjsczQXD4g6+uGdlRB54FN2EqLyGRZzz69S2aI3hfpfMlEfSOVywAvLHZmErnuOkMKedc3Fbs7LbqVwSNnNq9Xdgn51p2R3ev/IOgiTZ2kG+ZsZ4RXamPgPsVxPK0IRi4wMtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7K7YcUk; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7K7YcUk"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-923220bf1d5so63460985a.0
        for <linux-arch@vger.kernel.org>; Sun, 21 Jun 2026 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782079170; x=1782683970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4A9WTgoAD/7GbLsWbQWrGADO7JdEymLj9UmQvxqvAeg=;
        b=q7K7YcUknEfQ6NBJ7d+fZp1TXnH3o34CEpuvulm0tK+AdZUuq9bhFmAKzlhnQ8/lfA
         g7V63OcPaewy576tdbQ0jA+nxgGUoVx0bxsKQmBmbJTepeaittXo8yxoPtXAhC6rcBFO
         0cZpyhDujmEjQ+2/LXsQspiXivjc8uYMyPpQCOiepQRSbs9gJFawBbMMiyc8xslSU6KJ
         qkFzigIk/SL5r7nzcxuYKCJvaE/Cm33E9Xm1HAcmOcUhuQm9iB2dCuRbzGZ81fyppCxo
         xAjglQ1AuFD8iLI3Quj37UUhHRQHLZW8juTrxWo17HGEJYdIlfTBKxbqXCbad+EEwg/t
         /hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782079170; x=1782683970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A9WTgoAD/7GbLsWbQWrGADO7JdEymLj9UmQvxqvAeg=;
        b=H4TxlwAk06Fdkyn1F1GvjPs1LmLtHSj7lElnsNlXuv/dvmQ7IK+JhWUI4hn9DfgnoS
         btBJ0vxWZyio60t6bRxVO+hvQ9cs6XjK9NnGXW040Q44i0jBJg9LFBJKvXxuwA9vgdm6
         Go7Y6tvCQ4WK78DzXAJ0fu5hB5inN1/yiKY9/tdkxZzn95IVLOPakxVFJ2zrR+SQExfI
         fQ9lLhQbYJe8jbPVtNJEGipHlvnY8h4UkfO4soO3hYWzfFEpJjrQl8wQp6figV4ZJB5o
         A3QoGu9Lx4qW6mcAfZ/8tFCpDGttq76AHdMdsBvY2C4NqGJdgA7qZo/3OVW2qSFLLx2c
         IdkQ==
X-Gm-Message-State: AOJu0YxVLnKfbVUlcSEAqsJECL1135ZYwNA/+6uLSWnbKEtaZQ9zk5jY
	qW9HW7cEywfLT2OpTxx+cisQpPwUWSXP4m3p9c7mLQ0kDffVjYO3CE6dp3QDLV/Klw==
X-Gm-Gg: AfdE7ckMxBhYQyzsFZ5WDstGRXq/mCiepjM1fv2NVym5Q9QRfVi/C0roCp4SlqfVBTQ
	Hb9k4H+cHWpTjqVLpXzPvUJ2mj3pUFHtMjd/yUvlGPCWvpf5PviSTdHvBHnVb/PwAbVYbymwuzK
	mQQJMUcEmlZXgISUN5bY+SJNKUNYwsrbXY5vCsuWrHTevI64gJOHHVL9ZhjHMqZq7a6o2Xh1L+2
	0uqZ089EVgBxr3xxvzemFQGWokGZ4etmpk5v0jNcv3JdVAzWoAG2BudqCs8CKpvbuEn9rEXCXEc
	TRb791pa/LCQBCIi4zOuKjGTCcvdQz49Mzj8IEYRxaXdDPcwf1+vSUpXywEY8iew2YYXVhXIzuV
	CiBusVR27IKdtGTPnJfG2RuFarQR493zwiy3eKVS/UwxpSDbOLKu05ikB+VZxseXu4drZkUSHRV
	AK14HSKGF4sbt/vUvHhVSAQPi9yA==
X-Received: by 2002:a05:620a:2590:b0:916:411:a143 with SMTP id af79cd13be357-9208fc1621amr2153648885a.21.1782079169635;
        Sun, 21 Jun 2026 14:59:29 -0700 (PDT)
Received: from localhost.localdomain ([187.73.25.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921daa8074csm705068485a.25.2026.06.21.14.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 14:59:28 -0700 (PDT)
From: Sara Sena <sarasena.adr@gmail.com>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sara Sena <sarasena.adr@gmail.com>
Subject: [PATCH] uapi/asm-generic/fcntl.h: fix typos in Open File Description Locks comment
Date: Sun, 21 Jun 2026 18:55:05 -0300
Message-ID: <20260621215505.1039472-1-sarasena.adr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sara Sena <sarasena.adr@gmail.com>
---
 include/uapi/asm-generic/fcntl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..06433ed5e3eb 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -138,10 +138,10 @@
  * not inherited across a fork().
  *
  * These cmd values will set locks that conflict with process-associated
- * record  locks, but are "owned" by the open file description, not the
+ * record locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
-- 
2.43.0

