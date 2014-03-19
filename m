From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
 PV guest
Date: Wed, 19 Mar 2014 11:07:43 +0100
Message-ID: <53296C6F.7040709@redhat.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>	<53218E7A.8090707@citrix.com> <5321AF96.6070909@redhat.com> <20140317190511.GB11707@phenom.dumpdata.com> <53280075.1020804@redhat.com> <53290BCD.8010001@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:49161 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbaCSKHw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Mar 2014 06:07:52 -0400
In-Reply-To: <53290BCD.8010001@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>

Il 19/03/2014 04:15, Waiman Long ha scritto:
>>> You should see the same values with the PV ticketlock. It is not clear
>>> to me if this testing did include that variant of locks?
>>
>> Yes, PV is fine.  But up to this point of the series, we are concerned
>> about spinlock performance when running on an overcommitted hypervisor
>> that doesn't support PV spinlocks.
>
> The unfair queue lock is designed in such a way that it will only be
> activated when running in a PV guest or it won't be mergeable upstream.
> So there must be some way to determine if it is running under a hypervisor.

Exactly.  What you want is boot_cpu_has(X86_FEATURE_HYPERVISOR).

Paolo
