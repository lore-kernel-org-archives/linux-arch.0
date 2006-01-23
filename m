Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:3305 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964843AbWAWGom (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jan 2006 01:44:42 -0500
Subject: Re: new syscalls
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060120.021552.119433592.davem@davemloft.net>
References: <20060118133629.1cda96fd.akpm@osdl.org>
	 <1137621188.30084.67.camel@localhost.localdomain>
	 <200601201104.51398.ak@suse.de>
	 <20060120.021552.119433592.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 19:44:28 +1300
Message-Id: <1137998669.2751.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, akpm@osdl.org, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, drepper@redhat.com, dhowells@redhat.com, davidel@xmailserver.org, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-01-20 at 02:15 -0800, David S. Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Fri, 20 Jan 2006 11:04:50 +0100
> 
> > Are you sure it's even working? I implemented TIF_RESTORE_SIGMASK
> > for x86-64 and the SEGV part of the test fails. But it even fails
> > without any of my patches applied, so if it's really broken
> > it was always like this. I suspect i would have heard if such
> > a fundamental thing was really broken on x86-64.
> 
> It fails similarly on sparc.
> 
> Signal stacks and SA_ONSTACK are not a very well tested feature, and I
> think that is playing a part in this.

Indeed -- it's a fairly esoteric test case. It was part of a tarball of
similar tests posted by either Bodo Stroesser or Jeff Dike to
linux-arch, probably some time in or around 2003, when UML tripped over
the bug. I fixed it on PPC and PPC64, and I thought it got fixed on
other architectures at the same time.

I'd be more specific about the archive reference, but unfortunately the
PC with my archives on it is refusing to boot at the moment so I can't
be more helpful until I get home from LCA. But when I wanted this, I was
able to find it by grepping my archives starting from little more -- it
shouldn't be hard to find.

-- 
dwmw2

