Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E333D6F9
	for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2026 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791340162; cv=none; b=hCi1TQz3l2efwZLEBV4vwrNqrj6h0XOnil7CbZHwwpcYsTLwjywEEmD70uCJEido9WPhodoiWI6YB8zr4FxQN3tPBy3mR+x6OjokT5WNdxHfBwNRqbPbTj/jSeWO3ZHsnJxNsBTzfpd8qFCffHm7WlThMT6qHhd1ud5uFNrDPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791340162; c=relaxed/simple;
	bh=BMRJ9FNkw10Jr8T8VtBLRRoesmOFHwsxxr1YR8BmuTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3u5SIwkrR7B/DhxBTDEXBJ7dQrJ4XLiHDrCW6E1rgrxEdQejwcH+oV3cbZzMFqGvq+UjrvCl5+7xNPnEgiU+/EjLGXpzABtqBx2xMnW8kzg2ECzYDiraZoluzcTzzu+vVP8rW1mG9ylOLb8uaTAWPb1hrD9vAKQXc4KxlchdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFp/Y59k; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFp/Y59k"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1021278a91.2
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2026 19:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791340160; x=1791944960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkyTJS3nQKwVyxS3uRKR7tQuJ/5jtxENQKhLtBkMZV0=;
        b=JFp/Y59k6khEkneB1EhKVE9mtKn6RbUN/tXNKsar2m5Uhsy09IDfj2eaTKkMrfCvYH
         uppeOczVYKWL5d5CS6pGcdukcIqgDJ/MqPKtaDeB5uEiGg35R49MjTJfCE+S3UIyBC25
         5PplRn9Ekansvc+JKKD+TvTRAvqxffQ+NWOAnMJbsm37/Lr1NE9wgdwag8a7H+2HgF6I
         f51vvqinZD9nD1ti9hNWB/La29aWSe2ett6WIORXuOSSHR3lqzxU2Zeb5Jnvk8x5THp8
         HzNaW/vJZFn+8y1EgGvABCqRO7ZCN59ews38z/+cb1AXEUFMhy+PCS3D2cQnp0fP0KWp
         2C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791340160; x=1791944960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkyTJS3nQKwVyxS3uRKR7tQuJ/5jtxENQKhLtBkMZV0=;
        b=jdJf0CitGzkHASVfeMAcPOHB5joeC+Kylox+t2CxkTcurI/8lhBziH4SNHPaYk34Y+
         mRDwYo21fcZ8r1ODCqJiVu1+UrRORil+6eFh2NizhHYPVKfTwkVbxB8oRjwnSk3akO1h
         hxqV9fnj+KP9i+5SgGSSQa0DMrNYCq+kE2EYfWzl0c+sdRPqCB1CdQKC8bCwwFnJGSll
         KhcqN5qfYdUJzSi/Y1vs7NI7uqE/LSOtb21zU9VFM62jkR9zWkYS2CdSOUIeTaeSxrVz
         2ULCekBme7co4PDCxG0jjuQiIuNvDJioL4fzFyR8G+lStPmDNLawVbYe1dX9JwxK3nn2
         IJpQ==
X-Gm-Message-State: AFq9FYKw3+lnuqpA77oGHXp/CSeXydeJL8+GKCU12uBqqjvMeHm/n4Kc
	mIfHReII88z755YSZjgvGsNJ0zVOYx4KhoVkOycubdVcILekeNUgF2/c
X-Gm-Gg: AYBFou2C64S8uwWWbwFFpKe6p3FjHIG0Znq38lAoC+Jvv6P1VrtwZxd4z9Ukn+OKjIM
	lIjgMTBqIv4zlwCEo+BDk/cTn5jifSS8QJoBr/JqaCKlsbls43cXbah+QnngbTG0tP72SMdC3HW
	ujpdz4flLSkr1Ix9FWxCcBny+yv/pHtKbaYrutkTxiH7VOC75D+jj6bhTRIk+7H1uQLWuFwOfeG
	ksSz/+eqNBfvBPgxkYd9yUg8Pt6lb0viXcBAMOtRrDX4u2d9QlXOMqtap5RQSQ2qkszP+90lDGu
	fsPhAnpT40viNGykodZo77Ozwan4jrjBz7wH/WZavPTBu3JTAzyvefdiXCydyXqJUZY6ZpWRF12
	Z4eMsBd8wM75sPgNExHdhlCQuV4yNH72Uf5+Bcc/XT/EObPM3tWrm0ZQ2Pkg9o5rDxZ91K6lqDG
	M6CwJD5Yu/abO0RsmwjfA6cPJXeoygvb3WNIFZN3iAs6l4fRDPyJftPi6arqdZudmd7j8aW+noB
	Gfu/OmyLsx1rS+nxE3XhGzfj72gSQ==
X-Received: by 2002:a17:90b:58c4:b0:3a7:9ec3:e9f8 with SMTP id 98e67ed59e1d1-3a8a0ba2239mr557276a91.27.1791340158978;
        Tue, 06 Oct 2026 19:29:18 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89b5c5d9asm2090836a91.11.2026.10.06.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 19:29:18 -0700 (PDT)
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
Subject: [PATCH v3 1/2] rwonce: Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU()
Date: Wed,  7 Oct 2026 10:28:58 +0800
Message-ID: <20261007022859.60101-2-kunwu.chan@gmail.com>
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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/asm-generic/rwonce.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 52b969c7c..4d4e009a4 100644
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

