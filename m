Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50805 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaKFH4n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Nov 2014 02:56:43 -0500
Date: Wed, 5 Nov 2014 23:56:41 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 0/7] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20141106075641.GB15966@infradead.org>
References: <cover.1415220890.git.milosz@adfin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1415220890.git.milosz@adfin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20141106075641.2ackiOqkqsdafHIBWI7jNoKQiChPEbMWSvSRwQsIJoE@z>

This series looks good, do you also have a man page sniplet to document
the new syscalls?

