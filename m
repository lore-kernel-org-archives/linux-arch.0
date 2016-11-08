From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][ATCH 1/3] ptrace: Remove maxargs from
 task_current_syscall()
Date: Tue, 8 Nov 2016 16:13:43 -0500
Message-ID: <20161108161343.5c8cfa55@gandalf.local.home>
References: <20161107212634.529267342@goodmis.org>
        <20161107213233.466776454@goodmis.org>
        <CA+55aFyMVXRt2PPifWwVW9oP6+4Cpc4B01t2S1840ZbHk7d1Dg@mail.gmail.com>
        <CALCETrUBLL+2bU+A03sEns=ESjTXModxwuxiH1EHj__SDp2hgA@mail.gmail.com>
        <20161108144851.7a35c37d@gandalf.local.home>
        <CALCETrXOTUOfq3m1fXVUv1bxmF2YKHrkEX2cuHGCAESb5Fyhpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:57036 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753904AbcKHVNr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 16:13:47 -0500
In-Reply-To: <CALCETrXOTUOfq3m1fXVUv1bxmF2YKHrkEX2cuHGCAESb5Fyhpg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Roland McGrath <roland@hack.frob.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, 8 Nov 2016 13:06:35 -0800
Andy Lutomirski <luto@amacapital.net> wrote:
 
>   Or you could
> embed seccomp_data in a bigger structure.

I was thinking about doing just that.

But for now, I may just use seccomp_data and when we want to add more,
we can do the embedding.

-- Steve
