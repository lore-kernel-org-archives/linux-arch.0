Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:38207 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaDRQXr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Apr 2014 12:23:47 -0400
Message-ID: <53515181.8090303@hp.com>
Date: Fri, 18 Apr 2014 12:23:29 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 03/19] qspinlock: Add pending bit
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com> <1397747051-15401-4-git-send-email-Waiman.Long@hp.com> <20140418074255.GA13517@gmail.com>
In-Reply-To: <20140418074255.GA13517@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140418162329.xbGyd4ib5qVV4kRVRAdyGsJl7n2UD5OnXIwNRWQecIA@z>

On 04/18/2014 03:42 AM, Ingo Molnar wrote:
> * Waiman Long<Waiman.Long@hp.com>  wrote:
>
>> Because the qspinlock needs to touch a second cacheline; add a pending
>> bit and allow a single in-word spinner before we punt to the second
>> cacheline.
>>
>> Signed-off-by: Peter Zijlstra<peterz@infradead.org>
>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
> This patch should have a "From: Peter" in it as well, right?
>
> Thanks,
>
> 	Ingo

Do you mean a "From:" line in the mail header? It will be a bit hard to 
have different "From:" header in the same patch series. I can certainly 
do that if there is an easy way to do it.

-Longman
