From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
Date: Thu, 15 Dec 2011 11:48:36 +0200
Message-ID: <4EE9C274.3030603@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <4EDF7B0D.4060001@redhat.com> <20111208151929.GA6301@mgebm.net> <4EE8BBF4.8070108@redhat.com> <20111214175844.GD4075@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39859 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758742Ab1LOJsy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Dec 2011 04:48:54 -0500
In-Reply-To: <20111214175844.GD4075@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 12/14/2011 07:58 PM, Eric B Munson wrote:
> > I don't think you should see a guest softlockup if the host is
> > overloaded.  Nor should you see it due to a long live migration pause,
> > or STOP/CONT.  You should see a guest softlockup if it is spinning due
> > to a guest bug, and not for any other reason.
> > 
> > I think we need a mix of the ioctl (for STOP/CONT and voluntary pauses,
> > like live migration or qemu stop/cont) and preempt notifiers (together
> > with a check for TASK_RUNNING/TASK_UNINTERRUPTIBLE, for scheduling or
> > swap delays)
> > 
>
> Do you want the preemption notifier work in before you will consider merging
> this set, or can that be a follow on?

Yes please.

-- 
error compiling committee.c: too many arguments to function
