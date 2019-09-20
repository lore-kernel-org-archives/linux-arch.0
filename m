Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407151AbfITXlR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Sep 2019 19:41:17 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C672190F
        for <linux-arch@vger.kernel.org>; Fri, 20 Sep 2019 23:41:16 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id v8so8371236wrt.2
        for <linux-arch@vger.kernel.org>; Fri, 20 Sep 2019 16:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150314.054351477@linutronix.de> <20190919150808.724554170@linutronix.de>
In-Reply-To: <20190919150808.724554170@linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 20 Sep 2019 16:41:03 -0700
Message-ID: <CALCETrUhH9_ZGn=-FMKYvTswQ7g0deVJif2xUihsu5tpJg0xSA@mail.gmail.com>
Subject: Re: [RFC patch 03/15] x86/entry: Use generic syscall entry function
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190920234103.wkrorQGBWLeE4hi1PdmvxK_dpubpNC19LuQpkDAOFbE@z>

On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Replace the syscall entry work handling with the generic version, Provide
> the necessary helper inlines to handle the real architecture specific
> parts, e.g. audit and seccomp invocations.

> -       if (work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> -               ret = tracehook_report_syscall_entry(regs);
> -               if (ret || (work & _TIF_SYSCALL_EMU))
> -                       return -1L;
> -       }

Unless I missed something, you lost the _TIF_SYSCALL_EMU abomination.
