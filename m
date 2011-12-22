From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
Date: Thu, 22 Dec 2011 11:59:54 +0200
Message-ID: <4EF2FF9A.4080502@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <4EDF7B0D.4060001@redhat.com> <20111214121622.GB18317@amt.cnet> <4EE8B53C.6070502@redhat.com> <20111214182101.GB21945@amt.cnet> <4EE9CA1C.3010801@redhat.com> <20111216093149.GA26982@amt.cnet> <4EEF351E.8040002@redhat.com> <20111219161108.GA15848@amt.cnet> <20111219175047.GA17347@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab1LVKAN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Dec 2011 05:00:13 -0500
In-Reply-To: <20111219175047.GA17347@amt.cnet>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Eric B Munson <emunson@mgebm.net>, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 12/19/2011 07:50 PM, Marcelo Tosatti wrote:
> > 
> > Maybe it is good (not sure), need to look into schedstats and think of
> > cases that would break legitimate guest hangs. And it probably also
> > affects the position of clearing the flag on the guest side as its 
> > currently done in Eric's patchset.
>
> Is the task going to be TASK_UNINTERRUPTIBLE with SIGSTOP? Don't think
> so. 

No.

> Note "Preemption while TASK_RUNNING or TASK_UNINTERRUPTIBLE" is not
> functional for guest-paused-via-QEMU-monitor case.

Right, it's a different case.  Note SIGCONT can be trapped, so it's
similar to monitor cont.

-- 
error compiling committee.c: too many arguments to function
