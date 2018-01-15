From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 08/11] signal/arm: Document conflicts with SI_USER and
 SIGFPE
Date: Mon, 15 Jan 2018 17:49:47 +0000
Message-ID: <20180115174947.GH17719@n2100.armlinux.org.uk>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-8-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52266 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeAORtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 12:49:55 -0500
Content-Disposition: inline
In-Reply-To: <20180112005940.23279-8-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Jan 11, 2018 at 06:59:37PM -0600, Eric W. Biederman wrote:
> Setting si_code to 0 results in a userspace seeing an si_code of 0.
> This is the same si_code as SI_USER.  Posix and common sense requires
> that SI_USER not be a signal specific si_code.  As such this use of 0
> for the si_code is a pretty horribly broken ABI.
> 
> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
> value of __SI_KILL and now sees a value of SIL_KILL with the result
> that uid and pid fields are copied and which might copying the si_addr
> field by accident but certainly not by design.  Making this a very
> flakey implementation.
> 
> Utilizing FPE_FIXME, siginfo_layout will now return SIL_FAULT and the
> appropriate fields will be reliably copied.

So what do you suggest when none of the SIGFPE FPE_xxx codes match the
condition that "we don't know what happened" ?  Raise a SIGKILL instead
maybe?  We will have dumped the VFP state into the kernel log at this
point, things are pretty much fscked.

It's probably an impossible condition unless the hardware has failed,
no one has knowingly reported getting such a dump in their kernel log,
so it's something that could very likely be changed in some way
without anyone noticing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
