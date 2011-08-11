From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage
Date: Thu, 11 Aug 2011 13:15:17 -0400
Message-ID: <CAMjpGUch3O_DWKv39A_H91bU5ypSxSgHjSVX8WYDnGxKVBPZLQ@mail.gmail.com>
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
 <CA+55aFwtyfzaFABHKD+OMWsojGov0JLmnrZimhVaOcrer=tJjQ@mail.gmail.com>
 <20110802183019.GB8393@windriver.com> <CAMjpGUcOagn-o_mETLDr-=pa-3sxq_iDjF=A8OGhdJg5+9ewpA@mail.gmail.com>
 <4E42D769.8030704@windriver.com> <CAMjpGUcTMwYs99Nu02u+Sbg99RuJvRDpjvY6ChDLUEASf1wUrA@mail.gmail.com>
 <4E43D4AD.6080702@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42422 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1HKRPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2011 13:15:38 -0400
In-Reply-To: <4E43D4AD.6080702@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, sfr@canb.auug.org.au

On Thu, Aug 11, 2011 at 09:10, Paul Gortmaker wrote:
> On 11-08-11 12:34 AM, Mike Frysinger wrote:
>> On Wed, Aug 10, 2011 at 15:09, Paul Gortmaker wrote:
>>> Have you thought about getting at least one blackfin defconfig in
>>> the linux-next build coverage? =C2=A0Gives you a better chance of
>>> having people see when they've broken it.
>>
>> all of the blackfin defconfigs get tested nightly in linux-next by a=
n
>> ADI build machine. =C2=A0i just didnt have a chance to review the lo=
gs as i
>> was traveling.
>
> That is good, but as you've noted, it isn't something that anyone
> else can see when they are combing the normal linux-next build
> results below looking to see if they broke anything.
>
> http://kisskb.ellerman.id.au/kisskb/branch/9/

ive never heard of this site before, and there doesnt appear to be any
documentation on that site about it
-mike
