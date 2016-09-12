From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the kbuild tree with Linus' tree
Date: Tue, 13 Sep 2016 09:39:45 +1000
Message-ID: <20160913093945.521a28b4@canb.auug.org.au>
References: <20160912113224.792b24f0@canb.auug.org.au>
        <20160912125341.0596ed9f@roar.ozlabs.ibm.com>
        <e1cd32fd-6db2-0dc7-43c4-f678582326ad@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:44186 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbcILXjt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 19:39:49 -0400
In-Reply-To: <e1cd32fd-6db2-0dc7-43c4-f678582326ad@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org

Hi Michal,

On Mon, 12 Sep 2016 11:03:08 +0200 Michal Marek <mmarek@suse.cz> wrote:
>
> On 2016-09-12 04:53, Nicholas Piggin wrote:
> > Question, what is the best way to merge dependent patches? Considering
> > they will need a good amount of architecture testing, I think they will
> > have to go via arch trees. But it also does not make sense to merge these
> > kbuild changes upstream first, without having tested them.  
> 
> I think it makes sense to merge the kbuild changes via kbuild.git, even
> if they are unused and untested. Any follow-up fixes required to enable
> the first architecture can go through the respective architecture tree.
> Does that sound OK?

And if you guarantee not to rebase the kbuild tree (or at least the
subset containing these patches), then each of the architecture trees
can just merge your tree (or a tag?) and then implement any necessary
arch dependent changes.  I fixes are necessary, they can also be merged
into the architecture trees.

-- 
Cheers,
Stephen Rothwell
