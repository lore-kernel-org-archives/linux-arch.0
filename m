From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 32/71] ARC: [DeviceTree] Basic support
Date: Tue, 29 Jan 2013 10:06:31 +0000
Message-ID: <51079F27.1040905@imgtec.com>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com> <1359024639-21915-15-git-send-email-vgupta@synopsys.com> <5106513E.4010205@imgtec.com> <51079C05.7040308@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:17601 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab3A2KGf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Jan 2013 05:06:35 -0500
In-Reply-To: <51079C05.7040308@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>

Hi Vineet,

>> arm64 also adds dtbs and $(dtb-y) to targets (at least in linux-next). I
>> think this makes sure that they don't get rebuilt unless they've
>> actually changed. I've also copied this for metag.
> 
> Did you verify that it makes a difference - at least at my end it's not - the
> default dtb is getting rebuilt everytime. I need to debug this some more.

Yeh, for me it prevents the following build lines appearing every time:
DTC     arch/metag/boot/dts/tz1090_01sp.dtb

but it still does these every time:
DTB    arch/metag/boot/dts/tz1090_01sp.dtb.S
AS      arch/metag/boot/dts/tz1090_01sp.dtb.o

Adding dtbs o targets actually didn't seem to be necessary with $(dtb-y)
added.

Cheers
James
