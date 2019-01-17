From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 05/15] Add io_uring IO interface
Date: Thu, 17 Jan 2019 16:02:45 -0500
Message-ID: <x49y37j6lqi.fsf@segfault.boston.devel.redhat.com>
References: <20190116175003.17880-1-axboe@kernel.dk>
	<20190116175003.17880-6-axboe@kernel.dk>
	<718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
	<af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
	<x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
	<f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
	<02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
	<x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
	<3180aa85-68a6-0eb2-082b-f177344cefa9@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <3180aa85-68a6-0eb2-082b-f177344cefa9@kernel.dk> (Jens Axboe's
	message of "Thu, 17 Jan 2019 13:53:10 -0700")
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com, linux-block-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

>>>>>>> It seems that sq_entries, cq_entries are not limited at all.  Can nasty
>>>>>>> app consume a lot of kernel pages calling io_setup_uring() from a loop
>>>>>>> passing random entries number? (or even better: decreasing entries 
>>>>>>> number,
>>>>>>> in order to consume all pages orders with min number of loops).
...
>>> One concern here is that, at least looking at my boxes, the default
>>> setting for RLIMIT_MEMLOCK is really low. I'd hate for everyone to run
>>> into issues using io_uring just because it seems to require root,
>>> because the memlock limit is so low.
>>>
>>> That's much less of a concern with the fixed buffers, since it's a more
>>> esoteric part of it. But everyone should be able to setup a few io_uring
>>> queues and use them without having to worry about failing due to an
>>> absurdly low RLIMIT_MEMLOCK.
>>>
>>> Comments?
>> 
>> Yeah, the default is 64k here.  We should probably up that.  I'd say we
>> either tackle the ridiculously low rlimits, or I guess we just go the
>> aio route and add a sysctl.  :-\  I'll see what's involved in the
>> former.
>
> After giving it a bit of thought, let's go the rlimit route. It is cleaner,
> and I don't want a sysctl knob for this either. 64k will enable anyone to
> set up at least one decently sized ring.

OK.  Note that the MLOCK_LIMIT size has been dictated by gpg's
requirements:

commit f947ff8af30f75cb9cf0e966caf8f4809ad1b92e
Author: Rik van Riel <riel@redhat.com>
Date:   Sun Aug 22 23:06:58 2004 -0700

    [PATCH] increase per-user mlock limit default to 32k

    Since various gnupg users have indicated that gpg wants to mlock 32kB of
    memory, I created the patch below that increases the default mlock ulimit
    to 32kB.

and then

commit 0833422274ff00729a603b020fac297e69a03e40
Author: Kurt Garloff <garloff@suse.de>
Date:   Wed Oct 29 14:00:48 2008 -0700

    mm: increase the default mlock limit from 32k to 64k

...
    However, newer gpg2 needs 64k in various circumstances and otherwise
    fails miserably, see bnc#329675.

So all we need to do is modify gpg2 so that is requires more locked
memory, and we're golden!  ;-)

-Jeff

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
