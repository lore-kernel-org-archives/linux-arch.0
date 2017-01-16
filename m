From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
Date: Mon, 16 Jan 2017 13:32:31 +0000
Message-ID: <20170116133231.GO3699@e103592.cambridge.arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
 <20170116122038.GG28060@E107787-LIN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbdAPNcg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Jan 2017 08:32:36 -0500
Content-Disposition: inline
In-Reply-To: <20170116122038.GG28060@E107787-LIN>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yao Qi <qiyaoltc@gmail.com>
Cc: linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, gdb@sourceware.org, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org, Alan Hayward <alan.hayward@arm.com>, Torvald Riegel <triegel@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Mon, Jan 16, 2017 at 12:20:38PM +0000, Yao Qi wrote:
> On 17-01-12 11:26:07, Dave Martin wrote:
> > This patch adds support for manipulating a task's vector length at
> > runtime via ptrace.
> > 
> 
> I hope kernel doesn't provide such interface to ptracer to change vector
> length.

It does, with this patch, beacuse...

> The vector length is sort of a read-only property of thread/process/
> program to debugger, unless we really have a clear requirement to modify
> vector length in debugging.  I may miss something because I haven't debug
> SVE code yet.

...the vector length is no longer read-only for the task, thanks to
the new prctls().

This does add complexity, but I figured that any programmer's model
state that the thread can modify for itself should be modifiable by the
debugger, if for no other reason than the user may want to experiment to
see what happens.  Without a ptrace interface, it would be necessary
to inject a prctl() call into the target, which is possible but awkward.

gdb must already re-detect the vector length on stop, since the target
could have called the prctl() in the meantime.

Access via ptrace also allows things like trapping on exec, fork or
clone and changing the vector length for the new process or thread
before it starts to run.  I'm guessing here, but such a scenario seems
legitimate (?)

[...]

Cheers
---Dave
