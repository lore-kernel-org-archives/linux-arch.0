From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
Date: Thu, 15 Dec 2011 12:21:16 +0200
Message-ID: <4EE9CA1C.3010801@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <4EDF7B0D.4060001@redhat.com> <20111214121622.GB18317@amt.cnet> <4EE8B53C.6070502@redhat.com> <20111214182101.GB21945@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61312 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab1LOKVf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Dec 2011 05:21:35 -0500
In-Reply-To: <20111214182101.GB21945@amt.cnet>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Eric B Munson <emunson@mgebm.net>, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 12/14/2011 08:21 PM, Marcelo Tosatti wrote:
> On Wed, Dec 14, 2011 at 04:39:56PM +0200, Avi Kivity wrote:
> > On 12/14/2011 02:16 PM, Marcelo Tosatti wrote:
> > > > Having this controlled from userspace means it doesn't work for SIGSTOP
> > > > or for long scheduling delays.  What about doing this automatically
> > > > based on preempt notifiers?
> > >
> > > Long scheduling delays should be considered hangups from the guest
> > > perspective.
> > 
> > Why?  To the guest it looks like slow hardware, but it will interpret it
> > as a softlockup.
>
> Slow enough that progress of the watchdog thread is unable to keep up
> with timer interrupt processing. This is considered a hang and
> should be reported.

It's not a guest hang though!

-- 
error compiling committee.c: too many arguments to function
