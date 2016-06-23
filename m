From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86,
 core)
Date: Thu, 23 Jun 2016 21:11:23 +0200
Message-ID: <20160623191123.GE30935@twins.programming.kicks-ass.net>
References: <cover.1466466093.git.luto@kernel.org>
 <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
 <CALCETrUuG0-tGNQ5iAEO2_gaK1eUq7AoALoBeQKcOP8cvxr=eA@mail.gmail.com>
 <CA+55aFx480bxx7VAmFqdsVGHjoSav4eCvVpcx5ZSpBQuq+=1Mw@mail.gmail.com>
 <20160623143126.GA16664@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56737 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbcFWTLm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2016 15:11:42 -0400
Content-Disposition: inline
In-Reply-To: <20160623143126.GA16664@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Thu, Jun 23, 2016 at 04:31:26PM +0200, Oleg Nesterov wrote:
> On 06/22, Linus Torvalds wrote:
> >
> > Oleg, what do you think? Would it be reasonable to free the stack and
> > thread_info synchronously at exit time, clear the pointer (to catch
> > any odd use), and only RCU-delay the task_struct itself?
> 
> I didn't see the patches yet, quite possibly I misunderstood... But no,
> I don't this we can do this (if we are not going to move ti->flags to
> task_struct at least).

Didn't we talk about using SLAB_DESTROY_BY_RCU for task_struct before?
If that is possible, a reuse in per-cpu cache is equally possible.

All we really want to guarantee is that the memory remains a
task_struct, it need not remain the same task, right?
