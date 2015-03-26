Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:34534 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbCZTMe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2015 15:12:34 -0400
Received: by lagg8 with SMTP id g8so53572251lag.1
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2015 12:12:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150326115514.GA12329@infradead.org>
References: <cover.1426528417.git.milosz@adfin.com>
	<20150326115514.GA12329@infradead.org>
Date: Thu, 26 Mar 2015 15:12:32 -0400
Message-ID: <CANP1eJGpgXUv626KQb6kduJgMaOzU5hH9GLGBM-QSVUBagoG8w@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] vfs: Non-blockling buffered fs read (page cache only)
From: Milosz Tanski <milosz@adfin.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, Linux API <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150326191232.LLyaPb519VeolhFaYWcUPpHu369VvtsB5C5hvLNyhQY@z>

On Thu, Mar 26, 2015 at 7:55 AM, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 16, 2015 at 02:27:10PM -0400, Milosz Tanski wrote:
> > This patchset introduces two new syscalls preadv2 and pwritev2. They are the
> > same syscalls as preadv and pwrite but with a flag argument. Additionally,
> > preadv2 implements an extra RWF_NONBLOCK flag.
>
> There was some arugment that we just don't wait and don't have the
> classic unix "blocking" semantics.  Maybe it's time to bite the bullet
> and rename it to RWF_DONTWAIT? (I personally dont really care).


Sure. It is in line with the MSG_DONTWAIT flag for sendmsg() which
this whole idea is based on anyways.

>
>
> Second this probably needs to be on top of Al's for-next tree:
>
>         https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git/log/?h=for-next
>
> Note that this has a flags field in struct kiocb, so we could just use
> that for the flags.


Okay I started rebasing the patches on-top of that. I did see that
there is a new flags field "ki_flags". I see that there's already a
IOCB_EVENTFD flag.

Did you see you Andres' question about making the flags a enum? I
usually wouldn't do that, because C++ is stronger when it comes enums,
you can't combine them then assignment them to an enum without a cast.
But in the kernel this doesn't matter.

>
>
> Otherwise this version look fine to me, let's get it merged!
>
> Al, are yo ready to pick this up?  I'd hate to miss another merge
> window.


Just got back from vacation today, I'll try to get this out before the
end of the week. I also have to make some adjustments to xfs-tests (to
push preadv2 into xfs_io).


-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
