Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:45368 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbC3Hdb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2015 03:33:31 -0400
Date: Mon, 30 Mar 2015 00:33:28 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Add preadv2/pwritev2 documentation.
Message-ID: <20150330073328.GA22229@infradead.org>
References: <cover.1426528417.git.milosz@adfin.com>
 <1426530746-32222-1-git-send-email-milosz@adfin.com>
 <20150327094932.31b5c9fc.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150327094932.31b5c9fc.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Milosz Tanski <milosz@adfin.com>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Message-ID: <20150330073328.nLkYROb63eNO9D4ZoySULrxHQ4jDvslwBS-UOTlsW6E@z>

On Fri, Mar 27, 2015 at 09:49:32AM -0700, Andrew Morton wrote:
> And let's have a think about EAGAIN vs EWOULDBLOCK.

Do you want a sentence saying they are always the same in Linux?
