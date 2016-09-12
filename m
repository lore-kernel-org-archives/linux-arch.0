From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: linux-next: manual merge of the kbuild tree with Linus' tree
Date: Mon, 12 Sep 2016 12:53:41 +1000
Message-ID: <20160912125341.0596ed9f@roar.ozlabs.ibm.com>
References: <20160912113224.792b24f0@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35228 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbcILCxu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Sep 2016 22:53:50 -0400
In-Reply-To: <20160912113224.792b24f0@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michal Marek <mmarek@suse.cz>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org

On Mon, 12 Sep 2016 11:32:24 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Michal,
> 
> Today's linux-next merge of the kbuild tree got a conflict in:
> 
>   arch/Kconfig
> 
> between commit:
> 
>   0f60a8efe400 ("mm: Implement stack frame object validation")
> 
> from Linus' tree and commits:
> 
>   a5967db9af51 ("kbuild: allow architectures to use thin archives instead of ld -r")
>   b67067f1176d ("kbuild: allow archs to select link dead code/data elimination")
> 
> from the kbuild tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Thanks Stephen, this should be a trivial conflict. Also you wrote one
of the patches :)

Question, what is the best way to merge dependent patches? Considering
they will need a good amount of architecture testing, I think they will
have to go via arch trees. But it also does not make sense to merge these
kbuild changes upstream first, without having tested them.

Thanks,
Nick
