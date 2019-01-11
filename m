Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36486 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733210AbfAKSFj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jan 2019 13:05:39 -0500
Received: by mail-pf1-f181.google.com with SMTP id b85so7302046pfc.3
        for <linux-arch@vger.kernel.org>; Fri, 11 Jan 2019 10:05:39 -0800 (PST)
Subject: Re: [PATCHSET v2] io_uring IO interface
References: <20190110024404.25372-1-axboe@kernel.dk>
 <fe686e4316f9746c46b91fd58c984531@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4a4a23c7-7842-0a12-2d46-c892cf2082bd@kernel.dk>
Date: Fri, 11 Jan 2019 11:05:35 -0700
MIME-Version: 1.0
In-Reply-To: <fe686e4316f9746c46b91fd58c984531@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roman Penyaev <rpenyaev@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190111180535.mm63rw09tUgVmubQiT5gaMeuoUSP8lIze9St0pKyPN8@z>

On 1/11/19 2:46 AM, Roman Penyaev wrote:
> Hi Jens,
> 
> That is interesting.  Recently I sent an rfc related to epoll uring:
> 
> https://lore.kernel.org/lkml/20190109164025.24554-1-rpenyaev@suse.de
> 
> which can be mapped to userspace and all ready events can be consumed
> from it directly.  I am wondering, is it possible to make some common
> API for all kind of ready events / urings, or it doesn't make any
> sense?

Not sure that's easily possible, even out of the two rings in io_uring,
the sq and cq rings aren't the same. The latter is sequentially
written, as completions come in. The former ring is actually indexes
into the array, so you can submit things out of order when needed.

-- 
Jens Axboe
