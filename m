From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 0/2] THREAD_INFO_IN_TASK prep work for arm64+s390
Date: Fri, 11 Nov 2016 16:23:43 +0000
Message-ID: <20161111162343.GK11945@leverpostej>
References: <1477503787-25537-1-git-send-email-mark.rutland@arm.com>
 <20161102155020.GA17547@remoulade>
 <20161110181307.GC10137@leverpostej>
 <20161111091622.GA4019@osiris>
 <20161111164237.1f381e57@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932532AbcKKQYW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Nov 2016 11:24:22 -0500
Content-Disposition: inline
In-Reply-To: <20161111164237.1f381e57@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, catalin.marinas@arm.com, linux-arch@vger.kernel.org, akpm@linux-foundation.org, keescook@chromium.org, luto@kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 11, 2016 at 04:42:37PM +0100, Martin Schwidefsky wrote:
> On Fri, 11 Nov 2016 10:16:22 +0100
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > > On Wed, Nov 02, 2016 at 03:56:26PM +0000, Mark Rutland wrote:
> > > > On Wed, Oct 26, 2016 at 06:43:05PM +0100, Mark Rutland wrote:

> > > > [1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core-ti-stack-split
> > > 
> > > I believe that Catalin's hoping to take my arm64 patches for v4.10,
> > > using the above tag as a base.
> > > 
> > > What's the plan for s390? Are you happy to do the same?
> > 
> > We intend to merge the s390 variant also for v4.10. Our approach has
> > changed however: we came to the conclusion that having a per-cpu preempt
> > count will generate better code on s390; so Martin implemented that.
> > 
> > And while being at it he also moved the rest of the s390 specific stuff out
> > of our struct thread_info. The corresponding patches will be pushed to
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features

> Just pushed our collected works to the features branch, in case you are
> interested.

Thanks for the heads-up!

It doesn't look like we can do similar for arm64 (we don't have anything
akin to the lowcore stuff), but it certainly seems nicer for s390.

Thanks,
Mark.
