Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42049 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab1HVOHn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 10:07:43 -0400
Date: Mon, 22 Aug 2011 16:04:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 01/43] signal: Add block_sigmask() for adding sigmask
	to current->blocked
Message-ID: <20110822140437.GB29312@redhat.com>
References: <1313772419-21951-1-git-send-email-matt@console-pimps.org> <1313772419-21951-2-git-send-email-matt@console-pimps.org> <1314008362.19751.22.camel@mfleming-mobl1.ger.corp.intel.com> <20110822140158.GA29312@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110822140158.GA29312@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org
Message-ID: <20110822140437.qLVAFjtZAGKtsYX9AtL1n0TVJHQhMgufjI0EJlB2Lec@z>

On 08/22, Oleg Nesterov wrote:
>
> On 08/22, Matt Fleming wrote:
> >
> > (Adding linux-arch to Cc so arch maintainers will hopefully see this)
>
> Yes, thanks.
>
> So far I applied only this patch to
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/oleg/misc.git ptrace
>
> But I am going to take the whole series unless I have the nack from
> maintainers. Everything looks correct.
>
> IOW, I am going to wait a bit to collect the ACKs from the maintainers
> in case (I hope ;) they want to review these changes.
>
> OK?

Forgot to mention... And of course, if someone wants to take a patch
please let me know.

Oleg.

