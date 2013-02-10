Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:42018 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3BJTpO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 Feb 2013 14:45:14 -0500
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 11 Feb 2013 05:41:28 +1000
Message-ID: <5117F848.1090700@linux.vnet.ibm.com>
Date: Mon, 11 Feb 2013 01:13:04 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 14/45] rcu, CPU hotplug: Fix comment referring to stop_machine()
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com> <20130122073630.13822.99359.stgit@srivatsabhat.in.ibm.com> <20130209001439.GQ2666@linux.vnet.ibm.com>
In-Reply-To: <20130209001439.GQ2666@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130210194304.kaG50Xez7q_13xX4oP6UHJ9mro4yU_cJ6LdkmIoNI74@z>

On 02/09/2013 05:44 AM, Paul E. McKenney wrote:
> On Tue, Jan 22, 2013 at 01:06:34PM +0530, Srivatsa S. Bhat wrote:
>> Don't refer to stop_machine() in the CPU hotplug path, since we are going
>> to get rid of it. Also, move the comment referring to callback adoption
>> to the CPU_DEAD case, because that's where it happens now.
>>
>> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 
> Ouch!  That comment is indeed obsolete and must die.
> 
> I queued this to -rcu with your Signed-off-by.  However, I omitted
> the added comment, as it is imcomplete -- it is easy to look at
> rcu_cleanup_dead_cpu() to see what it does.
>

Cool! I'll drop it from my patch series then. Thank you!

Regards,
Srivatsa S. Bhat

