From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 4/4] quota: simplify the quotactl compat handling
Date: Mon, 27 Jul 2020 16:56:16 +0100
Message-ID: <20200727155616.GF794331@ZenIV.linux.org.uk>
References: <20200726160401.311569-1-hch@lst.de>
 <20200726160401.311569-5-hch@lst.de>
 <20200727124127.GO23179@quack2.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgG0P4W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 11:56:22 -0400
Content-Disposition: inline
In-Reply-To: <20200727124127.GO23179@quack2.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org, Jan Kara <jack@suse.com>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jul 27, 2020 at 02:41:27PM +0200, Jan Kara wrote:
> On Sun 26-07-20 18:04:01, Christoph Hellwig wrote:
> > Fold the misaligned u64 workarounds into the main quotactl flow instead
> > of implementing a separate compat syscall handler.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> The patch looks good to me and it saves a lot of boiler-plate code so feel
> free to add:
> 
> Acked-by: Jan Kara <jack@suse.cz>

Which tree do we put that through?  I can grab it into vfs.git, but IIRC usually
you put quota-related stuff through yours...
