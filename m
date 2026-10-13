Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C94EDCB6;
	Tue, 13 Oct 2026 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895717; cv=none; b=WWfph1OCV6eBeIaL9IvNlxpNGIzUy5gaxilf6nk4y4MBAbTrlcIZycxSGxDLUea4JfojnHVnnQWbnxNsDBNEQkCW3Rkhy3YbBejQ1/h1PauLgg7KpitP0Emg8FfK6ngz3uZ0g2Kg4owCV5zDP5OIFRmM4yOT4zMmpcbFGgYzWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895717; c=relaxed/simple;
	bh=oLV5bYYNqBJtMZGXHUGsTftA7iDmuDBBkFIsyHgIRQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz0c580CDkET0vBu6MPJUzSuAeLH67Qzcgoc1aUVRuBCJFYNKsQDvtzgPog+Um/nORlJhSz6KMWYHQexI8En+Wvg+OHzuv17Jku+Tb+N5rxdCC8nnsI4dHC/gGxT4O6YwZz0+2Xj3hJb5LiahAzLmvYR17MAVevw7MFub108+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVJKB8nF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVJKB8nF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C637C1F00898;
	Tue, 13 Oct 2026 12:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791895716;
	bh=2qRTik8GEJlB5ZX27jmNcmkZ0CNCqqj8RXCnZ4IaHcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HVJKB8nFkpi6FfFe/2bi2zD3HlhDsozNY2PglvxvzD7dm1d4Hm5s1sDN/4WmA89TY
	 jHBxUmQTodmQ4g9Jg3CbR4AMT3KsPTI6k4C3ZbGkETtiTsBnR2BKeY72/1B8M1D+8E
	 uba5I960S7/G22K37RPOeRe0Gwq3R80VWKoFRtlfBNllbEoavCmifEiWPx2E6kek8J
	 JtBu7yLrpbCAoN+dRqSutEjuNly4KDBq4eLpJ294wA9IEbBE6x3hI8o+Bgtvbf7C2u
	 WdczuVSlVfL/tnE3kU9QBQ9LwzVQxzw+Wba7HU2H21atFFddfZcU8S3FCC9gzT+hdu
	 EpQ588+8qVlCA==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id F1ED7F40066;
	Tue, 13 Oct 2026 08:48:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 13 Oct 2026 08:48:35 -0400
X-ME-Sender: <xms:oijOap3TVDTu_5loFwQITlOvPLzbraJWkFzOCWyfQgb48rJo-r7QYg>
    <xme:oijOaum8Wfcu9NIcX6AjBRt__ZHoNQzdixAWaBWgXtg1LC8artULg7Xt9Hotvxh6f
    Shdf9RTbFZVsDcl0gr9LdjLKsw0FP5Z-ADaAbAz8hZ0v68l2HjaxQs>
X-ME-Received: <xmr:oijOagH-q8HxOINcCSKZuke0U5pH_vthi8BfKQ5itL2EYBKYmg4RDSmNUTd9NBx-gYa0GBIoMZNOVnm59r8w-U1ySgtwHlrn>
X-ME-Proxy-Cause: dmFkZTFQxdGgm5pu/Hef3mE4+Kt1axzL/LFmUKKZM328NfNKX0+Hk7CGHW2ienRh+lcJSJ
    anCeCNA7AVlmc/k8szEtMpKqX69BnxAKeoFVjMHhlIPDHwzw6ovgIdaFyB075ymGgnmUxR
    d54mIW7HjTLxZmNJIZu1La4d0E0VptVQRvnYfuriOsH9x+ampWVmieO1VtE4MHK1lp6Enb
    opHjOy6C3TlADcdSv+ErnoefUAzrGdeIWJhnn8kDxbBCohNDuuEUVL3iYOcD7SWynkGTFS
    Q5s4JcNHCHFe7cI5vZNxIQkRdEkeWPkuJPlkPt/ObAHoNFc2ZvNbCvLVijadlm5Jp3riGp
    yMsHABJ/EcTP8wxw/AY8RC1KgFWI+nNfldg7Y2lI922CCWMorY/XDbPh+69RxUxpMHYUnf
    5w8g63heNx2UD3uaJi26gzBvf3JMWZgmaVIWuLssF/Y0xKVqvh2hA2t1dFOy/J4FF8vQVv
    kuE+Jp4TBEWl6vVkAwbEYcwjNMI7U//cljEEVqDjNtPk/DCkl4MaqyzOguM+gXC8CQZ989
    1j1Ad9gAFbOJaU21u4Ls3TeeObv3Iac8dT2uFMHPjDiVB4hDfAFuq9dC72PtV8Fhbkm/TR
    bTeCXbde8KuNUbL99FqskIh3zHbj2HYNsjWGFdfIdYqzosw7UeGQ8pSMwQug
X-ME-Proxy: <xmx:oijOarm4oADCkeAwvjq-oRVoylma9xhvuXoj9zDW6YV6LlaWR8NFIg>
    <xmx:oijOaqP7L4GnYrNJIPJtMZ8Vg4RczEkoN8uyeKOotVOoA9TSpMH35g>
    <xmx:oijOarCcd54Ji8lroj-YhRWLccy_K7-R01auKkyl5x6lsNT9tKxXng>
    <xmx:oijOarUeX3VNU0L5MDHIuQ3Fgx_I2DjXFPkunLZSqQ8PD_kYY7mnvw>
    <xmx:oijOalacm7m2zjhHfow_OYEG_MK8MTH4G2NWmxaLs7nBt93I6h6yxKLB>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 08:48:34 -0400 (EDT)
Date: Tue, 13 Oct 2026 05:48:33 -0700
From: Boqun Feng <boqun@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>, paulmck@kernel.org, corbet@lwn.net,
	mingo@redhat.com, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org, urezki@gmail.com, dave@stgolabs.net,
	lianux.mm@gmail.com, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
	joelagnelf@nvidia.com, skhan@linuxfoundation.org,
	rdunlap@infradead.org, longman@redhat.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, qiang.zhang@linux.dev,
	brads@mainlining.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 08/15] locking/lockdep: use hazptr to wait for
 dynamic key lookups
Message-ID: <as4ooZSWA2lAIceu@tardis.local>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-9-kunwu.chan@gmail.com>
 <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>

On Tue, Oct 13, 2026 at 03:40:36PM +0800, Lai Jiangshan wrote:
> On Tue, Oct 06, 2026 at 01:15:22AM +0800, Kunwu Chan wrote:
> > lockdep_unregister_key() waits for is_dynamic_key() callers with
> > synchronize_rcu_expedited(), which requires system-wide coordination.
> > Make is_dynamic_key() protect the hash bucket with a hazard pointer
> > and use hazptr_synchronize() to wait for traversals of that bucket.
> > 
> > The hash bucket returned by keyhashentry() has a stable address, so
> > it can be used as the hazptr synchronization target.  Keep the key
> > hashlist lifetime RCU-based with hlist_del_rcu() and call_rcu().
> > 
> > Protect the traversal with the hazptr scoped_guard() added earlier
> > in this series.
> > 
> > This adapts the lockdep use case from Boqun Feng's shazptr series
> > to the current hazptr API.
> > 
> > Link: https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/
> 
> Hello,
> 
> I think this is a misuse of hazard pointers.
> 

I disagree.

Is this usage a typical hazard pointer usage, maybe not. But it's a
valid usage IMO.

> The bucket has a permanent, static address; its lifetime does not
> need hazard-pointer protection. Instead, this patch combines a
> hazard pointer with that address to construct a read-side/synchronize
> mechanism in the same category as RCU. However, this construction
> lacks the generation distinction needed to separate pre-existing
> readers from subsequent readers.
> 

The "power" of hazard pointer allows you to use it protect almost
anything, it happens to be the pointer of the object to free in the
major use cases, but as long as readers and updaters use some address in
their synchronization protocol, it's fine, because the synchronization
works.

> The object being removed is the key, but the synchronization target
> is the bucket. Unlinking the key does not prevent new lookups from
> acquiring the same bucket address, including lookups for unrelated
> keys that hash to that bucket.
> 
> This breaks the forward-progress argument used by the underlying
> hazptr implementation: after removing an object from publication,
> there should not be a continuing stream of new readers acquiring
> that same object. Here, the bucket is never unpublished.
> 
> For example, let B be the bucket containing key K:
> 
>   Updater                    Reader                 Scan kthread
>   -------                    ------                 ------------
>   Unlink K from B
>   hazptr_synchronize(B)
>                              Acquire B
>                                                     Observe B;
>                                                     retain waiter
>                              Release B
>                              Acquire B again
>                                                     Observe B;
>                                                     retain waiter
>                              Release B
>                              ...                    ...
> 

This is more of an implementation issue, and luckily the readers in
lockdep are less frequent, so we don't have this issue at the moment.
Even if we do, there are pretty ways we can duel with it. E.g. the scan
thread can identify a "sticky" address like B, and publish it to all the
readers, so they will notify the scan thread when they finish release
it:

	hazptr_release():
	  if (steady_address != NULL && steady_address == *slot)
	    notify_scan_thread();
	  smp_store_release(slot, NULL);

in this way, scan kthread will be able to track down each reader of the
steady address (with a bitmap or something), and make the necessary
forward progress if the updater waits for too long.

And more importantly, even without this, the constant stream of readers
of B can only block a hazptr_synchronize(B), but not a
hazptr_synchronize(C), that's exactly the point of hazptr: readers don't
block the hazptr_synchronize() on other addresses.

> Every reader critical section can finish, and the scan kthread
> can keep running, while the updater waits indefinitely. Readers
> that could have observed K may already have completed; later
> lookups alone can keep the waiter pending.
> 
> RCU does not need the reader population to become empty. Its
> generation (grace-period) machinery allows pre-existing readers to
> drain without letting a continuous stream of subsequent readers
> indefinitely extend that wait. This address-based construction has
> no equivalent distinction.
> 

It can be added as a slowpath as I mentioned above, surely it comes with
a cost, but it makes the API usage simpler: you can use hazptr to
protect something that is about to free and you can also use it to
protect something that your readers and updaters have agreed on an value
for synchronization.

> So this is not merely protecting a different object with hazptr:
> it is using hazptr as a different synchronization primitive without
> providing the corresponding progress guarantee.
> 

To me it's still the same, mainly because how readers protect something.

> I think we should retain the RCU wait here. If the intention is to

Nope. synchronize_rcu() is too slow according to Breno's usage, and
synchronize_rcu_expedited() is way more IPI. Hope you got the conclusion
from AI, because it may lack some context here.


Don't make me wrong, if the main argument is "hey this is not a typical
hazptr usage, so we need more proper usages to upstream hazptr", then I
agree. It's just in a world where hazptr is in the kernel, such a
non-typical usage should be supported.

> implement bucket-scoped read-side synchronization, that needs an
> explicit protocol to distinguish the readers being drained from
> new arrivals; a permanent bucket address is not sufficient.
> 
> Sorry for the lengthy reply, which was written with the help of an AI
> agent. I noticed this issue when this use case was first proposed, but
> I struggled to articulate my concerns clearly back then. Well, now we
> have AI. :)
> 

Thank for sharing the concern, it's valuable. If you or the AI have a
proper hazptr usage in kernel, that'll be great!

Regards,
Boqun

> Thanks
> Lai
> 
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/locking/lockdep.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index c56a7f91d72e..d1ce5ace7fbf 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -58,6 +58,7 @@
> >  #include <linux/context_tracking.h>
> >  #include <linux/console.h>
> >  #include <linux/kasan.h>
> > +#include <linux/hazptr.h>
> >  
> >  #include <asm/sections.h>
> >  
> > @@ -1280,14 +1281,19 @@ static bool is_dynamic_key(const struct lock_class_key *key)
> >  
> >  	hash_head = keyhashentry(key);
> >  
> > -	rcu_read_lock();
> > -	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > -		if (k == key) {
> > -			found = true;
> > -			break;
> > +	{
> > +		struct hazptr_ctx ctx;
> > +		void *bucket = hash_head;
> > +
> > +		scoped_guard(hazptr, &ctx, &bucket) {
> > +			hlist_for_each_entry_rcu(k, hash_head, hash_entry, 1) {
> > +				if (k == key) {
> > +					found = true;
> > +					break;
> > +				}
> > +			}
> >  		}
> >  	}
> > -	rcu_read_unlock();
> >  
> >  	return found;
> >  }
> > @@ -6683,11 +6689,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
> >  	 *
> >  	 * Some operations like __qdisc_destroy() will call this in a debug
> >  	 * kernel, and the network traffic is disabled while waiting, hence
> > -	 * the delay of the wait matters in debugging cases. Currently use a
> > -	 * synchronize_rcu_expedited() to speed up the wait at the cost of
> > -	 * system IPIs. TODO: Replace RCU with hazptr for this.
> > +	 * the delay of the wait matters in debugging cases. Replace the
> > +	 * expedited RCU wait with hazptr_synchronize().
> >  	 */
> > -	synchronize_rcu_expedited();
> > +	hazptr_synchronize(keyhashentry(key));
> >  }
> >  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
> >  
> > -- 
> > 2.43.0
> > 
