From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V4 10/15] x86/entry: Use generic syscall entry function
Date: Wed, 22 Jul 2020 20:25:55 +0200
Message-ID: <87wo2vz9sc.fsf@nanos.tec.linutronix.de>
References: <20200721105706.030914876@linutronix.de> <20200721110809.325060396@linutronix.de> <202007211440.BEF76E2@keescook>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:51176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVSZ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 14:25:58 -0400
In-Reply-To: <202007211440.BEF76E2@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>

Kees,

Kees Cook <keescook@chromium.org> writes:
> On Tue, Jul 21, 2020 at 12:57:16PM +0200, Thomas Gleixner wrote:
>
> This doesn't look very expensive, and they certain indicate really bad
> conditions. Does this need to be behind a CONFIG? (Whatever the answer,
> we can probably make those changes in a later series -- some of these
> also look not arch-specific...)

The most expensive part is native_save_flags(). The extra branches could
be visible in benchmarks, but its a good question whether this should be
just enabled.

I just keep it as is for now as I would need to make the flags and the
on_thread_stack() part x86 specific anyway, but yes we can revisit that
once we agreed on the general direction of this.

Thanks,

        tglx
