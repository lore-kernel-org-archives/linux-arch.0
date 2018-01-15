From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 08/11] signal/arm: Document conflicts with SI_USER and SIGFPE
Date: Mon, 15 Jan 2018 14:12:26 -0600
Message-ID: <878tcyop91.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-8-ebiederm@xmission.com>
        <20180115174947.GH17719@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:42081 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeAOUNT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 15:13:19 -0500
In-Reply-To: <20180115174947.GH17719@n2100.armlinux.org.uk> (Russell King's
        message of "Mon, 15 Jan 2018 17:49:47 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Thu, Jan 11, 2018 at 06:59:37PM -0600, Eric W. Biederman wrote:
>> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>> This is the same si_code as SI_USER.  Posix and common sense requires
>> that SI_USER not be a signal specific si_code.  As such this use of 0
>> for the si_code is a pretty horribly broken ABI.
>> 
>> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
>> value of __SI_KILL and now sees a value of SIL_KILL with the result
>> that uid and pid fields are copied and which might copying the si_addr
>> field by accident but certainly not by design.  Making this a very
>> flakey implementation.
>> 
>> Utilizing FPE_FIXME, siginfo_layout will now return SIL_FAULT and the
>> appropriate fields will be reliably copied.
>
> So what do you suggest when none of the SIGFPE FPE_xxx codes match the
> condition that "we don't know what happened" ?  Raise a SIGKILL instead
> maybe?  We will have dumped the VFP state into the kernel log at this
> point, things are pretty much fscked.
>
> It's probably an impossible condition unless the hardware has failed,
> no one has knowingly reported getting such a dump in their kernel log,
> so it's something that could very likely be changed in some way
> without anyone noticing.

It sounds like we have two equally valid possible solutions:
1) force_sig(SIGKILL, current);
2) Allocate a new FPE_xxx code in asm-generic/siginfo.h
   I believe the next available number is 15.

If no one is going to notice this should be comparatively easy to fix.
I just don't have the knowledge of arm to make the judgement myself.

Eric
