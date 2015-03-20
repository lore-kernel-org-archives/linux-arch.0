Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:40237 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbbCTIBN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2015 04:01:13 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <raghavendra.kt@linux.vnet.ibm.com>;
	Fri, 20 Mar 2015 13:31:10 +0530
Message-ID: <550BCFBC.9000106@linux.vnet.ibm.com>
Date: Fri, 20 Mar 2015 13:13:56 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 9/9] qspinlock,x86,kvm: Implement KVM support for paravirt
 qspinlock
References: <20150316131613.720617163@infradead.org> <20150316133112.333845162@infradead.org> <550A3863.2060808@hp.com> <20150319100121.GL21418@twins.programming.kicks-ass.net> <550B3ACF.4050908@hp.com>
In-Reply-To: <550B3ACF.4050908@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150320074356.yxOxHYgRpZvUlfExZmwzcrJ1HbvjLAFYFyNn3B9eYIw@z>

On 03/20/2015 02:38 AM, Waiman Long wrote:
> On 03/19/2015 06:01 AM, Peter Zijlstra wrote:
[...]
> You are probably right. The initial apply_paravirt() was done before the
> SMP boot. Subsequent ones were at kernel module load time. I put a
> counter in the __native_queue_spin_unlock() and it registered 26949
> unlock calls in a 16-cpu guest before it got patched out.

because even printks take lock..

