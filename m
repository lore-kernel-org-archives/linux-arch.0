Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g6t1526.atlanta.hp.com ([15.193.200.69]:20763 "EHLO
	g6t1526.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaDQV3a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 17:29:30 -0400
Message-ID: <535047B6.6000404@hp.com>
Date: Thu, 17 Apr 2014 17:29:26 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com> <1397747051-15401-6-git-send-email-Waiman.Long@hp.com> <20140417155002.GP11096@twins.programming.kicks-ass.net>
In-Reply-To: <20140417155002.GP11096@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140417212926.241L9ti_b4VC8_acS4Nymkg6esM6bllxzlXwIG-v10k@z>

On 04/17/2014 11:50 AM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 11:03:57AM -0400, Waiman Long wrote:
>> +#if !defined(__LITTLE_ENDIAN)&&  !defined(__BIG_ENDIAN)
>> +#error "Missing either LITTLE_ENDIAN or BIG_ENDIAN definition."
>> +#endif
> This seems entirely superfluous, I don't think a kernel build will go
> anywhere if either is missing.

Yes, I am on the conservative side when I add that. I can certainly take 
it out if you think that is not needed.

-Longman
