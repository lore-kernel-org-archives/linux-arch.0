From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 00/44] Meta Linux Kernel Port
Date: Sat, 26 Jan 2013 21:53:38 +0000
Message-ID: <20130126215338.GA25964@balrog>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
 <5102BB38.3050207@imgtec.com>
 <201301260025.10020.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34372 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341Ab3AZVxp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jan 2013 16:53:45 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so503179wib.11
        for <linux-arch@vger.kernel.org>; Sat, 26 Jan 2013 13:53:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201301260025.10020.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Arnd,

On Sat, Jan 26, 2013 at 12:25:09AM +0000, Arnd Bergmann wrote:
> On Friday 25 January 2013, James Hogan wrote:
> > Review seems to have gone quiet. I'm fairly happy with this core
> > patchset in it's currently form (only trivial alterations required since
> > the v3 patches, e.g. some review comments and rebasing on linus/master),
> > and would like to get it into the v3.9 merge window. What's the best way
> > forward? I presume I need to get acks on each individual patch?
> 
> 
> I've just looked through the entire series once more and could not find
> any show-stoppers. I consider this ready for 3.9, and I'm also quite happy
> with Vineet's ARC port, although I think he is still integrating some
> feedback comments.

Thanks for taking another look over it and for all the guidance.

> I'd suggest that you both ask Stephen to add the trees to linux-next
> now (I thought you had done that already, but I don't see them there
> at the moment).

Okay. Yeh, I was holding off expecting to need more acks.

> You don't need Acked-by statements on every single patch, but having
> more of those is certainly benefitial. When it comes to the merge
> window, please send a pull request to Linus, and keep me on Cc,
> so I can weigh in with an additional Ack to the series.

Okay, I'll try and get some more acks on specific patches.

> Until then, maybe you can have another look at each other's architecture
> trees (ARC and Meta). Since you are in exactly the same situation with
> upstream integration now, you are probably the best people to review
> the code, and you providing ACKs and constructive feedback to the other
> tree will helps others see that you are up to the job as an arch
> maintainer. I have also given a few comments to one of you that
> may actually apply to the other one just as well, but I can't remember
> now what I discussed with whom ;-)

Good idea. I've been working on a few changes already based on ARC
feedback which also applies to Meta :-)

Cheers
James
