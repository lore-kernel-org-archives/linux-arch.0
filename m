Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:62418 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaCRIO7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Mar 2014 04:14:59 -0400
Message-ID: <53280075.1020804@redhat.com>
Date: Tue, 18 Mar 2014 09:14:45 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
 PV guest
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>	<53218E7A.8090707@citrix.com> <5321AF96.6070909@redhat.com> <20140317190511.GB11707@phenom.dumpdata.com>
In-Reply-To: <20140317190511.GB11707@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, Oleg Nesterov <oleg@redhat.com>
Message-ID: <20140318081445.D2JGb2eAhQ8USTeNlTVVSns_eJRBrrmNegvTKpmNdHc@z>

Il 17/03/2014 20:05, Konrad Rzeszutek Wilk ha scritto:
>> > Measurements were done by Gleb for two guests running 2.6.32 with 16
>> > vcpus each, on a 16-core system.  One guest ran with unfair locks,
>> > one guest ran with fair locks.  Two kernel compilations ("time make
> And when you say fair locks are you saying PV ticketlocks or generic
> ticketlocks?

Generic, of course.

> You should see the same values with the PV ticketlock. It is not clear
> to me if this testing did include that variant of locks?

Yes, PV is fine.  But up to this point of the series, we are concerned 
about spinlock performance when running on an overcommitted hypervisor 
that doesn't support PV spinlocks.

Paolo
