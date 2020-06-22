Return-Path: <SRS0=TrJs=AD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgFVWAs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:00:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A1C061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:00:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so550769pjv.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:00:48 -0700 (PDT)
Date: Mon, 22 Jun 2020 15:00:43 -0700
From: Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <20200622220043.6j3vl6v7udmk2ppp@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622205341.2987797-2-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200622220043.tIZRCNugN87356rA-AMM3G2OPh9YALC-LOt5CmPxDTk@z>

On 2020-06-22, Kees Cook wrote:
>For vmlinux linking, no architecture uses the .gnu.version* section,
>so remove it via the common DISCARDS macro in preparation for adding
>--orphan-handling=warn more widely.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> include/asm-generic/vmlinux.lds.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index db600ef218d7..6fbe9ed10cdb 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -934,6 +934,7 @@
> 	*(.discard)							\
> 	*(.discard.*)							\
> 	*(.modinfo)							\
>+	*(.gnu.version*)						\
> 	}
>
> /**
>-- 
>2.25.1

I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

tools/lib/bpf/libbpf_internal.h uses `.symver` directive and
-Wl,--version-script, which may lead to .gnu.version{,_d}, but this only
applies to the userspace libbpf.so

libperf.so has a similar -Wl,--version-script.

Linking vmlinux does not appear to use any symbol versioning.
