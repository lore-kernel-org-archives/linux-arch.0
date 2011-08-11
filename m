From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [RFC/PULL 00/11] introduce export.h; reduce module.h usage
Date: Thu, 11 Aug 2011 00:34:55 -0400
Message-ID: <CAMjpGUcTMwYs99Nu02u+Sbg99RuJvRDpjvY6ChDLUEASf1wUrA@mail.gmail.com>
References: <1311830178-30314-1-git-send-email-paul.gortmaker@windriver.com>
 <CA+55aFwtyfzaFABHKD+OMWsojGov0JLmnrZimhVaOcrer=tJjQ@mail.gmail.com>
 <20110802183019.GB8393@windriver.com> <CAMjpGUcOagn-o_mETLDr-=pa-3sxq_iDjF=A8OGhdJg5+9ewpA@mail.gmail.com>
 <4E42D769.8030704@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34266 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1HKEfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2011 00:35:16 -0400
In-Reply-To: <4E42D769.8030704@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, sfr@canb.auug.org.au

On Wed, Aug 10, 2011 at 15:09, Paul Gortmaker wrote:
> On 11-08-07 10:42 PM, Mike Frysinger wrote:
>
> [...]
>
>> Blackfin is broken because of this. =C2=A0a simple grep of the tree
>
> I've run all the in-tree blackfin configs, so it is all good.

so you made a change and it's all good <now> ?

> Have you thought about getting at least one blackfin defconfig in
> the linux-next build coverage? =C2=A0Gives you a better chance of
> having people see when they've broken it.

all of the blackfin defconfigs get tested nightly in linux-next by an
ADI build machine.  i just didnt have a chance to review the logs as i
was traveling.
-mike
