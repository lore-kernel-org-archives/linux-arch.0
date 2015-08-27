From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [arc-linux-dev] Re: [PATCH v3 0/6] ARCv2 port to Linux - (C)
 perf
Date: Thu, 27 Aug 2015 07:14:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075CFB864CB@IN01WEMBXB.internal.synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
 <1440590824.15478.38.camel@synopsys.com>
 <1440658683.15478.59.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:57097 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbH0HQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2015 03:16:03 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Thursday 27 August 2015 12:28 PM, Alexey Brodkin wrote:
> Hi Peter,
>
> On Wed, 2015-08-26 at 12:07 +0000, Alexey Brodkin wrote:
>> > Hi Peter,
>> > 
>> > On Mon, 2015-08-24 at 17:20 +0300, Alexey Brodkin wrote:
>>> > > Hi Peter,
>>> > > 
>>> > > This mini-series adds perf support for ARCv2 based cores, which brings in
>>> > > overflow interupts and SMP. Additionally now raw events are supported as well.
>>> > > 
>>> > > Please review !
>>> > > 
>>> > > Compared to v2 this series has:
>>> > >  [1] Removed patch with raw-events support.
>>> > >      It needs some rework and let's then discuss it separately.
>>> > >      Still I plan to send it shortly.
>>> > >  [2] Merged "set usable max period as a half of real max period" into
>>> > >      "implement "event_set_period".
>>> > >  [3] Fixed arc_pmu_event_set_period() in regard of incorrect
>>> > >      "hwc->period_left" setup.
>>> > >  [4] Moved interrupts enabling from arc_pmu_add() to arc_pmu_start()
>>> > > 
>>> > > Compared to v1 this series has:
>>> > >  [1] Addressed review comments
>>> > >  [2] More verbose commit messages and comments in sources
>>> > >  [3] Minor cosmetics
>>> > > 
>>> > > Thanks,
>>> > > Alexey
> I'm wondering if you have any other comments on this series,
> otherwise please consider it for applying.

IMO it is better if this goes via ARC tree !

-Vineet

>
> -Alexey
