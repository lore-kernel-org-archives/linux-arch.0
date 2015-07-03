From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: ARC build -O3 (was Re: subtle side effect of commit a1c48bb160f836)
Date: Fri, 3 Jul 2015 08:28:07 +0530
Message-ID: <5595FA3F.3030107@synopsys.com>
References: <55826966.6050202@synopsys.com> <CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com> <20150618081329.GA9434@pobox.suse.cz> <55828527.8050901@synopsys.com> <55829A0B.8070804@suse.cz> <55829E51.3060007@synopsys.com> <558AA080.7070801@synopsys.com> <20150701151930.GB6743@sepie.suse.cz> <5594CBBE.2030302@synopsys.com> <5595960D.8040208@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51044 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754176AbbGCC6a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2015 22:58:30 -0400
In-Reply-To: <5595960D.8040208@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Friday 03 July 2015 01:20 AM, Michal Marek wrote:
>>> >> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
>>> >> Signed-off-by: Michal Marek <mmarek@suse.com>
>> > 
>> > Sweet, that works for me with the following patch below.
>> > 
>> > Some logistics things:
>> > - It would be nice to keep both of these patches together - do u want to do
>> >   that or want me to pick this one up
>
> Feel free to pick up my patch.

Ok !

>> > - For ARC this fixes a regression starting 3.16 - so I'll need a stable backport
>> >   which but obviously requires above to go to stable. Do u have any issues with
>> >   that. Shall we do the stable request after these hit the mainline...
>
> Or just add
> 
>   Cc: stable@vger.kernel.org # 3.16+

Sure, I just wanted to ensure stable backport was OK for top level Makefile.

I just tried to apply it to 3.17.8 and and it doesn't thus will likely get dropped
by stable folks without a fixed up version.

I've added a "Depends-on" tag to ARC patch just in case.

-Vineet
