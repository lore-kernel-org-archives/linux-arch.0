From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC][ATCH 3/3] syscalls: Remove start and number from
 syscall_get_arguments() args
Date: Mon, 7 Nov 2016 15:54:14 -0800
Message-ID: <CALCETrVt-tPAFOx5wMvA51pjO51VyNwN5cP821WsagDGdjM36Q@mail.gmail.com>
References: <20161107212634.529267342@goodmis.org> <20161107213233.754809394@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:33355 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbcKGXyg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2016 18:54:36 -0500
Received: by mail-ua0-f170.google.com with SMTP id 20so133792321uak.0
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2016 15:54:35 -0800 (PST)
In-Reply-To: <20161107213233.754809394@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, Nov 7, 2016 at 1:26 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>

> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> index e3c95e8e61c5..050891169b51 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h

x86 part is:

Reviewed-by: Andy Lutomirski <luto@kernel.org>

Although I wonder why this takes a task argument.
