Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45411 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaEHTFC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 May 2014 15:05:02 -0400
Date: Thu, 8 May 2014 21:04:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 08/19] qspinlock: Make a new qnode structure to
 support virtualization
Message-ID: <20140508190459.GQ2844@laptop.programming.kicks-ass.net>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
 <1399474907-22206-9-git-send-email-Waiman.Long@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399474907-22206-9-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140508190459.6-g5NZpWOqk9mAPRzBTyE1zpKVUQG5kcnal4k7RdT7o@z>

On Wed, May 07, 2014 at 11:01:36AM -0400, Waiman Long wrote:
>  /*
> + * To have additional features for better virtualization support, it is
> + * necessary to store additional data in the queue node structure. So
> + * a new queue node structure will have to be defined and used here.
> + */
> +struct qnode {
> +	struct mcs_spinlock mcs;
> +};

You can ditch this entire patch; its pointless, just add a new
DEFINE_PER_CPU for the para-virt muck.
