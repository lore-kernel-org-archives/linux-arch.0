Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932306AbeFGSsu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 14:48:50 -0400
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 677B4208A3
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 18:48:49 +0000 (UTC)
Received: by mail-wr0-f176.google.com with SMTP id e18-v6so2629311wrs.5
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 11:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-7-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143807.3611-7-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:48:35 -0700
Message-ID: <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607184835.LEwQwGJ62OXSiqjWMr3PZ_F5YIzPtBxlc6jpCkz0Jto@z>

On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The following operations are provided.
>
> ARCH_CET_STATUS:
>         return the current CET status
>
> ARCH_CET_DISABLE:
>         disable CET features
>
> ARCH_CET_LOCK:
>         lock out CET features
>
> ARCH_CET_EXEC:
>         set CET features for exec()
>
> ARCH_CET_ALLOC_SHSTK:
>         allocate a new shadow stack
>
> ARCH_CET_PUSH_SHSTK:
>         put a return address on shadow stack
>
> ARCH_CET_ALLOC_SHSTK and ARCH_CET_PUSH_SHSTK are intended only for
> the implementation of GLIBC ucontext related APIs.

Please document exactly what these all do and why.  I don't understand
what purpose ARCH_CET_LOCK and ARCH_CET_EXEC serve.  CET is opt in for
each ELF program, so I think there should be no need for a magic
override.
