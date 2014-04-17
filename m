Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22153 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbaDQR0s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 13:26:48 -0400
Date: Thu, 17 Apr 2014 13:23:49 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v9 00/19] qspinlock: a 4-byte queue spinlock with PV
 support
Message-ID: <20140417172246.GA9849@localhost.localdomain>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140417172349.GyJS8RTL93nxnB0kK9OnKGws3tVTAl4huD0uifUnP14@z>

On Thu, Apr 17, 2014 at 11:03:52AM -0400, Waiman Long wrote:
> v8->v9:
>   - Integrate PeterZ's version of the queue spinlock patch with some
>     modification:
>     http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
>   - Break the more complex patches into smaller ones to ease review effort.
>   - Fix a racing condition in the PV qspinlock code.

I am not seeing anything mentioning that the overcommit scenario
for KVM and Xen had been fixed. Or was the 'racing condition' said
issue?

Thanks.
