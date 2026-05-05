Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A04A2E0F;
	Tue,  5 May 2026 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001005; cv=none; b=uSq8yktAsv5LHEPwewPKbt7kEossPChkFlAq+lcGjd2jtU79lq6GJs0hIDFXRdpkxnsjUz8LFqIFLLS0MELNkUSuCyqlOngUs8H0H1RarF9s2RPVqQG/iBYsUOruXQeZEuRadgphM8bMWsrFy9BIkX4XiPFSqdshnt6KdBkpedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001005; c=relaxed/simple;
	bh=4EDmDHbkx8sWstAxmN5dypJ1uHXNHsE+7kGZ6BrByBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZQRZPFX07lTcvNOFmKuF9GUaKvsGhguAt93yTt7ZtZ4nh8RleNjYk2dE584PgDTVcpJfkoiCxObaiQIV8MOe12njLzHGZSlNlF8CTha6QaXXHn0uz/dUnFhlZKG5IR5oXyB9L7OMHaLh7spKweGE5L3ZS2xSi129BBbNY1ZZXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ssEo3Kfr; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ssEo3Kfr"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 1BC05CFFEF;
	Tue, 05 May 2026 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1778000993;
	bh=SxdOxmJ+WRA4zY3tyFP5+GgWLQ1rokSaYX9143EcXHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ssEo3KfrvTzaYppTeR/9SbdtJSPaIVu1WuRcuxgZD6c7mHL+wbdWTgbH50oMX9Rx4
	 jbiTDSsFgKtyohDLtiVfkwSixAPFGoCqLsroBDbbi8FZyVseJMQXFy3LQGSrAai9Nw
	 1x1vAXnXREgWmxSZd9lkIwqxSPbEE82eVuY97/ms=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v6 1/7] tracing/lock: Remove unnecessary linux/sched.h include
Date: Tue,  5 May 2026 17:09:30 +0000
Message-ID: <16c1eccc88e1a1e67028086151c7fbffddf980e5.1777999826.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1777999826.git.d@ilvokhin.com>
References: <cover.1777999826.git.d@ilvokhin.com>
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
Acked-by: Usama Arif <usama.arif@linux.dev>
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

