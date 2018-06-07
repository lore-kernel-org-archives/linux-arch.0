Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933187AbeFGPrl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 11:47:41 -0400
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com [209.85.214.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87032089F
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 15:47:40 +0000 (UTC)
Received: by mail-it0-f41.google.com with SMTP id p185-v6so13238652itp.4
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 08:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143705.3531-1-yu-cheng.yu@intel.com> <20180607143705.3531-3-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143705.3531-3-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 08:47:28 -0700
Message-ID: <CALCETrWwGCZ+Fbk+O8T6S48teHj60bQQiHQ49=SsKUOpm8VLBA@mail.gmail.com>
Subject: Re: [PATCH 2/9] x86/cet: Add Kconfig option for user-mode shadow stack
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607154728.q-1ylBEIEo3wVZcPSaOQEIKSSl9fOMUi-KZhT6gJG6Q@z>

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Introduce Kconfig option X86_INTEL_SHADOW_STACK_USER.
>
> An application has shadow stack protection when all the following are
> true:
>
>   (1) The kernel has X86_INTEL_SHADOW_STACK_USER enabled,
>   (2) The running processor supports the shadow stack,
>   (3) The application is built with shadow stack enabled tools & libs
>       and, and at runtime, all dependent shared libs can support shadow
>       stack.
>
> If this kernel config option is enabled, but (2) or (3) above is not
> true, the application runs without the shadow stack protection.
> Existing legacy applications will continue to work without the shadow
> stack protection.
>
> The user-mode shadow stack protection is only implemented for the
> 64-bit kernel.  Thirty-two bit applications are supported under the
> compatibility mode.
>

The 64-bit only part seems entirely reasonable.  So please make the
code 64-bit only :)
