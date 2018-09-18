Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37577 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeIRMxZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 08:53:25 -0400
Received: by mail-yb1-f193.google.com with SMTP id g79-v6so401800ybf.4
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 00:22:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mvmftzoq9d3.fsf@linux-m68k.org>
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
 <1533791723-3882-4-git-send-email-firoz.khan@linaro.org> <mvmftzoq9d3.fsf@linux-m68k.org>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 12:52:06 +0530
Message-ID: <CALxhOnjPL_eB+EdqqO=HVu5uT6d2atAtW_bfMbrEi-B93-XBKw@mail.gmail.com>
Subject: Re: [PATCH 3/4] m68k: Added system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180918072206.qMrR8yFlryFucvDBUZVR-ZbfV1apRcEN1_OKvi-2DME@z>

On 9 August 2018 at 13:06, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Aug 09 2018, Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
>> +       $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
> mkdir -p is a no-op if the directory exits.

Thanks for your reply :)
Sorry for the delayed response :(

Yes, mkdir -p is a no-op if the directory exits. As I mentioned in the
cover letter,
I leverage x86/arm/s390 architecture implementation to come up with a generic
solution. For this, I took x86 implementation as reference.

- Firoz

>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
