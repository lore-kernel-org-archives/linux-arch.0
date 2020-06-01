From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 2/6] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
Date: Mon, 1 Jun 2020 14:51:13 +0100
Message-ID: <20200601135112.GB5031@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
 <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:38446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFANvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 09:51:17 -0400
Content-Disposition: inline
In-Reply-To: <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: linux-man <linux-man@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, May 28, 2020 at 09:01:59AM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
> > for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> I had also applied this patch from the email you sent earlier. I've
> pushed those changes to master now.

Thanks for this.

Do you publish a "development" branch somewhere, or similar?

If possible, it's nice to have git rebase work out which patches to drop
for me rather than me doing it by hand.

Don't bother if publishing an extra branch doesn't fit with your
workflow, though.

Cheers
---Dave
