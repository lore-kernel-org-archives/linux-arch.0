Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43738 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755729AbaCSRJ1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2014 13:09:27 -0400
Message-ID: <5329CEF7.6030406@redhat.com>
Date: Wed, 19 Mar 2014 18:08:07 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
 PV guest
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>	<53218E7A.8090707@citrix.com> <5321AF96.6070909@redhat.com> <20140317190511.GB11707@phenom.dumpdata.com> <53280075.1020804@redhat.com> <53290BCD.8010001@hp.com> <53296C6F.7040709@redhat.com> <5329CCAA.9000909@hp.com>
In-Reply-To: <5329CCAA.9000909@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140319170807.CkQRfuyKNapVDYdeZLX2DBL-fWXRQayHBU6SNhf1g8A@z>

Il 19/03/2014 17:58, Waiman Long ha scritto:
>> Exactly.  What you want is boot_cpu_has(X86_FEATURE_HYPERVISOR).
>
> The unfair lock is to be enabled by boot time check, not just by the
> presence of a configuration macro during the build process in order to
> avoid using unfair lock on bare metal. Of course, Linux distros can
> modify this if that suits their need.

"boot_cpu_has" is a run-time check.  You can use it after setup_arch has 
called init_hypervisor_platform and kvm_guest_init.  Can you just just 
check if the PV path has been enabled and, if not, do a static_key_inc 
to enable the unfair path?

Paolo
