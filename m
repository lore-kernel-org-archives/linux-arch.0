From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch V4 06/15] x86/entry: Consolidate check_user_regs()
Date: Mon, 27 Jul 2020 15:39:53 -0700
Message-ID: <CALCETrW0OmZ04rWO=JN1M+Bcum18Vna+St+QM9pHEeV0yVc=rQ@mail.gmail.com>
References: <20200721105706.030914876@linutronix.de> <20200721110808.889765456@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbgG0WkH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 18:40:07 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC272173E
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 22:40:06 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id r4so13426936wrx.9
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 15:40:06 -0700 (PDT)
In-Reply-To: <20200721110808.889765456@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, Gabriel Krisman Bertazi <krisman@collabora.com>

On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The user register sanity check is sprinkled all over the place. Move it
> into enter_from_user_mode().
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Andy Lutomirski <luto@kernel.org>
