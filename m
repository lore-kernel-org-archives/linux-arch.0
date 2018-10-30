Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46181 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeJ3W3Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Oct 2018 18:29:25 -0400
MIME-Version: 1.0
In-Reply-To: <caa1cb6121ed7f1e0e4617811561267cb97dc2e5.1540900718.git.ren_guo@c-sky.com>
References: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540900718.git.ren_guo@c-sky.com>
 <caa1cb6121ed7f1e0e4617811561267cb97dc2e5.1540900718.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Oct 2018 14:35:54 +0100
Message-ID: <CAK8P3a2LK69GiAU_yyUUZ8m4Bp-V7djEmBX5hvoj=4-3OYVohw@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] csky: use common dtb build rules
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: robh@kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org

On 10/30/18, Guo Ren <ren_guo@c-sky.com> wrote:
> Remove the Kbuild rules in arch/csky and use common dtb build rules.
>
> This modification is based on:
>
> commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by:  Arnd Bergmann <arnd@arndb.de>
