Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B039CD12
	for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877244; cv=none; b=KbWdRthk3PDy6m8Q1jrnXooMwXrzsPDjF5hHrffUiVvZWW3cmZtYEECO1eMHHLrhkeq+hauPh1izdOtm+36NqGlkIqN4O3lCkPjPdodE9AtjvCmFE9iuUdWh27q261Q1+ZV2Xh3HkJKwFuEeg8rjSq3uT16CIW/U5g2cRwsxi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877244; c=relaxed/simple;
	bh=BFe/yh5JnfR0DvilafSKJHlexjYInUwEeegNj8QpwgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGTA/w59xN8vFdg/O8w5q1n4VR5cqDe7TepjmmKFnLJXnwgEobdAulPbwPPLpswbM4ZjrxZBMfE2XpvqFUb5db1Qr1C8FH1T9tJTWQH5S+7yiT8N6dhN3TW/tBrMtcTspPR3945fHqQBUcEgGAEptQFYYvY2+f2tbBdAqCHk3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB9r1oE0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB9r1oE0"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8fe8e343fso5915725ad.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877242; x=1792482042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAnTgd/l711nspTx4PUavL/NLYQovTcbYgAtSFrcnZ8=;
        b=PB9r1oE0F+uyaEdAjxwxbX4pziiS8Q9gfPg+pocqeAfmAB1gGfFwAIfrWc8eBOw8/f
         MjTSi/9RaPwGbrM+s9pazj+eFgu1BxkFSwFuyjR8NF2dbm1GmoJsesAWdfwGuoIJwDrb
         axjJUb8UaQUIuO3gnbHWVRGP4sTTPWlv/6NKAatL4HvgWHRmcmbXEyIxf88lE7IpzllX
         v8zF/PfowqyugfnJqvz4isB44IAup8h/oro2fcW0ClcFK4Pmg2ONpTKdz6kZoB3v7r53
         vKA2DFm1qJzNiSOqhNWSZ415R7sIifQWCh0H0yS+0RKnAzLYLMveoZnE1WQOH87r2ktV
         JkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877242; x=1792482042;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAnTgd/l711nspTx4PUavL/NLYQovTcbYgAtSFrcnZ8=;
        b=QlFIDh90pv/nG4AozZ1CzMmSyCoGBa8TBJ8aTKRCcA58+N2aXZLBKIggntxr2yq+oN
         PqH7KBBdIc/M/KKTVD+mfuu4tWUzA1AGr/F8nZa6dWLdq3Jb0gdjv7oAJQDiBNdEHMpr
         7Vx1rYvptp1HhP67tBImubcC3B+suJNk9iOvZQjHl0PoKi2iczcYS/shbbhtIqjVUFun
         q16BXXbvh02FM1chZbT4VSxoehVYkjMSgPSETEk2gD1p4TKIjsIkj2MQ0RsHBKr3gH0M
         hstXyMfRAAuug5Csk5Hj1amAwzY5F+Hezyfz+9i8NT5zG5obEANk6j24eQdeVO2O0Qzw
         eepA==
X-Forwarded-Encrypted: i=1; AKwUvBwPoyXwuQQKI+xWOmqOEX2P0Kmh0sPTTcXBmKaOQXyeoNLQQGNWEL2hj2GVduHMOgaEgHSKwb8KwEUC@vger.kernel.org
X-Gm-Message-State: AFq9FYL73+noZqwVzMh5pbQR5wf5Y3klpbWqOa7KhFhqor9aeB6FBAb2
	uWUTu1D4r+DpmHlocdzw3/Pw29nTQI+xw37+wSVqXz2AlKiiEKMZB2t2
X-Gm-Gg: AYBFou0PyNwfJmg7SJMunWVg6vILM0qn+LUKzWJu5BoAdKks5eivCSVdLPaG4ROF4/r
	FDZ8pIC6dHIBVb5f51432yrxPhaxhYypIyJIlCVSyaI0XzOFMZ9k54fgBKnEK6Hd2lvcMkEXS0o
	bj0h6nJzgvOm1r+XcflKMod0k1QvQKgYZ/7J7CwwYXnIWrZdgokhkyesY7xikqkwqwYE6sK/GG0
	vzKdHaAHm1M2W9hMPc5A6LTyL10n3bBdMPDZfBc/5FVreuIcNXGb0JeqTJQnmkXZ8ppmtLKmooy
	Vk4hB9vc2lCadlkbo4cY6c8t9B02/3KQ23/pyERtnyVLuM3RYOHSQYgWzPRZr6pWG9Y3OXYwCp7
	/DoM6pzp+kSaDEqcGSaRwpx5U//6TF9SxJ9mQR+qHNKnvBS8+jDPwltcB7Z0bTE4VKhpK0cuXPo
	7Cy0D4+Ul2ucbPmJDmrEtR6xV68vMV4Zr/J4Wv7oJ9mo2wBoa95hJGIptgqyvfKbykko10y5MIw
	5XBFXWzeJ+yiaHnI+wLpjtT3e78TA==
X-Received: by 2002:a17:902:f64f:b0:2dd:ad73:c984 with SMTP id d9443c01a7336-2e842bc5ae0mr95318795ad.28.1791877242048;
        Tue, 13 Oct 2026 00:40:42 -0700 (PDT)
Received: from localhost ([47.254.74.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841432a03sm51700235ad.0.2026.10.13.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:40:41 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:40:36 +0800
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: paulmck@kernel.org, corbet@lwn.net, mingo@redhat.com, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, josh@joshtriplett.org, 
	urezki@gmail.com, dave@stgolabs.net, lianux.mm@gmail.com, 
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, 
	boqun@kernel.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, longman@redhat.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev, brads@mainlining.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-doc@vger.kernel.org, rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 08/15] locking/lockdep: use hazptr to wait for
 dynamic key lookups
Message-ID: <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-9-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005171529.1378809-9-kunwu.chan@gmail.com>

On Tue, Oct 06, 2026 at 01:15:22AM +0800, Kunwu Chan wrote:
> lockdep_unregister_key() waits for is_dynamic_key() callers with
> synchronize_rcu_expedited(), which requires system-wide coordination.
> Make is_dynamic_key() protect the hash bucket with a hazard pointer
> and use hazptr_synchronize() to wait for traversals of that bucket.
> 
> The hash bucket returned by keyhashentry() has a stable address, so
> it can be used as the hazptr synchronization target.  Keep the key
> hashlist lifetime RCU-based with hlist_del_rcu() and call_rcu().
> 
> Protect the traversal with the hazptr scoped_guard() added earlier
> in this series.
> 
> This adapts the lockdep use case from Boqun Feng's shazptr series
> to the current hazptr API.
> 
> Link: https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/

Hello,

I think this is a misuse of hazard pointers.

The bucket has a permanent, static address; its lifetime does not
need hazard-pointer protection. Instead, this patch combines a
hazard pointer with that address to construct a read-side/synchronize
mechanism in the same category as RCU. However, this construction
lacks the generation distinction needed to separate pre-existing
readers from subsequent readers.

The object being removed is the key, but the synchronization target
is the bucket. Unlinking the key does not prevent new lookups from
acquiring the same bucket address, including lookups for unrelated
keys that hash to that bucket.

This breaks the forward-progress argument used by the underlying
hazptr implementation: after removing an object from publication,
there should not be a continuing stream of new readers acquiring
that same object. Here, the bucket is never unpublished.

For example, let B be the bucket containing key K:

  Updater                    Reader                 Scan kthread
  -------                    ------                 ------------
  Unlink K from B
  hazptr_synchronize(B)
                             Acquire B
                                                    Observe B;
                                                    retain waiter
                             Release B
                             Acquire B again
                                                    Observe B;
                                                    retain waiter
                             Release B
                             ...                    ...

Every reader critical section can finish, and the scan kthread
can keep running, while the updater waits indefinitely. Readers
that could have observed K may already have completed; later
lookups alone can keep the waiter pending.

RCU does not need the reader population to become empty. Its
generation (grace-period) machinery allows pre-existing readers to
drain without letting a continuous stream of subsequent readers
indefinitely extend that wait. This address-based construction has
no equivalent distinction.

So this is not merely protecting a different object with hazptr:
it is using hazptr as a different synchronization primitive without
providing the corresponding progress guarantee.

I think we should retain the RCU wait here. If the intention is to
implement bucket-scoped read-side synchronization, that needs an
explicit protocol to distinguish the readers being drained from
new arrivals; a permanent bucket address is not sufficient.

Sorry for the lengthy reply, which was written with the help of an AI
agent. I noticed this issue when this use case was first proposed, but
I struggled to articulate my concerns clearly back then. Well, now we
have AI. :)

Thanks
Lai

> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/locking/lockdep.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c56a7f91d72e..d1ce5ace7fbf 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -58,6 +58,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/console.h>
>  #include <linux/kasan.h>
> +#include <linux/hazptr.h>
>  
>  #include <asm/sections.h>
>  
> @@ -1280,14 +1281,19 @@ static bool is_dynamic_key(const struct lock_class_key *key)
>  
>  	hash_head = keyhashentry(key);
>  
> -	rcu_read_lock();
> -	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> -		if (k == key) {
> -			found = true;
> -			break;
> +	{
> +		struct hazptr_ctx ctx;
> +		void *bucket = hash_head;
> +
> +		scoped_guard(hazptr, &ctx, &bucket) {
> +			hlist_for_each_entry_rcu(k, hash_head, hash_entry, 1) {
> +				if (k == key) {
> +					found = true;
> +					break;
> +				}
> +			}
>  		}
>  	}
> -	rcu_read_unlock();
>  
>  	return found;
>  }
> @@ -6683,11 +6689,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
>  	 *
>  	 * Some operations like __qdisc_destroy() will call this in a debug
>  	 * kernel, and the network traffic is disabled while waiting, hence
> -	 * the delay of the wait matters in debugging cases. Currently use a
> -	 * synchronize_rcu_expedited() to speed up the wait at the cost of
> -	 * system IPIs. TODO: Replace RCU with hazptr for this.
> +	 * the delay of the wait matters in debugging cases. Replace the
> +	 * expedited RCU wait with hazptr_synchronize().
>  	 */
> -	synchronize_rcu_expedited();
> +	hazptr_synchronize(keyhashentry(key));
>  }
>  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
>  
> -- 
> 2.43.0
> 
