Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfAQVVn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Jan 2019 16:21:43 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 05/15] Add io_uring IO interface
References: <20190116175003.17880-1-axboe@kernel.dk>
        <20190116175003.17880-6-axboe@kernel.dk>
        <718b4d1fbe9f97592d6d7b76d7a4537d@suse.de>
        <af41e99c-54f2-a94c-a876-d673fe477e0a@kernel.dk>
        <x49bm4f831e.fsf@segfault.boston.devel.redhat.com>
        <f5ecdead-ea0f-6b79-5f70-b002a103e503@kernel.dk>
        <02568485-cd10-182d-98e3-619077cf9bdc@kernel.dk>
        <x4936pr80uw.fsf@segfault.boston.devel.redhat.com>
        <3180aa85-68a6-0eb2-082b-f177344cefa9@kernel.dk>
        <x49y37j6lqi.fsf@segfault.boston.devel.redhat.com>
        <c86dbb69-1937-5a0d-11ff-98d933f6581a@kernel.dk>
Date: Thu, 17 Jan 2019 16:21:41 -0500
In-Reply-To: <c86dbb69-1937-5a0d-11ff-98d933f6581a@kernel.dk> (Jens Axboe's
        message of "Thu, 17 Jan 2019 14:17:05 -0700")
Message-ID: <x49tvi76kuy.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190117212141.kAG74hm9NW6QzgjVypRJdCSTdOy5uSawgZwvgToQh7w@z>

Jens Axboe <axboe@kernel.dk> writes:

>> So all we need to do is modify gpg2 so that is requires more locked
>> memory, and we're golden!  ;-)
>
> Haha, that's some nice digging there!
>
> Yes, we could bump it, but with the default, we can get a 512 sized
> ring per user, that's 13 pages (rounded up). Probably good enough to
> get things off the ground?

Agreed.  I'll work on bloating gpg as a background task.  =P  Or I guess
we could add instructions for modifying /etc/security/limits.conf to the
man pages.

Cheers,
Jeff
