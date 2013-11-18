From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 3/5] qrwlock: Enable fair queue read/write lock
Date: Mon, 18 Nov 2013 10:11:48 -0800
Message-ID: <CA+55aFxXu7eC1WGfZ=_JQbLLJHM5HYRkJPjm3jBDC51SL66Ecw@mail.gmail.com>
References: <1384267735-43213-1-git-send-email-Waiman.Long@hp.com>
	<1384267735-43213-5-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:57642 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab3KRSLv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2013 13:11:51 -0500
In-Reply-To: <1384267735-43213-5-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>

On Tue, Nov 12, 2013 at 6:48 AM, Waiman Long <Waiman.Long@hp.com> wrote:
> By default, queue rwlock is fair among writers and gives preference
> to readers allowing them to steal lock even if a writer is
> waiting. However, there is a desire to have a fair variant of
> rwlock that is more deterministic. To enable this [..]

Is there really any point in having the option for unfair at all?

From your timings, it looks like the unfair locks are more expensive
for the writer side, but since pretty much the whole point of rwlocks
is when readers are the common case, I don't think we care.

And I'm not at all convinced we want the complexity of two different
kinds of rwlocks with different semantics and extra code for said
semantics..

Your *original* fair rwlocks were unusable, since they didn't allow
for the irq semantics that most users need, but afaik your current
version always makes an irq/bh-context reader work even when the lock
is otherwise trying to be fair, so this whole dual behavior seems to
be largely pointless.

No?

                        Linus
