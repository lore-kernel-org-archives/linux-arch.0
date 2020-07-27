From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 4/4] quota: simplify the quotactl compat handling
Date: Mon, 27 Jul 2020 23:31:58 +0200
Message-ID: <20200727213158.GM5284@quack2.suse.cz>
References: <20200726160401.311569-1-hch@lst.de>
 <20200726160401.311569-5-hch@lst.de>
 <20200727124127.GO23179@quack2.suse.cz>
 <20200727155616.GF794331@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0VcA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 17:32:00 -0400
Content-Disposition: inline
In-Reply-To: <20200727155616.GF794331@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, x86@kernel.org, Jan Kara <jack@suse.com>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org

On Mon 27-07-20 16:56:16, Al Viro wrote:
> On Mon, Jul 27, 2020 at 02:41:27PM +0200, Jan Kara wrote:
> > On Sun 26-07-20 18:04:01, Christoph Hellwig wrote:
> > > Fold the misaligned u64 workarounds into the main quotactl flow instead
> > > of implementing a separate compat syscall handler.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > The patch looks good to me and it saves a lot of boiler-plate code so feel
> > free to add:
> > 
> > Acked-by: Jan Kara <jack@suse.cz>
> 
> Which tree do we put that through?  I can grab it into vfs.git, but IIRC usually
> you put quota-related stuff through yours...

I can take it through quota tree as well but I thought it's not a great fit
given the generic arch bits which this last patch depends on...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
