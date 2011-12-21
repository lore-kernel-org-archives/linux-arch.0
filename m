From: Christoph Lameter <cl@linux.com>
Subject: Re: [GIT PULL] slab fixes for 3.2-rc4
Date: Wed, 21 Dec 2011 09:20:29 -0600 (CST)
Message-ID: <alpine.DEB.2.00.1112210916400.9601@router.home>
References: <alpine.LFD.2.02.1111292001420.4019@tux.localdomain> <CA+55aFz23nN4EALZKf1uptn3a+LKU8wehEnxXO7WA8J5WAyPAQ@mail.gmail.com> <CAOJsxLEHT4D4rfMvWe5iPFpunOaLWZD9fJxbOJ6_qMwt_rd7eg@mail.gmail.com> <alpine.DEB.2.00.1112201016380.21231@router.home>
 <CAOJsxLGj+y2UygJLQO4xbxqgY5OcU65RBZg-P7yecNgc6fKZjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp102.prem.mail.ac4.yahoo.com ([76.13.13.41]:43018 "HELO
	smtp102.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753270Ab1LUPUd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Dec 2011 10:20:33 -0500
In-Reply-To: <CAOJsxLGj+y2UygJLQO4xbxqgY5OcU65RBZg-P7yecNgc6fKZjQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pekka Enberg <penberg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 21 Dec 2011, Pekka Enberg wrote:

> I still don't understand why we'd want separate preempt safe and
> irqsafe variants. It should be enough to have only unsafe and safe
> variants where the latter would always do the right thing.

The effort to make something irqsafe is higher than making it preempt
safe. If that difference is not important then we could just have safe and
unsafe variants. Traditionally counter operations were only preempt safe
though. So making those irqsafe would increse the overhead.
