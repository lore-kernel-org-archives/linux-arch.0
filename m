From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: subtle side effect of commit a1c48bb160f836
Date: Thu, 18 Jun 2015 13:30:22 +0530
Message-ID: <55827A96.1070205@synopsys.com>
References: <55826966.6050202@synopsys.com>	<CAMuHMdXWHYF8hEEgeFxLTrhvmEDBVS2=VmKykfOtDkGjqODQbA@mail.gmail.com>	<5582742D.9090206@synopsys.com> <CAMuHMdWwT43j-_Ry52_gA7uOp1SsHgMTq_hobd0950ApcFxz0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:39829 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752995AbbFRIAi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Jun 2015 04:00:38 -0400
In-Reply-To: <CAMuHMdWwT43j-_Ry52_gA7uOp1SsHgMTq_hobd0950ApcFxz0A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Marek <mmarek@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Thursday 18 June 2015 01:07 PM, Geert Uytterhoeven wrote:
>>> >> Can we include $(srctree)/arch/$(SRCARCH)/Makefile twice?
>> >
>> > Something like this would be ideal, but does that not bring back your warnings ?
> I don't think so. The warnings were caused by using the host compiler instead
> of the cross compiler while checking for the support of some compiler options.

Tried that but build system spews tons of warning about over-riding commands...

----->8-------
arch/arc/Makefile:103: warning: overriding commands for target `uImage'
arch/arc/Makefile:103: warning: ignoring old commands for target `uImage'
arch/arc/Makefile:103: warning: overriding commands for target `uImage.bin'
arch/arc/Makefile:103: warning: ignoring old commands for target `uImage.bin'
...
...
----->8-------
