Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8F3AC00;
	Sun, 22 Mar 2026 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138204; cv=none; b=b8QPUcpHYdOfwUz9AyuA8Ytk03PJODvccRfFh9MTjCoXhoJK2GgPTgdL/GNvd5QUcsDpWSLwlF06XXfDT9VAht2MY+6yd4mX8zmR4IJcCPcX787cbs4/9+jbWmuwcJPqfQ5VyBCyMWiGaP7rh9chOQPD7H9j3BEh/WB5DlQeddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138204; c=relaxed/simple;
	bh=hgkUMA+D2Qwkwv9VIl4EeqfKEgsJF8OR3J/kh9YjtY4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IbkKeJFLOj3M6gIHCb3KRhXIRhHRe/JOtHKkMVt9CeDT2rUnwUbKVbDU03XfiHphocjd+4YhZ2g6x5aoLwl75wxj5xdXVndvoQx279Ie02Jin0tK5n3F0VdxI4PWc8OFi7YgYG8UQPkYy7ivsXV3o+JNMaLBIVflSa1Beb1M7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0odt9qsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0odt9qsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F32C2BC9E;
	Sun, 22 Mar 2026 00:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774138203;
	bh=hgkUMA+D2Qwkwv9VIl4EeqfKEgsJF8OR3J/kh9YjtY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0odt9qskdT0KVfFDu2lB1AstQjY0/yTp3t9erG637/acag9gjkBcAroCrGjXaphX4
	 yCeeiCY1laOyYchoh7XQ+nX/Tx1bbYVIk8osY5vBFqLTx41EfQ8bOyKTCTZTWtrRB9
	 HJ6WYRiqeB41Cr1Bmaug0k9DGtIfhba8wy+dVbww=
Date: Sat, 21 Mar 2026 17:10:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>, Tejun
 Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 0/4] locking: contended_release tracepoint
 instrumentation
Message-Id: <20260321171002.013ee5a9d8c789e2a4a53afc@linux-foundation.org>
In-Reply-To: <cover.1773858853.git.d@ilvokhin.com>
References: <cover.1773858853.git.d@ilvokhin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 18:45:17 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

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
> The series is structured as follows:
> 
> 1. Remove unnecessary linux/sched.h include from trace/events/lock.h.
> 2. Extract __percpu_up_read() out of the inline percpu_up_read() to
>    avoid binary size increase from adding a tracepoint.
> 3. Add contended_release tracepoint and instrument sleepable locks:
>    mutex, rtmutex, semaphore, rwsem, percpu-rwsem, and rwbase_rt.

AI review:
	https://sashiko.dev/#/patchset/cover.1773858853.git.d@ilvokhin.com
