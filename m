Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:53416 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab3A2BQN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jan 2013 20:16:13 -0500
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 29 Jan 2013 06:43:52 +0530
Message-ID: <5107225A.5040702@linux.vnet.ibm.com>
Date: Tue, 29 Jan 2013 12:14:02 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v5 31/45] blackfin/smp: Use get/put_online_cpus_atomic()
 to prevent CPU offline
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com> <20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com> <CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com> <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
In-Reply-To: <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Bob Liu <lliubbo@gmail.com>, tglx@linutronix.de, peterz@infradead.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130129011402.WoQbuQQ-c7HRcnRhNvnojO8Z-W6ZUhnFq2NbqQMhUGI@z>

On 01/29/2013 06:06 AM, Tejun Heo wrote:
> Hello, Bob.
> 
> On Mon, Jan 28, 2013 at 1:09 AM, Bob Liu <lliubbo@gmail.com> wrote:
>> Thanks, will be applied to my blackfin arch tree.
> 
> I think we still have some work ahead of us to have this patchset
> ready for inclusion and even then it probably would be best to route
> these patches together, so probably not a very good idea to apply this
> to blackfin right now.
> 

Thanks Tejun for pointing that out! I'll address the review comments
soon and respin the patchset.
 
Regards,
Srivatsa S. Bhat

