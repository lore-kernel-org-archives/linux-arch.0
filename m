Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34503A4F22
	for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951921; cv=none; b=fpcjatCiTkiKo+oaJTWiJIEN30G/PJidSBbP15oHsYjNE9ytlPdrUUl7M34qrL19pyL6VvzmH7ndOHt3yDDYiTulT0b0vVASspkqDp1EmPoEzmbjE8stzsEMb7Kzg3ufV7S8AZr6kVv8L4kXxcRR94QMyEiKcdojdnRvs3aLfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951921; c=relaxed/simple;
	bh=HHo+6RORxqzwkw1Oh/DBYbRN33EnFnNxrGcTNZrX4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2i3/kAj6XnIkHmf5Zv/7wHxnPKKww7s67BEQPLBC5RWlxQVq3bMz3iei4WYO8mqtJ4eGr8sn782m0Mfc0jg+NkLMCoQA4jbjsImeGYu2wxkXEwpYta1OqvYbwc8QFDHpr0TBHl7NThcD9/2hmh+tQ4p5kl+0TkqMBcCIYiyWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZV77eGoB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZV77eGoB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774951907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/KT1XoeoGhxQZGd0moPT/YeBL0YVj4iz/EMh/8Na9M=;
	b=ZV77eGoBYxkTQ01Z1xvT+NwWiLOnJG01ICF7R8IEluW7BoQaYyfRsHnF4bxuJdehzxdj8i
	m5gLxZ96FaWK0TlLmANrVzEeuUXgeDwIUAYiYJMSXgUyIuQtaXpJnCSPnF9/D0yIb0gnxj
	f7KmNc4JXej6hhm5RiNUBa77Va9m+5E=
From: Usama Arif <usama.arif@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 1/5] tracing/lock: Remove unnecessary linux/sched.h include
Date: Tue, 31 Mar 2026 03:11:32 -0700
Message-ID: <20260331101134.643490-1-usama.arif@linux.dev>
In-Reply-To: <5593ed9718b1a6e4ec51d99772c485734029d4d4.1774536681.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 26 Mar 2026 15:10:00 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> None of the trace events in lock.h reference anything from
> linux/sched.h. Remove the unnecessary include.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  include/trace/events/lock.h | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Usama Arif <usama.arif@linux.dev>
