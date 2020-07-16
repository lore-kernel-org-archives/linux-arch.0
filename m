Return-Path: <SRS0=SAVZ=A3=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgGPU55 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 16:57:57 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040ABC08C5CE
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:57:57 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x72so4255342pfc.6
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:57:56 -0700 (PDT)
Date: Thu, 16 Jul 2020 13:57:54 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V3 07/13] x86/ptrace: Provide pt_regs helpers for
 entry/exit
Message-ID: <202007161357.70EF223F@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.658427667@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716185424.658427667@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Message-ID: <20200716205754.zJuPZUVlJ4ie-DLSP4ZBo-AkjXk-Qv5yUY37ewgZOKw@z>

On Thu, Jul 16, 2020 at 08:22:15PM +0200, Thomas Gleixner wrote:
> As a preparatory step for moving the syscall and interrupt entry/exit
> handling into generic code, provide pt_regs helpers which allow to:
> 
>   - Retrieve the syscall number from pt_regs
>   - Retrieve the syscall return value from pt_regs
>   - Retrieve the interrupt state from pt_regs to check whether interrupts
>     are reenabled by return from interrupt/exception.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
