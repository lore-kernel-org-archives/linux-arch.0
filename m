Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757264Ab1LNPIx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Dec 2011 10:08:53 -0500
Message-ID: <4EE8BBF4.8070108@redhat.com>
Date: Wed, 14 Dec 2011 17:08:36 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <4EDF7B0D.4060001@redhat.com> <20111208151929.GA6301@mgebm.net>
In-Reply-To: <20111208151929.GA6301@mgebm.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20111214150836._1IzOD1dcw1iFPJR7px7oGlgUJ1XObXL58mkX35xVFI@z>

On 12/08/2011 05:19 PM, Eric B Munson wrote:
> > error compiling committee.c: too many arguments to function
> > 
> My concern for preempt notifiers is masking real soft lockup warnings.  If the
> flag is set every time the vm is preempted, it becomes more likely that we will
> mask real warnings.  The ioctl was choosen because it sets the flag only when
> the guest is being paused deliberately.
>
> AFAIK, SIGSTOP is not a supported way to stop a qemu vm so a soft lockup

This is a kvm patch, not a qemu patch.  In general we try to address
general requirements, not just those that are specific to one userspace,
even if it is near to our hearts.

> warning would be working as designed there.  If that isn't the case, or if it
> ever changes, we could always install a signal handler for SIGCONT that set the
> flag before resuming the vm.
>
> Scheduling delays are also beyond the scope of this problem and I see the soft
> lockup warning as appropriate in that case.

I don't think you should see a guest softlockup if the host is
overloaded.  Nor should you see it due to a long live migration pause,
or STOP/CONT.  You should see a guest softlockup if it is spinning due
to a guest bug, and not for any other reason.

I think we need a mix of the ioctl (for STOP/CONT and voluntary pauses,
like live migration or qemu stop/cont) and preempt notifiers (together
with a check for TASK_RUNNING/TASK_UNINTERRUPTIBLE, for scheduling or
swap delays)

-- 
error compiling committee.c: too many arguments to function

