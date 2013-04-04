Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:33596 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab3DDFax (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2013 01:30:53 -0400
Message-ID: <515D0FFB.4030803@synopsys.com>
Date: Thu, 4 Apr 2013 11:00:35 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org>
In-Reply-To: <515C5652.8070705@wwwdotorg.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org
Message-ID: <20130404053035.xzIZomjSnNx6Tt3Fh98Km5O3ud3eDMNSL0O24Enaz_w@z>

On 04/03/2013 09:48 PM, Stephen Warren wrote:
> On 04/03/2013 01:14 AM, Vineet Gupta wrote:
>> forgot to CC linux-arch
>>
>> On 04/03/2013 12:42 PM, Vineet Gupta wrote:
>>> Currently, for every ARC kernel build I see the following:
>>>
>>> --------------->8-----------------
>>>   DTB    arch/arc/boot/dts/angel4.dtb.S
>>>   AS      arch/arc/boot/dts/angel4.dtb.o
>>>   LD      arch/arc/boot/dts/built-in.o
>>> rm arch/arc/boot/dts/angel4.dtb.S        <-- forces rebuild next iter
>>>   CHK     kernel/config_data.h
>>> --------------->8-----------------
> I assume that's because the file is an intermediate file, and only built
> due to a chain of build rules, and hence make clean it up itself after
> the build?

Indeed - I should have made that explicit in the Changelog.

>>> +.PRECIOUS: $(obj)/%.dtb.S
>>> +
>>>  $(obj)/%.dtb.S: $(obj)/%.dtb
>>>  	$(call cmd,dt_S_dtb)
> I'm not sure if .PRECIOUS is correct here. That prevents make from
> deleting the file if make is CTRL-C'd in the middle of generating it.
> Couldn't that leave a stale/corrupt file around that'd break the build.
> Judging by:
>
> http://www.gnu.org/software/make/manual/html_node/Special-Targets.html
>
> I think .SECONDARY might be a better choice? Does that solve the problem
> you're seeing?

Technically .SECONDARY is better - however it doesn't seem to work.
Running make with various debug toggles doesn't seem to be helping with why
.PRECIOUS works but not this.
That is also likely reason for a bunch of other .PRECIOUS entries in the same file
but no .SECONDARY.

I presume this is something not specific to ARC kernel or my host.
Can you try the .SECONDARY locally to see if it works for you.

Thx,
-Vineet
