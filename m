From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC][ATCH 1/3] ptrace: Remove maxargs from task_current_syscall()
Date: Mon, 7 Nov 2016 15:51:32 -0800
Message-ID: <CALCETrVHaxqrZLpKvjzfEo2cUmHoMXMJgYYr_tfxs3kREcREeg@mail.gmail.com>
References: <20161107212634.529267342@goodmis.org> <20161107213233.466776454@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107213233.466776454@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 7, 2016 at 1:26 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> task_current_syscall() has a single user that passes in 6 for maxargs, which
> is the maximum arguments that can be used to get system calls from
> syscall_get_arguments(). Instead of passing in a number of arguments to
> grab, just get 6 arguments. The args argument even specifies that it's an
> array of 6 items.
>
> This will also allow changing syscall_get_arguments() to not get a variable
> number of arguments, but always grab 6.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
