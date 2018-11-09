Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:35754 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJDvt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2018 22:51:49 -0500
Received: by mail-it1-f194.google.com with SMTP id v11so4627042itj.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Nov 2018 10:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20181109123730.8743-1-vincenzo.frascino@arm.com> <20181109123730.8743-8-vincenzo.frascino@arm.com>
In-Reply-To: <20181109123730.8743-8-vincenzo.frascino@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Fri, 9 Nov 2018 10:09:55 -0800
Message-ID: <CAMn1gO5tmJDXEgAZefcOmp1E2LmG3uqbO7vFwZRxAy2Cny114g@mail.gmail.com>
Subject: Re: [PATCH 07/27] arm64: Substitute gettimeofday with C implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vincenzo.frascino@arm.com
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com, daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com
Message-ID: <20181109180955.X8aCLJuojH5vxDfUAQbtbRNeZkAFeRXkKcHpcM7Sig0@z>

On Fri, Nov 9, 2018 at 4:38 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
> -ccflags-y := -shared -fno-common -fno-builtin
> +ccflags-y := -shared -fno-common -fno-builtin -fno-stack-protector

This either needs to include -ffixed-x18 or
https://patchwork.kernel.org/patch/10671685/ needs to appear earlier
in this series.

Peter
