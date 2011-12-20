Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp107.prem.mail.ac4.yahoo.com ([76.13.13.46]:47350 "HELO
	smtp107.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751914Ab1LTQhy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Dec 2011 11:37:54 -0500
Date: Tue, 20 Dec 2011 10:31:09 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
Subject: Re: [GIT PULL] slab fixes for 3.2-rc4
In-Reply-To: <20111220162315.GC10752@google.com>
Message-ID: <alpine.DEB.2.00.1112201027360.21231@router.home>
References: <alpine.LFD.2.02.1111292001420.4019@tux.localdomain> <CA+55aFz23nN4EALZKf1uptn3a+LKU8wehEnxXO7WA8J5WAyPAQ@mail.gmail.com> <CAOJsxLEHT4D4rfMvWe5iPFpunOaLWZD9fJxbOJ6_qMwt_rd7eg@mail.gmail.com> <20111220162315.GC10752@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20111220163109.l9ICyMiNnZWsNrOKdsxa7wyfHLoZ7wQOjno3XapIkm4@z>

On Tue, 20 Dec 2011, Tejun Heo wrote:

> This is __this_cpu_add() + preemption disabled check.  Should be
> removed.  Christoph, is there a use case where __this_cpu_XXX() is
> used without preemption disabled?  Why doesn't it have preemption
> check?

We discussed this before and said that it would be possible to add a
preemption check there. We would need to verify that there is no use case
of __this_cpu_XXX operations in preemptable context. There used to be a
case where we did not care about the races for the vmstat counters but
that seems to have been changed. Not aware of any other use case like
that.

