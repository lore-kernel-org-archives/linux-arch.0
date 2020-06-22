From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date: Mon, 22 Jun 2020 15:57:21 -0700
Message-ID: <202006221555.45BB6412F@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook>
 <20200622225237.ybol4qmz4mhkmlqc@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVW5Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:57:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6CC061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:57:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so575814pju.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:57:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200622225237.ybol4qmz4mhkmlqc@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fangrui Song <maskray@google.com>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:52:37PM -0700, Fangrui Song wrote:
> > And it's not in the output:
> > 
> > $ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
> > No version information found in this file.
> > 
> > So... for the kernel we need to silence it right now.
> 
> Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
> sections come from?

It's not reporting it correctly:

.gnu.version_d  0x00000000008966b0        0x0
 .gnu.version_d
                0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o

.gnu.version    0x00000000008966b0        0x0
 .gnu.version   0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o

.gnu.version_r  0x00000000008966b0        0x0
 .gnu.version_r
                0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o

it just reports whatever file is listed on the link command line first.

> If it is a bug, we should probably figure out which version of binutils
> has fixed the bug.

I see this with binutils 2.34...

-- 
Kees Cook
