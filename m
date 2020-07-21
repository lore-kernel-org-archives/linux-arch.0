From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 14/15] x86/entry: Cleanup idtentry_enter/exit
Date: Tue, 21 Jul 2020 14:48:53 -0700
Message-ID: <202007211448.9BB6C2E8B5@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.747620036@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgGUVs4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:48:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F95CC0619DB
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:48:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a14so101829pfi.2
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:48:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200721110809.747620036@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>

On Tue, Jul 21, 2020 at 12:57:20PM +0200, Thomas Gleixner wrote:
> Remove the temporary defines and fixup all references.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
