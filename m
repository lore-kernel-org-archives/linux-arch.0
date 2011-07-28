From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage
Date: Thu, 28 Jul 2011 11:42:29 -0400
Message-ID: <20110728154229.GA19589@windriver.com>
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
 <20110728071556.GA6497@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:65386 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1G1Pn3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jul 2011 11:43:29 -0400
Content-Disposition: inline
In-Reply-To: <20110728071556.GA6497@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, sfr@canb.auug.org.au
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org

[Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage] On 28/07/2011 (Thu 09:15) Ingo Molnar wrote:

> 
> * Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> 
> > I don't think there really is any rocket science or contentious 
> > stuff here. It is a sensible cleanup that adds organization and 
> > speeds up compiles. The RFC I'm hoping for is more about how/when 
> > we want to get this in tree.
> 
> I'd suggest to stick it into linux-next ASAP, leave there for a few 
> days and after fixing any potential fallout send it Linuswards.

Hi Stephen,

Would you please add this to linux-next?

git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git#module.h-split

It won't need to be there forever, just long enough to shake loose
anyone who has implicitly been using module.h without asking for it.

Thanks,
Paul.

> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> Thanks,
> 
> 	Ingo
