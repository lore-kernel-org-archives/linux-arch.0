From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/3] thread_info: factor out restart_block
Date: Wed, 19 Oct 2016 16:31:02 -0700
Message-ID: <CALCETrX88DxqBd2D0QB4p39cgZLK6PSTj2hLX_fUh0krDee3iw@mail.gmail.com>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com> <1476901693-8492-3-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35817 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbcJSXbY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2016 19:31:24 -0400
Received: by mail-vk0-f53.google.com with SMTP id q126so48938619vkd.2
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2016 16:31:23 -0700 (PDT)
In-Reply-To: <1476901693-8492-3-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Andrew Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Oct 19, 2016 at 11:28 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Since commit f56141e3e2d9aabf ("all arches, signal: move restart_block
> to struct task_struct"), thread_info and restart_block have been
> logically distinct, yet struct restart_block is still defined in
> <linux/thread_info.h>.
>
> At least one architecture (erroneously) uses restart_block as part of
> its thread_info, and thus the definition of restart_block must come
> before the include of <asm/thread_info>. Subsequent patches in this
> series need to shuffle the order of includes and definitions in
> <linux/thread_info.h>, and will make this ordering fragile.
>
> This patch moves the definition of restart_block out to its own header.
> This serves as generic cleanup, logically separating thread_info and
> restart_block, and also makes it easier to avoid fragility.

Looks entirely reasonable to me.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

--Andy
