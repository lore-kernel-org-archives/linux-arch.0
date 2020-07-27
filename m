From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch V4 04/15] entry: Provide generic interrupt entry/exit code
Date: Mon, 27 Jul 2020 15:39:01 -0700
Message-ID: <CALCETrUBQa=L_Chd=RAPDEihvUWC_9KoHG00zYsGOwiYg87naQ@mail.gmail.com>
References: <20200721105706.030914876@linutronix.de> <20200721110808.671110583@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0WjO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 18:39:14 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF3A21744
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 22:39:14 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id b6so16386285wrs.11
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 15:39:14 -0700 (PDT)
In-Reply-To: <20200721110808.671110583@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, Gabriel Krisman Bertazi <krisman@collabora.com>

On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Like the syscall entry/exit code interrupt/exception entry after the real
> low level ASM bits should not be different accross architectures.
>
> Provide a generic version based on the x86 code.

I don't like the name.  Sure, idtentry is ugly and x86-specific, but
irq gives the wrong impression.  This is an entry path suitable for
any entry that is guaranteed not to hit during entry/exit handling.
Syscalls, page faults, etc are not "irqs".
