Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:49058 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932438AbWAWJ7U
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jan 2006 04:59:20 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id k0N9wkln122222
	for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2006 09:58:49 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0N9wksw220704
	for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2006 10:58:46 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id k0N9wiOQ027089
	for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2006 10:58:46 +0100
Date: Mon, 23 Jan 2006 10:58:39 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: new syscalls
Message-ID: <20060123095839.GB9241@osiris.boeblingen.de.ibm.com>
References: <20060118133629.1cda96fd.akpm@osdl.org> <1137621188.30084.67.camel@localhost.localdomain> <200601201104.51398.ak@suse.de> <20060120.021552.119433592.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120.021552.119433592.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, dwmw2@infradead.org, akpm@osdl.org, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, drepper@redhat.com, dhowells@redhat.com, davidel@xmailserver.org, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

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

Failed with a lot of errors on s390 too. Strange enough it works well
after if implemented TIF_RESTORE_SIGMASK. Worse things could happen :)

Heiko
