Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:62587 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab3DMBOJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2013 21:14:09 -0400
Message-ID: <59dadf6a3450e5985c3b6f440be5ec07.squirrel@www.codeaurora.org>
In-Reply-To: <20130411184750.GK17641@mtj.dyndns.org>
References: <1365016497-32033-1-git-send-email-tj@kernel.org>
    <20130408153107.GA3021@htj.dyndns.org>
    <20130411184750.GK17641@mtj.dyndns.org>
Date: Fri, 12 Apr 2013 18:14:09 -0700
Subject: Re: [PATCHSET v2] arch: unify task dump debug info
From: rkuo@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org, rth@twiddle.net, linux@arm.linux.org.uk, msalter@redhat.com, starvik@axis.com, dhowells@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, jonas@southpole.se, rkuo@codeaurora.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, davem@davemloft.net, lethal@linux-sh.org, vgupta@synopsys.com, chris@zankel.net, cmetcalf@tilera.com, ysato@users.sourceforge.jp, gxt@mprc.pku.edu.cn, jdike@addtoit.com
Message-ID: <20130413011409.lyDk0woLhKLCPUOR7bHLJbOT6aPZ3vdFJhuHiwyY9iM@z>

> On Mon, Apr 08, 2013 at 08:31:07AM -0700, Tejun Heo wrote:
>> Andrew, ping?
>
> Ping #2.  Workqueue conversion of writeback in the block tree needs
> these patches to avoid losing debug information over the conversion,
> so it'd be great if this can be scheduled for 3.10.
>
> Thanks.
>
> --
> tejun
>

Sorry for the late reply; wasn't able to test this until today.

Hexagon could use the same "don't print into stacktrace machinery", but I
can add that to my tree.

So for the Hexagon bits:

Acked-by: Richard Kuo <rkuo@codeaurora.org>


--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation


