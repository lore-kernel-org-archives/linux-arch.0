Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42360 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 13:10:56 -0400
MIME-Version: 1.0
References: <20180908045928.26201-1-igor.stoppa@huawei.com>
In-Reply-To: <20180908045928.26201-1-igor.stoppa@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Sep 2018 14:16:52 +0200
Message-ID: <CAK8P3a02Q0_r4sqzJzA01GEHf0oUyevwwVg+E0_iCEkLFrwOaw@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: bug: unify hints for BUG_ON()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Igor Stoppa <igor.stoppa@gmail.com>
Cc: igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180910121652.LPHhdIACJ5lYo2dXWEtG1SaKIyP488Uasw17VsRSMPc@z>

On Sat, Sep 8, 2018 at 6:59 AM Igor Stoppa <igor.stoppa@gmail.com> wrote:
>
> If BUG_ON() is used instead of BUG(), it means that probably the
> preferred outcome is to not BUG(), therefore the condition tested should
> be unlikely().
>
> However, when CONFIG_PROFILE_ANNOTATED_BRANCHES is enabled, the hint is
> disabled, to avoid generating false-positive warnings caused by
> -Wmaybe-uninitialized.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume this will be included in a longer patch series rather than
going through
my asm-generic tree, right?

     Arnd
