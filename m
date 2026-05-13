Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AA7481FCE;
	Wed, 13 May 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686993; cv=none; b=Nk1MW4Q18O+bWJeL81VGzBMKmZR79AwzZIfh+A953P4LCvIx1vr+85wzNy1pk/1nIdNlqSc1CEc31B2gT/MUeu8uToLADg7zMeKdfQyfED/wZevYmZQpLG2Ge6IRFZPzXG22Wek+7O0FRCUCsJckWnIgDEHHQ+gQSg/RZaxlNwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686993; c=relaxed/simple;
	bh=gkRQjgXAOUtsQDsoJPrjl1J5lhzGoe8KMasfHcOGNSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCRUhdkyURqNFGwY1/4W2Y9jeM9G9B9dv5bnNftlOD84VMTEY5IIVYeLlzsaY55hLOXnY8qIWaUDnyTxF7jbUdOLMxej3QgMYSnk7uahNTWxs4NOFqaWxh0oSBX68qSVGYN9BVobVSEDEgvuMEba3ttVWLYWIJHRniNgkGRd4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 49B49C0439;
	Wed, 13 May 2026 15:43:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id AF64F8000F;
	Wed, 13 May 2026 15:43:02 +0000 (UTC)
Date: Wed, 13 May 2026 11:43:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner
 <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 7/7] locking: Add contended_release tracepoint to
 qrwlock
Message-ID: <20260513114305.21ffc98f@gandalf.local.home>
In-Reply-To: <b67fda8e847fff72da05eff7f799019f8d17ce21.1777999826.git.d@ilvokhin.com>
References: <cover.1777999826.git.d@ilvokhin.com>
	<b67fda8e847fff72da05eff7f799019f8d17ce21.1777999826.git.d@ilvokhin.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF64F8000F
X-Rspamd-Server: rspamout06
X-Stat-Signature: w86rrez7eqwjzfhgqoxgq67qhkb7x9up
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ry8RzWesZfFcKD7J3lfQK7el56ZbsoNM=
X-HE-Tag: 1778686982-257566
X-HE-Meta: U2FsdGVkX191OTt5Ksd6rUOT63By4bRHO3knmbxlImxeNwSRm6MiHtOjFX4vJPI7crm7BSyrSIbvYT2WqOIcyORlXBEY2Q745H1gRnZgzxFxnZc2Bi+ODYvQqGyzbt0gxBvY2ORVu7Y4GQ21a4wpv6/a90k23BYL7etn+PwAjOo5gxJiydIgCFloW6Mpqm0UrvbWwABEN81N7oFp14CVTY728nkwzhqSyPCqbUhdm6Gp7kGkEzhfOsmKyTBnoEo7WZmXFfbv5M1ZAKLN8diVSXcT2j7/QCb3HvSSmT0BmXISJ4AvPIW0Eh8Dhn0nmq6iowz0POq6263XgbEXZQ9JarrVBkMeNNzrxBaehT1mK01cf9rA6EvFjUu8THAnEVExi+n7p8EX5+Ja1SfaAhM8P576YgkfJW2f

On Tue,  5 May 2026 17:09:36 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Extend the contended_release tracepoint to queued rwlocks, using the
> same out-of-line traced unlock approach as queued spinlocks.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  include/asm-generic/qrwlock.h | 22 ++++++++++++++++++++++
>  kernel/locking/qrwlock.c      | 16 ++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index 4b627bafba8b..274c19006125 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -14,6 +14,7 @@
>  #define __ASM_GENERIC_QRWLOCK_H
>  
>  #include <linux/atomic.h>
> +#include <linux/tracepoint-defs.h>
>  #include <asm/barrier.h>
>  #include <asm/processor.h>
>  
> @@ -35,6 +36,10 @@
>   */
>  extern void queued_read_lock_slowpath(struct qrwlock *lock);
>  extern void queued_write_lock_slowpath(struct qrwlock *lock);
> +extern void queued_read_unlock_traced(struct qrwlock *lock);
> +extern void queued_write_unlock_traced(struct qrwlock *lock);
> +
> +DECLARE_TRACEPOINT(contended_release);
>  
>  /**
>   * queued_read_trylock - try to acquire read lock of a queued rwlock
> @@ -115,6 +120,17 @@ static __always_inline void __queued_read_unlock(struct qrwlock *lock)
>   */
>  static inline void queued_read_unlock(struct qrwlock *lock)
>  {
> +	/*
> +	 * Trace and unlock are combined in the traced unlock variant so
> +	 * the compiler does not need to preserve the lock pointer across
> +	 * the function call, avoiding callee-saved register save/restore
> +	 * on the hot path.
> +	 */
> +	if (tracepoint_enabled(contended_release)) {
> +		queued_read_unlock_traced(lock);

Same issue here about duplicating the code.
> +		return;
> +	}
> +
>  	__queued_read_unlock(lock);
>  }
>  
> @@ -129,6 +145,12 @@ static __always_inline void __queued_write_unlock(struct qrwlock *lock)
>   */
>  static inline void queued_write_unlock(struct qrwlock *lock)
>  {
> +	/* See comment in queued_read_unlock(). */
> +	if (tracepoint_enabled(contended_release)) {
> +		queued_write_unlock_traced(lock);

And here.

> +		return;
> +	}
> +
>  	__queued_write_unlock(lock);
>  }
>  
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index d2ef312a8611..5ae4b0372719 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -90,3 +90,19 @@ void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
>  	trace_contention_end(lock, 0);
>  }
>  EXPORT_SYMBOL(queued_write_lock_slowpath);
> +
> +void __lockfunc queued_read_unlock_traced(struct qrwlock *lock)
> +{
> +	if (queued_rwlock_is_contended(lock))
> +		trace_call__contended_release(lock);

Just have this trace and not actually do any locking.


> +	__queued_read_unlock(lock);
> +}
> +EXPORT_SYMBOL(queued_read_unlock_traced);
> +
> +void __lockfunc queued_write_unlock_traced(struct qrwlock *lock)
> +{
> +	if (queued_rwlock_is_contended(lock))
> +		trace_call__contended_release(lock);

Ditto.

-- Steve

> +	__queued_write_unlock(lock);
> +}
> +EXPORT_SYMBOL(queued_write_unlock_traced);

