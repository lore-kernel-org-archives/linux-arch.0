Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36152 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbcKGXvy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2016 18:51:54 -0500
Received: by mail-vk0-f47.google.com with SMTP id p9so135385640vkd.3
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2016 15:51:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161107213233.466776454@goodmis.org>
References: <20161107212634.529267342@goodmis.org> <20161107213233.466776454@goodmis.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 7 Nov 2016 15:51:32 -0800
Message-ID: <CALCETrVHaxqrZLpKvjzfEo2cUmHoMXMJgYYr_tfxs3kREcREeg@mail.gmail.com>
Subject: Re: [RFC][ATCH 1/3] ptrace: Remove maxargs from task_current_syscall()
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20161107235132.gS_W19ufyP9tBZ8YU_59qQwWF4cIGLnOKlMs5zopqus@z>

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
