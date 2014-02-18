Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:41663 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570AbaBRJBz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2014 04:01:55 -0500
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 18 Feb 2014 14:31:52 +0530
Message-ID: <53032023.5000403@linux.vnet.ibm.com>
Date: Tue, 18 Feb 2014 14:26:03 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/52] CPU hotplug: Fix issues with callback registration
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20140218085603.ZpT3TmcdkS_o43zZHfgIBssOQwioKUn0_JYCents7lw@z>

Hi Ingo, Peter, Thomas,

The CPU hotplug core pieces in this patchset have been Acked by Oleg Nesterov
and Gautham Shenoy. A majority of the remaining patches that do the tree-wide
conversions have been Acked by the various subsystem maintainers. Since those
patches have a build dependency on the second patch, it would be easiest to
take all these patches through one single tree.

Would you please consider taking all the patches in this series through your
tree?

Thank you very much!

Regards,
Srivatsa S. Bhat

