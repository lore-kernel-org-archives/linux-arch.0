Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgGUVVL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:21:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59494C061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:21:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so60226pfc.6
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:21:11 -0700 (PDT)
Date: Tue, 21 Jul 2020 14:21:09 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 01/15] seccomp: Provide stub for __secure_computing()
Message-ID: <202007211421.FE862FEE@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110808.348199175@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110808.348199175@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20200721212109.fDA98_Zg0wR6IB1-RNKq_VtqDSYiIcZYxHyAiJEVBkI@z>

On Tue, Jul 21, 2020 at 12:57:07PM +0200, Thomas Gleixner wrote:
> To avoid #ifdeffery in the upcoming generic syscall entry work code provide
> a stub for __secure_computing() as this is preferred over
> secure_computing() because the TIF flag is already evaluated.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
