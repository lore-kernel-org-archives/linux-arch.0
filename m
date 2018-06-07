Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934869AbeFGPjA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Jun 2018 11:39:00 -0400
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com [209.85.223.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CEB2089B
        for <linux-arch@vger.kernel.org>; Thu,  7 Jun 2018 15:39:00 +0000 (UTC)
Received: by mail-io0-f180.google.com with SMTP id s26-v6so12337163ioj.4
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 08:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143544.3477-1-yu-cheng.yu@intel.com> <20180607143544.3477-3-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143544.3477-3-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 08:38:47 -0700
Message-ID: <CALCETrXAx4vBUxf3VaePNm3HHLZkdTFAR9TV0T+A-jb2QL7Uag@mail.gmail.com>
Subject: Re: [PATCH 2/5] x86/fpu/xstate: Change some names to separate XSAVES
 system and user states
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. J. Lu" <hjl.tools@gmail.com>, "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, mike.kravetz@oracle.com
Message-ID: <20180607153847.dbgxdTF4c4tAiQHDISIKF_ekMn3v_JskADopJ15z2Gc@z>

On Thu, Jun 7, 2018 at 7:40 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> To support XSAVES system states, change some names to distinguish
> user and system states.
>
> Change:
>   supervisor to system
>   copy_init_fpstate_to_fpregs() to copy_init_fpstate_user_settings_to_fpregs()
>   xfeatures_mask to xfeatures_mask_user
>   XCNTXT_MASK to SUPPORTED_XFEATURES_MASK (states supported)

How about copy_init_user_fpstate_to_fpregs()?  It's shorter and more
to the point.

--Andy
