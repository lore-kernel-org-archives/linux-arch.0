Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55497
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750805AbWATKZv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jan 2006 05:25:51 -0500
Date: Fri, 20 Jan 2006 02:15:52 -0800 (PST)
Message-Id: <20060120.021552.119433592.davem@davemloft.net>
Subject: Re: new syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200601201104.51398.ak@suse.de>
References: <20060118133629.1cda96fd.akpm@osdl.org>
	<1137621188.30084.67.camel@localhost.localdomain>
	<200601201104.51398.ak@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: ak@suse.de
Cc: dwmw2@infradead.org, akpm@osdl.org, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, drepper@redhat.com, dhowells@redhat.com, davidel@xmailserver.org, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

From: Andi Kleen <ak@suse.de>
Date: Fri, 20 Jan 2006 11:04:50 +0100

> Are you sure it's even working? I implemented TIF_RESTORE_SIGMASK
> for x86-64 and the SEGV part of the test fails. But it even fails
> without any of my patches applied, so if it's really broken
> it was always like this. I suspect i would have heard if such
> a fundamental thing was really broken on x86-64.

It fails similarly on sparc.

Signal stacks and SA_ONSTACK are not a very well tested feature, and I
think that is playing a part in this.
