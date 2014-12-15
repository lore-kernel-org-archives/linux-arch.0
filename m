From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/5] uaccess: add pagefault_count to thread_info
Date: Mon, 15 Dec 2014 12:23:01 +0100
Message-ID: <20141215122301.0eac5f19@thinkpad-w530>
References: <1418221414-60110-1-git-send-email-dahi@linux.vnet.ibm.com>
	<1418221414-60110-2-git-send-email-dahi@linux.vnet.ibm.com>
	<CAFiDJ59Y9y4VrcVfyo8rrQV-NtM=1G=kQScBtEvnuC3MpXt0KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:45146 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbaLOQca (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Dec 2014 11:32:30 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Mon, 15 Dec 2014 11:23:07 -0000
In-Reply-To: <CAFiDJ59Y9y4VrcVfyo8rrQV-NtM=1G=kQScBtEvnuC3MpXt0KA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "LF.Tan" <lftan.linux@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, David.Laight@aculab.com, peterz@infradead.org, hughd@google.com, hocko@suse.cz

> On Wed, Dec 10, 2014 at 10:23 PM, David Hildenbrand
> <dahi@linux.vnet.ibm.com> wrote:
> > This patch adds the pagefault_count to the thread_info of all
> > architectures. It will be used to count the pagefault_disable() levels
> > on a per-thread basis.
> >
> > We are not reusing the preempt_count as this is per cpu on x86 and we want to
> > demangle pagefault_disable() from preemption in the future.
> >
> > The new counter is added directly below the preempt_count, except for archs
> > relying on a manual calculation of asm offsets - to minimize the changes.
> >
> Hi David
> 
> Is this patchset targeted for 3.19? If yes, then we need this for
> arch/nios2 as well (new arch in 3.19).
> 

Hi,

Peter just showed my that there is some work ongoing on that
pagefault_disable() topic. So I am not sure if the arch-specific part of this
series is still relevant.

But thanks for the info!

David
