From: Matthew Wilcox <willy@infradead.org>
Subject: Re: memfill
Date: Tue, 7 Feb 2017 09:22:58 -0800
Message-ID: <20170207172258.GM2267@bombadil.infradead.org>
References: <20170206144902.GH2267@bombadil.infradead.org>
 <1486307804-27903-1-git-send-email-minchan@kernel.org>
 <27995.1486460404@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755378AbdBGRXD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2017 12:23:03 -0500
Content-Disposition: inline
In-Reply-To: <27995.1486460404@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com

On Tue, Feb 07, 2017 at 09:40:04AM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > [adding linux-arch to see if anyone there wants to do an optimised
> > version of memfill for their CPU]
> 
> For mn10300, this is superfluous since the memset() implementation will do
> optimised filling of up to 8 x 4 bytes per loop if the alignments suit.
> 
> This is also superfluous for frv as that will do up to 8 x 8 bytes per loop.
> 
> So on both those arches, memfill() should probably just wrap memset().

You've misunderstood the purpose of memfill.  memfill allows the caller
to specify a pattern which is not a single byte in size, eg memfill(addr,
0x12345678, 64) would result in 0x12345678 being reproduced 16 times.
memset(addr, 0x12345678, 64) would result in 0x78 being reproduced
64 times.
