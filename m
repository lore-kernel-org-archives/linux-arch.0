Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:28888 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbaDRBsl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 21:48:41 -0400
Message-ID: <53508474.7010402@hp.com>
Date: Thu, 17 Apr 2014 21:48:36 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 00/19] qspinlock: a 4-byte queue spinlock with PV support
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com> <20140417172246.GA9849@localhost.localdomain>
In-Reply-To: <20140417172246.GA9849@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140418014836.mG6ewkd-Ug2asW9TWGQ-4Ro4j7hZ3GV88pdsxUNPJtk@z>

On 04/17/2014 01:23 PM, Konrad Rzeszutek Wilk wrote:
> On Thu, Apr 17, 2014 at 11:03:52AM -0400, Waiman Long wrote:
>> v8->v9:
>>    - Integrate PeterZ's version of the queue spinlock patch with some
>>      modification:
>>      http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
>>    - Break the more complex patches into smaller ones to ease review effort.
>>    - Fix a racing condition in the PV qspinlock code.
> I am not seeing anything mentioning that the overcommit scenario
> for KVM and Xen had been fixed. Or was the 'racing condition' said
> issue?
>
> Thanks.

The hanging is caused by a racing condition which should be fixed in the 
v9 patch. Please let me know if you are still seeing it.

-Longman
