From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V3 05/13] x86/entry: Consolidate check_user_regs()
Date: Thu, 16 Jul 2020 13:56:57 -0700
Message-ID: <202007161356.5CD3A6ACE@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.442693273@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgGPU47 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 16:56:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27BFC061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m22so5441248pgv.9
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 13:56:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200716185424.442693273@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:13PM +0200, Thomas Gleixner wrote:
> The user register sanity check is sprinkled all over the place. Move it
> into enter_from_user_mode().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
