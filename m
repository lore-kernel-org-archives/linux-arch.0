Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:8865 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751685AbbCQCca (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Mar 2015 22:32:30 -0400
Date: Mon, 16 Mar 2015 22:33:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm: kill kmemcheck
Message-ID: <20150316223318.02145751@grimm.local.home>
In-Reply-To: <550787E7.1030604@oracle.com>
References: <1426074547-21888-1-git-send-email-sasha.levin@oracle.com>
	<20150311081909.552e2052@grimm.local.home>
	<55003666.3020100@oracle.com>
	<20150311084034.04ce6801@grimm.local.home>
	<55004595.7020304@oracle.com>
	<20150311102636.6b4110a8@gandalf.local.home>
	<55005491.5080809@oracle.com>
	<20150311105210.1855c95e@gandalf.local.home>
	<550787E7.1030604@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sasha Levin <sasha.levin@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20150317023318.MacBverxOCLg9AUemfCfMj51dNg67zk7RBmWZZdea68@z>

On Mon, 16 Mar 2015 21:48:23 -0400
Sasha Levin <sasha.levin@oracle.com> wrote:


> Steven,
> 
> 
> Since the only objection raised was the too-newiness of GCC 4.9.2/5.0, what
> would you consider a good time-line for removal?
> 
> I haven't heard any "over my dead body" objections, so I guess that trying
> to remove it while no distribution was shipping the compiler that would make
> it possible was premature.
> 
> Although, on the other hand, I'd be happy if we can have a reasonable date
> (that is before my kid goes to college), preferably even before the next
> LSF/MM so that we could have a mission accomplished thingie with a round
> of beers and commemorative t-shirts.

Perhaps give it 2 years? With fair notice that it will soon be gone?

In 2 years I should be up to gcc 4.9 ;-)

I still need to test it out.

-- Steve
