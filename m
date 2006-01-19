Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:37349 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161320AbWASFAz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jan 2006 00:00:55 -0500
Subject: Re: new syscalls
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060118.172639.15928930.davem@davemloft.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
	 <20060118133629.1cda96fd.akpm@osdl.org>
	 <Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
	 <20060118.172639.15928930.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 16:00:48 +1100
Message-Id: <1137646848.30084.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: davidel@xmailserver.org, akpm@osdl.org, tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, drepper@redhat.com, dhowells@redhat.com, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-01-18 at 17:26 -0800, David S. Miller wrote:
> From: Davide Libenzi <davidel@xmailserver.org>
> Date: Wed, 18 Jan 2006 17:17:20 -0800 (PST)
> 
> > How sophisticated this has to be? And what's the expected ETA? The 
> > epoll_pwait is really a wrapper around epoll_wait (that did not change at 
> > all), so the test in this case should just make sure that the signal 
> > behaviour is the one expected.
> 
> Something along the lines of a smoke test is probably sufficient.
> The platform folks just want to make sure they wired up the
> syscall tables correctly, for the most part.

In the case of syscalls using TIF_RESTORE_SIGMASK we want to make sure
the architecture maintainer got a little bit more right than that -- but
the sigmasking.c test case I posted earlier ought to be mostly
sufficient for testing that, if the arch also switches to the generic
sys_rt_sigsuspend().

-- 
dwmw2

