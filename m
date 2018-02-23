Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:54072 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeBWAPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 19:15:51 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-4-ebiederm@xmission.com>
        <20180112222944.GA22642@ls3530.fritz.box>
Date: Thu, 22 Feb 2018 18:15:16 -0600
In-Reply-To: <20180112222944.GA22642@ls3530.fritz.box> (Helge Deller's message
        of "Fri, 12 Jan 2018 23:29:44 +0100")
Message-ID: <87fu5s4l4b.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 04/11] signal/parisc: Document a conflict with SI_USER with SIGFPE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org

Helge Deller <deller@gmx.de> writes:

> * Eric W. Biederman <ebiederm@xmission.com>:
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
>> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
>> appropriate fields will reliably be copied.
>> 
>> This bug is 13 years old and parsic machines are no longer being built
>> so I don't know if it possible or worth fixing it.  But it is at least
>> worth documenting this so other architectures don't make the same
>> mistake.
>
>
> I think we should fix it, even if we now break the ABI.
>
> It's about a "conditional trap" which needs to be handled by userspace.
> I doubt there is any Linux code out which is utilizing this
> parisc-specific trap.
>
> I'd suggest to add a new FPE trap si_code (e.g. FPE_CONDTRAP).
> While at it, maybe we should include the already existing FPE_MDAOVF
> from the frv architecture, so that arch/frv/include/uapi/asm/siginfo.h
> can go completely.
>
> Suggested patch is below.
>
> I'm willing to test the patch below on the parisc architecture for a few
> weeks. And it will break arch/x86/kernel/signal_compat.c which needs
> looking at then too.

Have you managed to test this change?

I am sitting looking at another new FPE si_code and if this has been tested
I figure FPE_CONDTRAP should get the next available FPE si_code and the
other change should get the one that follows.

Eric
