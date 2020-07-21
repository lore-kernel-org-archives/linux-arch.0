Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGUVr6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:47:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B86CC0619DC
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so84757pjt.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:47:58 -0700 (PDT)
Date: Tue, 21 Jul 2020 14:47:56 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 11/15] x86/entry: Use generic syscall exit
 functionality
Message-ID: <202007211447.8F89234@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.432210708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.432210708@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20200721214756.oclFze22RAUGSSXxZQTMw6oRfakPcuNHq4lsa0FZuuc@z>

On Tue, Jul 21, 2020 at 12:57:17PM +0200, Thomas Gleixner wrote:
> Replace the x86 variant with the generic version. Provide the relevant
> architecture specific helper functions and defines.
> 
> Use a temporary define for idtentry_exit_user which will be cleaned up
> seperately.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
