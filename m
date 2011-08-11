Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36674 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab1HKNLW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2011 09:11:22 -0400
Message-ID: <4E43D4AD.6080702@windriver.com>
Date: Thu, 11 Aug 2011 09:10:05 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
Subject: Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com> <CA+55aFwtyfzaFABHKD+OMWsojGov0JLmnrZimhVaOcrer=tJjQ@mail.gmail.com> <20110802183019.GB8393@windriver.com> <CAMjpGUcOagn-o_mETLDr-=pa-3sxq_iDjF=A8OGhdJg5+9ewpA@mail.gmail.com> <4E42D769.8030704@windriver.com> <CAMjpGUcTMwYs99Nu02u+Sbg99RuJvRDpjvY6ChDLUEASf1wUrA@mail.gmail.com>
In-Reply-To: <CAMjpGUcTMwYs99Nu02u+Sbg99RuJvRDpjvY6ChDLUEASf1wUrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, sfr@canb.auug.org.au
Message-ID: <20110811131005.Ytkld9Gfk1PYopYWubydodasZmu99UsHxFw81VPz32g@z>

On 11-08-11 12:34 AM, Mike Frysinger wrote:
> On Wed, Aug 10, 2011 at 15:09, Paul Gortmaker wrote:
>> On 11-08-07 10:42 PM, Mike Frysinger wrote:
>>
>> [...]
>>
>>> Blackfin is broken because of this.  a simple grep of the tree
>>
>> I've run all the in-tree blackfin configs, so it is all good.
> 
> so you made a change and it's all good <now> ?

Correct.

> 
>> Have you thought about getting at least one blackfin defconfig in
>> the linux-next build coverage?  Gives you a better chance of
>> having people see when they've broken it.
> 
> all of the blackfin defconfigs get tested nightly in linux-next by an
> ADI build machine.  i just didnt have a chance to review the logs as i
> was traveling.

That is good, but as you've noted, it isn't something that anyone
else can see when they are combing the normal linux-next build
results below looking to see if they broke anything.

http://kisskb.ellerman.id.au/kisskb/branch/9/

Thanks,
Paul.

> -mike
