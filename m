Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1BF3EB816;
	Wed, 18 Mar 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859565; cv=none; b=XslgMQvHERRj+RwKm6Srb4D7evT5DzR5lnNvuXeNJ0FN2ZipE9bDcpGsjQkYvIMT1Q4rK3RI7CX60kE/zEgue6KD6odjFMLDKLfMagcesDq5sF0lPsPQbFnghpNJQ17fQjOBfmqDeDVRbASpfPmVRK3l0ewbkJ0MReqEjruD/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859565; c=relaxed/simple;
	bh=SyYuQFGWMmZJRxmCbft9EntqThEpsOfEdFb3Oa1hojQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmWFgjvUaoubU+0+D4ibTMNO82PR4vjYZ7jyTNjiUB9QHXc6jakLLkLYpQdjCr19ZffLuO1ukgadmmU3vUUy4bElmXd17fmxDVMrVWHES1bXH7tg/V2bwG0ItEXW8tS+Al9Ilm+8L08ONr+A8IBw8KCxN3LfuF0QKwfQo42oxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=tP/K8ULe; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="tP/K8ULe"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id D1540B3E3D;
	Wed, 18 Mar 2026 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1773859554;
	bh=q0ftc4L2bIqiqI9mtmvfrlvg+trY+mrARU5jBWKEO6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tP/K8ULeWlpgrQpV39MOViXMD5nLVW460t3I5KRLFEqAhRWVVCAuGp4YY/aqEpUC7
	 dKvz0pefP8DocunWuIRyD/rMLAe0E0/+BNabkUp12kh0Qr2tMe73xuRb3n58garjMO
	 TheqUqO1JEYnam+MmyzgC56LpY5G4Fs6KN3ugRuo=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v3 1/4] tracing/lock: Remove unnecessary linux/sched.h include
Date: Wed, 18 Mar 2026 18:45:18 +0000
Message-ID: <20c992338fcd0986b7d32b1c080fb835b42172be.1773858853.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773858853.git.d@ilvokhin.com>
References: <cover.1773858853.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

None of the trace events in lock.h reference anything from
linux/sched.h. Remove the unnecessary include.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/trace/events/lock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 8e89baa3775f..da978f2afb45 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -5,7 +5,6 @@
 #if !defined(_TRACE_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_LOCK_H
 
-#include <linux/sched.h>
 #include <linux/tracepoint.h>
 
 /* flags for lock:contention_begin */
-- 
2.52.0

