From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 4/4] quota: simplify the quotactl compat handling
Date: Tue, 28 Jul 2020 02:49:45 +0100
Message-ID: <20200728014945.GA951209@ZenIV.linux.org.uk>
References: <20200726160401.311569-1-hch@lst.de>
 <20200726160401.311569-5-hch@lst.de>
 <20200727124127.GO23179@quack2.suse.cz>
 <20200727155616.GF794331@ZenIV.linux.org.uk>
 <20200727213158.GM5284@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG1Btw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 21:49:52 -0400
Content-Disposition: inline
In-Reply-To: <20200727213158.GM5284@quack2.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org, Jan Kara <jack@suse.com>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jul 27, 2020 at 11:31:58PM +0200, Jan Kara wrote:
> On Mon 27-07-20 16:56:16, Al Viro wrote:
> > On Mon, Jul 27, 2020 at 02:41:27PM +0200, Jan Kara wrote:
> > > On Sun 26-07-20 18:04:01, Christoph Hellwig wrote:
> > > > Fold the misaligned u64 workarounds into the main quotactl flow instead
> > > > of implementing a separate compat syscall handler.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > The patch looks good to me and it saves a lot of boiler-plate code so feel
> > > free to add:
> > > 
> > > Acked-by: Jan Kara <jack@suse.cz>
> > 
> > Which tree do we put that through?  I can grab it into vfs.git, but IIRC usually
> > you put quota-related stuff through yours...
> 
> I can take it through quota tree as well but I thought it's not a great fit
> given the generic arch bits which this last patch depends on...

OK, into vfs.git it goes, then...
