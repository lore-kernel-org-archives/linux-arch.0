Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42228 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLR2A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Oct 2018 13:28:00 -0400
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org> <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Oct 2018 11:56:06 +0200
Message-ID: <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181012095606.gsEPau_qXJml8kqP-o6QSzYxeVYygh_60AvbKWWZeZw@z>

On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Wire up rseq system call requires an architecture specific
> implementation as it not present now.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Didn't we conclude that this should be skipped?

       Arnd
