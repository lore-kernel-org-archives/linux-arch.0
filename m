From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 04/27] x86/mce: Delete ist_begin_non_atomic()
Date: Fri, 21 Feb 2020 11:07:10 -0800
Message-ID: <CALCETrWTbSC1cKgfP_v5LCE1-FQ6bF6E+nA5UmB0SphCCCt1vA@mail.gmail.com>
References: <20200221133416.777099322@infradead.org> <20200221134215.264229755@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgBUTHY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 14:07:24 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A115E2467D
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 19:07:23 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id w15so3226606wru.4
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 11:07:23 -0800 (PST)
In-Reply-To: <20200221134215.264229755@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andrew Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Fri, Feb 21, 2020 at 5:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> It is an abomination; and in prepration of removing the whole
> ist_enter() thing, it needs to go.
>
> Convert #MC over to using task_work_add() instead; it will run the
> same code slightly later, on the return to user path of the same
> exception.

This looks correct to me.
