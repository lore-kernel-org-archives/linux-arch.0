Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:42104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfAORcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2019 12:32:14 -0500
Subject: Re: [PATCH 05/15] Add io_uring IO interface
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190110024404.25372-1-axboe@kernel.dk>
        <20190110024404.25372-6-axboe@kernel.dk> <yq1sgxzys3s.fsf@oracle.com>
        <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
        <54976aac-bef2-880f-dc10-e3030189a08a@kernel.dk>
Date: Tue, 15 Jan 2019 12:31:59 -0500
In-Reply-To: <54976aac-bef2-880f-dc10-e3030189a08a@kernel.dk> (Jens Axboe's
        message of "Sun, 13 Jan 2019 09:22:16 -0700")
Message-ID: <yq1pnsxu8s0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190115173159.tE_ngd517hpX7zceDsUPLwwWaWGcJ5QZiUHTA9B_7AA@z>


Jens,

> I bit the bullet and bumped the size. 64 bytes is a nicer size in terms
> of cachelines anyway, and I really doubt that 48 vs 64 bytes makes a
> size consumption problem for anyone.
>
> The buf_index is only used for the fixed buffers, which means that we have
> 16 bytes / 128 bits that we can grab for things like KV.

Great!

-- 
Martin K. Petersen	Oracle Linux Engineering
