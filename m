From: David Howells <dhowells@redhat.com>
Subject: Re: memfill
Date: Tue, 07 Feb 2017 09:40:04 +0000
Message-ID: <27995.1486460404@warthog.procyon.org.uk>
References: <20170206144902.GH2267@bombadil.infradead.org> <1486307804-27903-1-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170206144902.GH2267@bombadil.infradead.org>
Content-ID: <27994.1486460404.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com, iamjoonsoo.kim@lge.com, ngupta@vflare.org, zhouxianrong@huawei.com, zhouxiyu@huawei.com, weidu.du@huawei.com, zhangshiming5@huawei.com, Mi.Sophia.Wang@huawei.com, won.ho.park@huawei.com
List-Id: linux-arch.vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> [adding linux-arch to see if anyone there wants to do an optimised
> version of memfill for their CPU]

For mn10300, this is superfluous since the memset() implementation will do
optimised filling of up to 8 x 4 bytes per loop if the alignments suit.

This is also superfluous for frv as that will do up to 8 x 8 bytes per loop.

So on both those arches, memfill() should probably just wrap memset().

David
