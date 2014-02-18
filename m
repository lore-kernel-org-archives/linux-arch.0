From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/52] CPU hotplug: Fix issues with callback registration
Date: Tue, 18 Feb 2014 14:26:03 +0530
Message-ID: <53032023.5000403@linux.vnet.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
