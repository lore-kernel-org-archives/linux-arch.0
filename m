From: David Howells <dhowells@redhat.com>
Subject: Re: memfill
Date: Tue, 07 Feb 2017 17:29:15 +0000
Message-ID: <28294.1486488555@warthog.procyon.org.uk>
References: <20170207172258.GM2267@bombadil.infradead.org> <20170206144902.GH2267@bombadil.infradead.org> <1486307804-27903-1-git-send-email-minchan@kernel.org> <27995.1486460404@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754016AbdBGRaM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Feb 2017 12:30:12 -0500
In-Reply-To: <20170207172258.GM2267@bombadil.infradead.org>
Content-ID: <28293.1486488554.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com

Matthew Wilcox <willy@infradead.org> wrote:

> You've misunderstood the purpose of memfill.  memfill allows the caller
> to specify a pattern which is not a single byte in size, eg memfill(addr,
> 0x12345678, 64) would result in 0x12345678 being reproduced 16 times.
> memset(addr, 0x12345678, 64) would result in 0x78 being reproduced
> 64 times.

Ah.  Should it take a unsigned int rather than an unsigned long?

David
