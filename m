Return-Path: <SRS0=TrJs=AD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbgFVXAQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 19:00:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19285C061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:00:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q22so6080915pgk.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:00:15 -0700 (PDT)
Date: Mon, 22 Jun 2020 16:00:12 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <202006221600.81F5586@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
 <202006221543.EA2FCFA2FF@keescook>
 <20200622224928.o2a7jkq33guxfci4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622224928.o2a7jkq33guxfci4@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fangrui Song <maskray@google.com>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200622230012.VrzyUhg26es1D5SXII-GKL_1dkBBsMb8Y2aVncClIqE@z>

On Mon, Jun 22, 2020 at 03:49:28PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
> > > LLD may report warnings for 3 synthetic sections if they are orphans:
> > > 
> > > ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> > > ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
> > > ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> > > 
> > > Are they described?
> > 
> > Perhaps:
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..57e9c142e401 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -792,6 +792,9 @@
> > 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
> > 		.stab.index 0 : { *(.stab.index) }			\
> > 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
> > +		.symtab 0 : { *(.symtab) }				\
> > +		.strtab 0 : { *(.strtab) }				\
> > +		.shstrtab 0 : { *(.shstrtab) }				\
> > 		.comment 0 : { *(.comment) }
> > 
> > #ifdef CONFIG_GENERIC_BUG
> 
> This LGTM. Nit: .comment before .symtab is a more common order.

Adjusted.

> Reviewed-by: Fangrui Song <maskray@google.com>

Thanks!

-- 
Kees Cook
