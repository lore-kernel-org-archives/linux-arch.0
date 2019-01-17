Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f45.google.com ([209.85.166.45]:35093 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfAQV1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2019 16:27:40 -0500
Received: by mail-io1-f45.google.com with SMTP id f4so9076027ion.2
        for <linux-arch@vger.kernel.org>; Thu, 17 Jan 2019 13:27:39 -0800 (PST)
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
 <x49tvi76kuy.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <efe49554-b163-9390-4cea-f6d8f990b2f3@kernel.dk>
Date: Thu, 17 Jan 2019 14:27:37 -0700
MIME-Version: 1.0
In-Reply-To: <x49tvi76kuy.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190117212737.qdlDzWmNsFNpmB0M6UCcoPp2jXR8YKmCV9j9e5i6RYs@z>

On 1/17/19 2:21 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>>> So all we need to do is modify gpg2 so that is requires more locked
>>> memory, and we're golden!  ;-)
>>
>> Haha, that's some nice digging there!
>>
>> Yes, we could bump it, but with the default, we can get a 512 sized
>> ring per user, that's 13 pages (rounded up). Probably good enough to
>> get things off the ground?
> 
> Agreed.  I'll work on bloating gpg as a background task.  =P  Or I guess
> we could add instructions for modifying /etc/security/limits.conf to the
> man pages.

Pushed out with that. Yes, let's ensure that the man pages tell you how
to bump this limit. And we may just consider bumping the default 64k limit
to 128k on the side. Or maybe go crazy and make it 256k per user, damn.

-- 
Jens Axboe
