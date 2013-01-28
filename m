Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:37743 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab3A1TG7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jan 2013 14:06:59 -0500
MIME-Version: 1.0
In-Reply-To: <CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
	<20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com>
	<CAA_GA1fSLNKSDTGSzHoA+j-mur85BvoSRkARq+DMfORuwrrX4Q@mail.gmail.com>
Date: Mon, 28 Jan 2013 11:06:25 -0800
Message-ID: <CAOS58YN_r-ahRvPekOo_84bM7z3YcFw1EA7DcTf0NVyEhv7ssA@mail.gmail.com>
Subject: Re: [PATCH v5 31/45] blackfin/smp: Use get/put_online_cpus_atomic()
 to prevent CPU offline
From: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bob Liu <lliubbo@gmail.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tglx@linutronix.de, peterz@infradead.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130128190625.CYTLotutu48P45AN-vjIj7oMZbaGMxudVDWt8rr63YY@z>

Hello, Bob.

On Mon, Jan 28, 2013 at 1:09 AM, Bob Liu <lliubbo@gmail.com> wrote:
> Thanks, will be applied to my blackfin arch tree.

I think we still have some work ahead of us to have this patchset
ready for inclusion and even then it probably would be best to route
these patches together, so probably not a very good idea to apply this
to blackfin right now.

Thanks.

-- 
tejun
