Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:33157 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfANIDh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jan 2019 03:03:37 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so7656495itk.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Jan 2019 00:03:36 -0800 (PST)
MIME-Version: 1.0
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org>
 <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu> <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
In-Reply-To: <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 14 Jan 2019 13:33:25 +0530
Message-ID: <CALxhOnjY7Ea2FrxpwMy-ETnfGCvyc8-Ds0LR2J2Tp9CQft9N5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190114080325.WK6HIPr1Jv-ZM6N-iFWpL-I6qK_dSt4s6wLUxHVVGd8@z>

Hi Michal,

On Thu, 3 Jan 2019 at 18:39, Firoz Khan <firoz.khan@linaro.org> wrote:
> > Looks good. Will keep this in my queue till depending patch is applied.
>
> Thanks for the feedback. As Geert shared few feedback while m68k review,
> Hopefully, I may have to include those changes here also.

FYI, I'm going to abandon this patch series (for other 9 architecture
also) and planning to come up with asm-generic support along with\
this one. That can be single patch series and everything can be landed
in upstream in the same time.

Firoz
