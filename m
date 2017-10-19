From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL urgent-membarrier] membarrier commits for 4.14
Date: Thu, 19 Oct 2017 16:24:23 -0400
Message-ID: <CA+55aFyQhV184poLRJypH7RfpZEJ_5gx9NmVq5YjU2CWKKng9A@mail.gmail.com>
References: <20171018195944.GA15331@linux.vnet.ibm.com> <1300627407.45155.1508434242913.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:55966 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbdJSUYZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Oct 2017 16:24:25 -0400
In-Reply-To: <1300627407.45155.1508434242913.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Oct 19, 2017 at 1:30 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I have prepared the minimal patch that needs to be applied to
> modify the user-space visible ABI before the end of the 4.14
> cycle.
>
> I will send that patch to you directly, hoping you can apply
> it before the end of the 4.14 cycle.

Thanks, that sounds much better than the big pull request at this stage.

                Linus
