Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f47.google.com ([209.85.161.47]:38463 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeJLLcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 07:32:06 -0400
Received: by mail-yw1-f47.google.com with SMTP id d126-v6so4469089ywa.5
        for <linux-arch@vger.kernel.org>; Thu, 11 Oct 2018 21:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org> <3908561D78D1C84285E8C5FCA982C28F7D40F9DD@ORSMSX107.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D40F9DD@ORSMSX107.amr.corp.intel.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 12 Oct 2018 09:31:30 +0530
Message-ID: <CALxhOngtGNP7MATzwtMZd_Xw+rqvdhP9NMtTxwCEgmzayZshOQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] ia64: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181012040130.RARdgn8sCEYyfuh_lIsQTtXnkH3QmhsQ8c_We9-cgsM@z>

Hi Tony,

On Thu, 11 Oct 2018 at 22:59, Luck, Tony <tony.luck@intel.com> wrote:
>
> Third time lucky. This series boots without any obvious errors on my ia64 machine.

Great! Thanks for your support!

>
> That's not and Ack or Review ... I just applied, compiled and booted.

I suspect the offset logic in the system call generation script had a bug. That
I fixed it in this patch series.

Arnd and Eugene had shared few comments on adding new system call entry in the
table and some other things. Appreciate if you can review this patch
series so I can
finalize system call table implementation for ia64 architecture.

Firoz

>
> -Tony
