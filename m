Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5133ED5A2
	for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952845; cv=none; b=VhKRXACLXixoN4rEHSgWlq1qagoJ5vgUogTgBa8nMnOrJ4Ffm/UnwM2nFnXZfdYe7Fs6td8oZ+GYTTAGkHukMboA7FqjlwI7rzh+UVFoDN19HbIdNjLCBgwz98PKirZWUZ77cMhfgIlYpQL/KVLvgrHrdFKdhwe3Uza6/IoPWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952845; c=relaxed/simple;
	bh=qzZkQ3i93l0FQlsjhTVvBhRGCZM8HqmGjGodNljUlIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNX9ko9pbIxQr0xWaOVhoIrl5jnuAQUTG8TlCjIfwB1B8QfJrBjRFUeppRlYo8E9O0q0rqHip3aRgyPHnT5nStI7CC9IdMqZjsX0Fm0MIIaqP6fw3xQUs3QKFCbc9A+2wMiOxSzY1aOljW562zOcBjEFg+us872Zz8jAeZwOC3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o7RBAi13; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o7RBAi13"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774952832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a18x6ZQjYkqeWxFtayZuE5Lz8yKC0RDpl9ExxmZO+X0=;
	b=o7RBAi13M3ymJIxeIcVVcVU7ArACtE8dCrjJjGz5z+vEZYGgF1B1ZaS7f35w+NpdDX2Unp
	f/ElyU26K/tOyOtBeLLhv7VbxMV4S/xMG+FcVulhOO1Crwahfpdetbbi4j8NsAeXAtuv9D
	TtMRPMhTEuuHOtV/fbSvHdHBJxbrGZs=
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
Subject: Re: [PATCH v4 0/5] locking: contended_release tracepoint instrumentation
Date: Tue, 31 Mar 2026 03:27:03 -0700
Message-ID: <20260331102704.921355-1-usama.arif@linux.dev>
In-Reply-To: <cover.1774536681.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu, 26 Mar 2026 15:09:59 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> The existing contention_begin/contention_end tracepoints fire on the
> waiter side. The lock holder's identity and stack can be captured at
> contention_begin time (e.g. perf lock contention --lock-owner), but
> this reflects the holder's state when a waiter arrives, not when the
> lock is actually released.
> 
> This series adds a contended_release tracepoint that fires on the
> holder side when a lock with waiters is released. This provides:
> 
> - Hold time estimation: when the holder's own acquisition was
>   contended, its contention_end (acquisition) and contended_release
>   can be correlated to measure how long the lock was held under
>   contention.
> 
> - The holder's stack at release time, which may differ from what perf lock
>   contention --lock-owner captures if the holder does significant work between
>   the waiter's arrival and the unlock.
> 
> Note: for reader/writer locks, the tracepoint fires for every reader
> releasing while a writer is waiting, not only for the last reader.
> 

Would it be better to reorder the patches? It would help with git
bisectability as well. Move the refractoring work in patch 4 and
5 (excluding adding the tracepoints ofcourse) earlier, and then add
all the tracepoints in the same commit at the end? It would help
in the future with git blame to see where all the tracepoints
were added as well.
