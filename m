Return-Path: <SRS0=ngws=BB=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgGVSP1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 14:15:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E8C0619E1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 11:15:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bm28so2380216edb.2
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 11:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-12-samitolvanen@google.com> <20200717202620.GA768846@bjorn-Precision-5520>
In-Reply-To: <20200717202620.GA768846@bjorn-Precision-5520>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 22 Jul 2020 11:15:14 -0700
Message-ID: <CABCJKudTCwt3J19u8Em493a3Z9J2SD+imtVZTpz5cPv7Wza5iQ@mail.gmail.com>
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Message-ID: <20200722181514.c7ExTWGWE6ESr5LlgdRp3oseu-_L14WdTx7976JRDvg@z>

Hi Bjorn,

On Fri, Jul 17, 2020 at 1:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> OK by me, but please update the subject to match convention:
>
>   PCI: Fix PREL32 relocations for LTO
>
> and include a hint in the commit log about what LTO is.  At least
> expand the initialism once.  Googling for "LTO" isn't very useful.
>
>   With Clang's Link Time Optimization (LTO), the compiler ... ?

Sure, I'll change this in the next version. Thanks for taking a look!

Sami
