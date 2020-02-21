From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 06/27] x86/doublefault: Remove memmove() call
Date: Fri, 21 Feb 2020 11:10:05 -0800
Message-ID: <CALCETrWmnkrHi1FYFLvj5G7SrmN+BrwLgKyt=NBtd-EOoRyeSQ@mail.gmail.com>
References: <20200221133416.777099322@infradead.org> <20200221134215.385886177@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729407AbgBUTKU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 14:10:20 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CD122467E
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 19:10:19 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id a5so2887530wmb.0
        for <linux-arch@vger.kernel.org>; Fri, 21 Feb 2020 11:10:19 -0800 (PST)
In-Reply-To: <20200221134215.385886177@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andrew Lutomirski <luto@kernel.org>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Fri, Feb 21, 2020 at 5:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Use of memmove() in #DF is problematic when you consider tracing and
> other instrumentation.
>
> Remove the memmove() call and simply write out what need doing; Boris
> argues the ranges should not overlap.
>
> Survives selftests/x86, specifically sigreturn_64.
>
> (Andy ?!)

Acked-by: Andy Lutomirski <luto@kernel.org>

Even ignoring the tracing issue, I think this is nicer than the original code.
