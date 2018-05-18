Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40117 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERTlN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 15:41:13 -0400
Received: by mail-wr0-f194.google.com with SMTP id v60-v6so10271070wrc.7
        for <linux-arch@vger.kernel.org>; Fri, 18 May 2018 12:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180518091721.7604-1-jslaby@suse.cz> <20180518091721.7604-18-jslaby@suse.cz>
In-Reply-To: <20180518091721.7604-18-jslaby@suse.cz>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 18 May 2018 12:41:00 -0700
Message-ID: <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/28] x86/asm: use SYM_INNER_LABEL instead of GLOBAL
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
Message-ID: <20180518194100.JVf-rkaEEshizalrvfPmBTPDd8KSOxS_VCSEExbm0I8@z>

On Fri, May 18, 2018 at 2:17 AM Jiri Slaby <jslaby@suse.cz> wrote:

> GLOBAL had several meanings and is going away. In this patch, convert
> all the inner function labels marked with GLOBAL to use SYM_INNER_LABEL
> instead.

> Note that retint_user needs not be global, perhaps since commit
> 2ec67971facc ("x86/entry/64/compat: Remove most of the fast system call
> machinery"), where entry_64_compat's caller was removed. So mark the
> label as LOCAL.


> -GLOBAL(entry_SYSCALL_64_after_hwframe)
> +SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)

I've missed all the context here.   I agree that GLOBAL is misleading, and
"inner label" is nice.  But this is a rather wordy macro.  Would:

INNER_LABEL_GLOBAL(name)

be better?  (With just INNER_LABEL(name) for the local version?)
