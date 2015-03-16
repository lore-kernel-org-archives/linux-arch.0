Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:46542 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932573AbbCPWFJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Mar 2015 18:05:09 -0400
Date: Tue, 17 Mar 2015 09:04:54 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v7 5/5] xfs: add RWF_NONBLOCK support
Message-ID: <20150316220453.GG28557@dastard>
References: <cover.1426528417.git.milosz@adfin.com>
 <0a6f2c2297bfbfd7220e3c4d6bce34fc42bc22fb.1426528417.git.milosz@adfin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6f2c2297bfbfd7220e3c4d6bce34fc42bc22fb.1426528417.git.milosz@adfin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150316220454.k9n-rSK-z1nHYe5SJcjR1MfC_P0vlxaHGQHypGGLuIY@z>

On Mon, Mar 16, 2015 at 02:27:15PM -0400, Milosz Tanski wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Add support for non-blocking reads.  The guts are handled by the generic
> code, the only addition is a non-blocking variant of xfs_rw_ilock.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Change looks good, but I haven't tested it, so:

Acked-by: Dave Chinner <david@fromorbit.com>

-- 
Dave Chinner
david@fromorbit.com
