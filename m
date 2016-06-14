Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0107.outbound.protection.outlook.com ([207.46.100.107]:59296
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751364AbcFNTlp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jun 2016 15:41:45 -0400
Message-ID: <576056DB.5050701@hpe.com>
Date: Tue, 14 Jun 2016 15:11:23 -0400
From: Waiman Long <waiman.long@hpe.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH-tip 2/6] locking/rwsem: Enable optional count-based
 spinning on reader
References: <1465927959-39719-1-git-send-email-Waiman.Long@hpe.com> <1465927959-39719-3-git-send-email-Waiman.Long@hpe.com> <20160614182757.GA15903@linux-80c1.suse>
In-Reply-To: <20160614182757.GA15903@linux-80c1.suse>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, xfs@oss.sgi.com, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160614191123.YAt4pFab4vn9miwlZC012ZrgNyPtQ1IClxBVI5rG-sk@z>

On 06/14/2016 02:27 PM, Davidlohr Bueso wrote:
> On Tue, 14 Jun 2016, Waiman Long wrote:
>
>> This patch provides a way for the kernel code to designate specific
>> rwsems to be more aggressive in term of optimistic spinning that the
>> writers will continue to spin for some additional count-based time to
>> see if it can get the lock before sleeping. This aggressive spinning
>> mode should only be used on rwsems where the readers are unlikely to
>> go to sleep.
>
> Yikes, exposing this sort of thing makes me _very_ uneasy, not to mention
> the ad-hoc nature and its easiness to mess up. I'm not really for 
> this, even
> if it shows extraordinary performance boosts on benchmarks.
>
> Thanks,
> Davidlohr

I understand your concern. I will see if there is a way to autotune 
instead of using explicit enablement.

Cheers,
Longman
