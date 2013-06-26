Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:41373 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab3FZSZl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 14:25:41 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 26 Jun 2013 23:50:58 +0530
Message-ID: <51CB3159.8000509@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2013 23:52:17 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 15/45] rcu: Use get/put_online_cpus_atomic() to prevent
 CPU offline
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com> <20130625202755.16593.67819.stgit@srivatsabhat.in.ibm.com> <20130625220026.GG3828@linux.vnet.ibm.com> <51CAF624.6060004@linux.vnet.ibm.com> <AE90C24D6B3A694183C094C60CF0A2F6026B72AA@saturn3.aculab.com> <20130626143424.GN3828@linux.vnet.ibm.com> <1372258271.18733.256.camel@gandalf.local.home> <20130626152148.GA4405@mtj.dyndns.org>
In-Reply-To: <20130626152148.GA4405@mtj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, paulmck@linux.vnet.ibm.com, David Laight <David.Laight@ACULAB.COM>, peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au, namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20130626182217.Y3s3k6dpTAKCgw-dgNbwKeFj9kQFNWBRw6NEa_RvjAc@z>

On 06/26/2013 08:51 PM, Tejun Heo wrote:
> On Wed, Jun 26, 2013 at 10:51:11AM -0400, Steven Rostedt wrote:
>>> It would also increase the latency of CPU-hotunplug operations.
>>
>> Is that a big deal?
> 
> I thought that was the whole deal with this patchset - making cpu
> hotunplugs lighter and faster mostly for powersaving.  That said, just
> removing stop_machine call would be a pretty good deal and I don't
> know how meaningful reducing CPU hotunplug latency is.  Srivatsa?
> 

Keeping the hotunplug latency is important for suspend/resume, where
we take all non-boot CPUs in a loop. That's an interesting use-case
where intrusiveness doesn't matter much, but latency does. So yes,
making CPU hotplug faster is also one of the goals of this patchset.

Regards,
Srivatsa S. Bhat

