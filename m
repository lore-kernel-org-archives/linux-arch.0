Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53510 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaKXJxi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2014 04:53:38 -0500
Date: Mon, 24 Nov 2014 01:53:36 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 0/7] vfs: Non-blockling buffered fs read (page cache
 only)
Message-ID: <20141124095336.GA17840@infradead.org>
References: <cover.1415636409.git.milosz@adfin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1415636409.git.milosz@adfin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20141124095336._zQWN4qLdZm0TS3ZOxEE3tl4HuQWVqyuO703F_G0nA8@z>


Al or Andrew,

can someone pick this up?  The end of the 3.19 merge window is near,
and I'd really love to get this series in.
