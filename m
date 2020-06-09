From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/6] prctl.2: Add PR_SPEC_INDIRECT_BRANCH for
 SPECULATION_CTRL prctls
Date: Tue, 9 Jun 2020 13:00:13 +0200
Message-ID: <61446b0d-5c17-2cb7-79a6-770c931c4b2a@gmail.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-3-git-send-email-Dave.Martin@arm.com>
 <CAKgNAkhwYASEM+wqaDZQ-ftcB3jnsVN2cXq4E_1ep1rqv+4aLw@mail.gmail.com>
 <20200601135112.GB5031@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200601135112.GB5031-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 6/1/20 3:51 PM, Dave Martin wrote:
> On Thu, May 28, 2020 at 09:01:59AM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On Wed, 27 May 2020 at 23:18, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org> wrote:
>>>
>>> Add the PR_SPEC_INDIRECT_BRANCH "misfeature" added in Linux 4.20
>>> for PR_SET_SPECULATION_CTRL and PR_GET_SPECULATION_CTRL.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
>>> Cc: Tim Chen <tim.c.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>> Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
