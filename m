From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 0/5] Blackfin SMP like patchset
Date: Wed, 19 Nov 2008 15:28:19 +0800
Message-ID: <386072610811182328u3b1f7ad0u161c56690150fba2@mail.gmail.com>
References: <1226999108-13839-1-git-send-email-cooloney@kernel.org>
	 <20081118225621.540416ae.akpm@linux-foundation.org>
	 <386072610811182327x72df4615od53679b19cf49ed0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:32815 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYKSH2U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Nov 2008 02:28:20 -0500
Received: by an-out-0708.google.com with SMTP id d40so1445426and.1
        for <linux-arch@vger.kernel.org>; Tue, 18 Nov 2008 23:28:19 -0800 (PST)
In-Reply-To: <386072610811182327x72df4615od53679b19cf49ed0@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Sorry for forgetting linux-arch. post again.

-Bryan

On Wed, Nov 19, 2008 at 3:27 PM, Bryan Wu <cooloney@kernel.org> wrote:
> On Wed, Nov 19, 2008 at 2:56 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Tue, 18 Nov 2008 17:05:03 +0800 Bryan Wu <cooloney@kernel.org> wrote:
>>
>>>
>>> Hi folks,
>>>
>>> We provide the SMP like functions for our Blackfin dual core processor
>>> BF561 for almost 1 year. And after a long time developing, debugging and
>>> internal review, we'd like to post them to LKML for other maintainer
>>> review.
>>>
>>> Please find our wiki page about this SMP like patches:
>>> http://docs.blackfin.uclinux.org/doku.php?id=linux-kernel:smp-like
>>
>> Would prefer that changelogs be self-contained, please.  Kernel
>> changelogs are for ever, and I doubt if that page will be there in 20
>> years time.
>>
>
> I guess Graf started this wiki recently although the patch exists for
> a long time.
> And Graf gave a presentation about this SMP on BF561 in AKA 2008 Linux kernel
> developer conference. If I found the link of this presentation, I will
> post it again.
>
>> Particularly when that page must be read to learn fundamental things such as
>>
>>  The SMP support in certain Blackfin processors is describe as `SMP
>>  Like' rather than just `SMP' due to the lack of hardware cache
>>  coherency.  A true SMP system would have support for cache coherency
>>  in hardware.
>>
>>  On all `SMP Like' setups, cache coherency is maintained via
>>  software mechanisms
>>
>> Interesting!
>>
>
> Exactly, SMP means hardware cache coherency. But BF561 dual core
> processor was designed almost 8 years ago.
> we have to do some workaround in software side. Fortunately, BF561
> provides a L2 memory shared by both CoreA and CoreB.
> We did some trick in this L2 memory and our Scratchpad memory.
>
> 'SMP Like' is software aided SMP solution on Blackfin dual core BF561 processor.
> Please enjoy -:)
>
> -Bryan
>
