Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGUVsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:48:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976AC0619DC
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:48:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so75777pjd.3
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:48:31 -0700 (PDT)
Date: Tue, 21 Jul 2020 14:48:29 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 12/15] x86/entry: Cleanup idtentry_entry/exit_user
Message-ID: <202007211448.A8AFA81@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.531305010@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.531305010@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20200721214829.zy989CLqE096IJRQTJgVKDtorWRCdDDaS-OoBfTjczc@z>

On Tue, Jul 21, 2020 at 12:57:18PM +0200, Thomas Gleixner wrote:
> Cleanup the temporary defines and use irqentry_ instead of idtentry_.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
