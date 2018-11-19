Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f193.google.com ([209.85.166.193]:55621 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeKSTVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Nov 2018 14:21:00 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so7050491itg.5
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 00:58:01 -0800 (PST)
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
 <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
 <CAMuHMdUKPo6Lu0CtWERYkQTKSATqq0QVit-Awcn1O2EsS22iKQ@mail.gmail.com>
From: Rob Landley <rob@landley.net>
Message-ID: <72faac80-114f-f563-b340-0cdeea2673cd@landley.net>
Date: Mon, 19 Nov 2018 02:57:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUKPo6Lu0CtWERYkQTKSATqq0QVit-Awcn1O2EsS22iKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: firoz.khan@linaro.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20181119085759.qlfUiKL0GVYFduDycc07hF565mtGhvoyMtDRbWKnKPw@z>

On 11/19/18 2:08 AM, Geert Uytterhoeven wrote:
> On Mon, Nov 19, 2018 at 6:26 AM Rob Landley <rob@landley.net> wrote:
>> WARNING: CPU: 0 PID: 1 at mm/slub.c:2448 ___slab_alloc.constprop.34+0x196/0x288
> 
> https://patchwork.kernel.org/patch/10549883/

Given that Sato-san is co-maintainer of arch/sh and that was posted in July, why
is it not upstream yet?

Rob
