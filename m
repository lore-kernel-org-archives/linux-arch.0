Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42200 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbcILJDL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 05:03:11 -0400
Subject: Re: linux-next: manual merge of the kbuild tree with Linus' tree
References: <20160912113224.792b24f0@canb.auug.org.au>
 <20160912125341.0596ed9f@roar.ozlabs.ibm.com>
From: Michal Marek <mmarek@suse.cz>
Message-ID: <e1cd32fd-6db2-0dc7-43c4-f678582326ad@suse.cz>
Date: Mon, 12 Sep 2016 11:03:08 +0200
MIME-Version: 1.0
In-Reply-To: <20160912125341.0596ed9f@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org
Message-ID: <20160912090308.E7TYax6__nicSclgjA01G24Q3U9RBzdJCajG-CK5z88@z>

On 2016-09-12 04:53, Nicholas Piggin wrote:
> Question, what is the best way to merge dependent patches? Considering
> they will need a good amount of architecture testing, I think they will
> have to go via arch trees. But it also does not make sense to merge these
> kbuild changes upstream first, without having tested them.

I think it makes sense to merge the kbuild changes via kbuild.git, even
if they are unused and untested. Any follow-up fixes required to enable
the first architecture can go through the respective architecture tree.
Does that sound OK?

Michal
