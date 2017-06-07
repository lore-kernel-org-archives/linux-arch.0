Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36830 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFGVyR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 17:54:17 -0400
Received: by mail-pg0-f68.google.com with SMTP id v18so2517623pgb.3
        for <linux-arch@vger.kernel.org>; Wed, 07 Jun 2017 14:54:16 -0700 (PDT)
Date: Wed, 07 Jun 2017 14:54:15 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: RISC-V Linux Port v2
In-Reply-To: <29520.1496820584@warthog.procyon.org.uk>
Message-ID: <mhng-754e478f-3805-455a-a09f-8a988219670c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org
Message-ID: <20170607215415.uPvbFZ5cleovocr2STMJInZDO5Tpec7wxMceoOQ1l7M@z>

On Wed, 07 Jun 2017 00:29:44 PDT (-0700), dhowells@redhat.com wrote:
> What's the target type for building cross-binutils and cross-gcc for it?

riscv64-unknown-linux-gnu

We have a super-repo that scripts the build, and includes a handful of patches
that fix GCC and binutils bugs that are in our first releases.

  https://github.com/riscv/riscv-gnu-toolchain
