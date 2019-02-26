Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:55801 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfBZDRr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2019 22:17:47 -0500
Received: by mail-it1-f195.google.com with SMTP id z131so1841754itf.5
        for <linux-arch@vger.kernel.org>; Mon, 25 Feb 2019 19:17:46 -0800 (PST)
MIME-Version: 1.0
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org> <20190225.162300.209654917842732349.davem@davemloft.net>
In-Reply-To: <20190225.162300.209654917842732349.davem@davemloft.net>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 26 Feb 2019 08:47:35 +0530
Message-ID: <CALxhOnjdNQsLf=vfWLM2XhQYZVQjo0jKZyCLbzqbcaXGHxyfBQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparc: Unify the system call scripts
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, sparclinux <sparclinux@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190226031735.OGtt7fd8WzkPzZ9_ZHICw4eaH5KH-qCxnZvh4ghFPxI@z>

Hi David,

> > This patch depends on;
> >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
>
> Can you please merge this series in with that dependency
> then?

I was planning to push this patch series independently. But
when Arnd (he is guiding me for this task) and I discussed
some other work, then we planned to include that in this
same patch series. I was done with the implementation but
it is bit late to post. So please abandon this patch series.

Thanks
Firoz
