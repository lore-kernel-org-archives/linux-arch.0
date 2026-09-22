Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575B3A48CA;
	Tue, 22 Sep 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067114; cv=none; b=LLYTu/eLPh0OYuEZRQsaXMoLT6va2cEOSs8/W1NOBHDB9guj/MfpTG+vdYbqa9XbgJlhjOOr5T//mvg2iI7lGtINg19IIL+ta3lpNDz3nlClVQ9vx/Qx+pOqntM4kl2yfCYZegxoeNvtCHzSaXUvXm6mERlDTVPSxu9V7QK/1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067114; c=relaxed/simple;
	bh=2Z5Qn60EBb1PnLpPsZn1SPhgCYhV7AGPoEY5wZRgjYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0WakB9ziIQa7M17hMuaLac4wK/UtSYjWFmmnyWav/VfR9TTbu0Tpm2LaAxUw7Xd3MTxZisGYD5r8m7ckzSGeN+RdGTeVKcahjSwduAcgkUTzNM7vSmY0rms6X0tqbmADIt3AMGvO2k6tXDzH5Vo8Lbw4iedVBFxBVZCvTy061Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdcLAl51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdcLAl51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEE31F00893;
	Tue, 22 Sep 2026 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067113;
	bh=Rf220kPvSZHePWxrXLumbg4sIvzSq9oPJ6+CYXZV+kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XdcLAl51aiz2SylXTI5hWZZAQthNeoq5unimYj1AMy+A6wcDNJLR/yhhqd2P50le5
	 g+QLBEIjrexb7LKGlV/AruixWiNNr+hKtbBh7o26bzX6fTL7Q1u43oYWhp0qrfaZ3J
	 W4VC89o2DT2T/DlDuFVwIRClaaKkv6KpNIeqSYnOi6Lww569WamdSBq4ieL2PHXqXO
	 rSioNdS+i2JTxBHJBFiWLQYPhAHb9rbDx9JjjAxyeQZM5u+gU9yrBVnmuZFr6JzH8D
	 Eklaqqm3CBIWFoVVs0Jt36CEtGzyX9CBn//WmdrO4WBlrlOIQhOV7tp5urEWvfNMLH
	 B/31AssNu54Eg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6AF62F40066;
	Tue, 22 Sep 2026 04:51:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 22 Sep 2026 04:51:51 -0400
X-ME-Sender: <xms:p0GyallCIJ245yua978p68HSdMpENIh5TPbVfd2MoRD4cY87cXh4vg>
    <xme:p0GyanqbhN4H1_Yl9w6MKcrGGUJbCPLXBftJ7w90BduMbHSviNnuTxLS48-O89jeW
    1-0wfiOvWfdE_7D6yRh2fj9O5qLDLsIMP09dsURWUytZJp58xjRKA>
X-ME-Received: <xmr:p0GyakllK-AKhk0O7c9iGw4_dmJ2PmLMJnoTIOBwf9F99t_Eh3lmTMPTdpnIbSvlEPkZ7OWEHup5C5NIeL4I1rMOyxyzdPrkJGN-Sk49YJqSMxq3ecVSeXaa>
X-ME-Proxy-Cause: dmFkZTEy36KmC5z4mpGoh+ErYZsOWD36SPeiGtyIfXZzW33o1dun4y/KdVBmMRSlhAXBIC
    MsPpfyHDf4nuPxptFgu9Y8O7f+lHMGV33upldO6ejgKpDORUtbLS4jZ9TxFLdGEhSskNdh
    31JTNaS5eYfbZA8V5oNXxXU0Uswv/eqJAhy3YHj5FLwE76vQLSmLL5lpPb9niaxvJBxQFM
    Zk0Y36KK135SVAHo0J6iIlNRKatzbdORnIPB6tgdaVzv606Ufa1xsD4U/KQTAXrU6/3O53
    7S7hajYvAtweWv8iLUY9XKzwivWkyZ5liKtKtDyr0qFrSRtDb//2hnSIgysFO3fnNPluiX
    ng7LS8vOL4mVzGd3AH8mqcYXGPZX5h2XInrGbDCuu5K3XR6QMwtgtSoX4u+wfkhTdKf0Cm
    XlyWt6aVO9jlDH7K4oHQPd7Sd1/xyen65RwC9c3TZa/2sOwrG2qLQG3MbmPrWs/F5WhqoN
    LmV6zmQFOx3VRm7ivI14DSg3lEOTFghBcVvAu7LU4vekPAd8rGamaT/u3XTKVlmqzFJI62
    Y4ncMUx9YfMmaTYcuupDSEW93QJdaoc+lzYxbE4wnHIi3OCie0+f6lXnF9vTSVKLugO/8H
    HHGkEMjbqGLooP3tBy72emz5FZnYsaeiH1W6lYxV2OgHukFsEoOOxVnOZ0Yg
X-ME-Proxy: <xmx:p0GyaoaBxzRD8nC1j0Z65NG67pGEoCg4xtA_ydAzU44860hqcPVlpw>
    <xmx:p0GyaoENiXKtHslCfa4oPWhTrMZs-3JQQKB5re090vwsWNq8c0dUog>
    <xmx:p0GyajMOV5oX6N1hpD8JLlc_IM76rie_RhtUCXxgfbRBSsClSm5hHA>
    <xmx:p0Gyamwal0lyR6aHFMlS3Lq_QYi-Ctrbu6_3aIFKemyHYNunBGHFLw>
    <xmx:p0GyaomQDK6YGp85hzl7Fs_2E-_gaZnS58KJNdh8kUFg0qFAAeXn9Ter>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 04:51:50 -0400 (EDT)
Date: Tue, 22 Sep 2026 10:51:49 +0200
From: Boqun Feng <boqun@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
	corbet@lwn.net, mingo@redhat.com, dave@stgolabs.net,
	josh@joshtriplett.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, urezki@gmail.com, akiyks@gmail.com,
	dlustig@nvidia.com, joelagnelf@nvidia.com,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	longman@redhat.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, include@grrlz.net,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, linux-doc@vger.kernel.org,
	rcu@vger.kernel.org, lianux.mm@gmail.com
Subject: Re: [RFC/WIP PATCH 2/4] locking/lockdep: use hazptr to wait for
 dynamic key lookups
Message-ID: <arJBpQyOQf3AJ4cA@MacBook-0RXW5>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
 <20260922070950.4173245-3-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922070950.4173245-3-kunwu.chan@gmail.com>

On Tue, Sep 22, 2026 at 03:09:48PM +0800, Kunwu Chan wrote:
> lockdep_unregister_key() waits for is_dynamic_key() callers with
> synchronize_rcu_expedited(), which sends IPIs to every online CPU.
> Have is_dynamic_key() mark the hash bucket with a hazard pointer
> and use hazptr_synchronize() to wait specifically for those
> traversals.
> 
> The hash bucket address from keyhashentry() is stable, making it a
> suitable hazptr synchronize target.  The rest of the key hashlist
> lifetime (hlist_del_rcu/call_rcu) remains RCU-based.
> 
> This adapts the lockdep use case from Boqun Feng's hazard-pointer
> series to the current hazptr API.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/locking/lockdep.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c56a7f91d72e..f67d847f9abf 100644
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
> @@ -1280,14 +1281,24 @@ static bool is_dynamic_key(const struct lock_class_key *key)
>  
>  	hash_head = keyhashentry(key);
>  
> -	rcu_read_lock();
> -	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> -		if (k == key) {
> -			found = true;
> -			break;
> +	/*
> +	 * The traversal is protected by a hazard pointer rather
> +	 * than an RCU read-side critical section.
> +	 */
> +	{
> +		struct hazptr_ctx ctx;
> +		void *bucket = hash_head;
> +		void *addr;
> +
> +		addr = hazptr_acquire(&ctx, &bucket);
> +		hlist_for_each_entry_rcu(k, hash_head, hash_entry, 1) {
> +			if (k == key) {
> +				found = true;
> +				break;
> +			}
>  		}
> +		hazptr_release(&ctx, addr);

This looks good to me. However, we probably want to use scoped_guard()
here, that means cleanup.h support for hazptr.

The other thing that could be added is a debug option that force we
skip the fast path, so we always go into the show path in
hazptr_acquire(). This occurs to me because the slow path here means
acquiring a lock inside lockdep code, it should work, but I just want to
be careful. So something like:

	void *hazptr_acquire(..)
	{
		...
		if (IS_ENABLED(CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH) ||
		    unlikely(slot->addr))
			return __hazptr_acquire(ctx, addr_p);
		...
	}

Thoughts?

Regards,
Boqun

>  	}
> -	rcu_read_unlock();
>  
>  	return found;
>  }
> @@ -6683,11 +6694,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
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
