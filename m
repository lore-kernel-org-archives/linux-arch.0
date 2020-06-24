From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 05/10] x86: Make sure _etext includes function sections
Date: Tue, 23 Jun 2020 21:52:08 -0700
Message-ID: <202006232152.733212868D@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
 <20200623172327.5701-6-kristen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388401AbgFXEwL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 00:52:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B537C061755
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 21:52:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so788008pgb.6
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 21:52:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200623172327.5701-6-kristen@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, arjan@linux.intel.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:22AM -0700, Kristen Carlson Accardi wrote:
> When using -ffunction-sections to place each function in
> it's own text section so it can be randomized at load time, the
> linker considers these .text.* sections "orphaned sections", and
> will place them after the first similar section (.text). In order
> to accurately represent the end of the text section and the
> orphaned sections, _etext must be moved so that it is after both
> .text and .text.* The text size must also be calculated to
> include .text AND .text.*
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
