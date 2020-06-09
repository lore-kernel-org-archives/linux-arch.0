Return-Path: <SRS0=6fqV=7W=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgFILAT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 07:00:19 -0400
Subject: Re: [PATCH v2 2/6] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
 <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
 <20200601135112.GB5031@arm.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <61446b0d-5c17-2cb7-79a6-770c931c4b2a@gmail.com>
Date: Tue, 9 Jun 2020 13:00:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200601135112.GB5031@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20200609110013.N98uUCW7tEHrjLl8MNPlunCWFlsNyMd6I18uxhgnyOk@z>

On 6/1/20 3:51 PM, Dave Martin wrote:
> On Thu, May 28, 2020 at 09:01:59AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin@arm.com> wrote:
>>>
>>> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
>>> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>
>> I had also applied this patch from the email you sent earlier. I've
>> pushed those changes to master now.
> 
> Thanks for this.
> 
> Do you publish a "development" branch somewhere, or similar?

Ocassionally, I do this on a per-series basis.

> 
> If possible, it's nice to have git rebase work out which patches to drop
> for me rather than me doing it by hand.

Yuh, sorry about that. I'l try to do it bette rnext time.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
