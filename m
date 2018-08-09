Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40133 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeHIUip (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2018 16:38:45 -0400
MIME-Version: 1.0
References: <20180809174444.31705-1-paul.burton@mips.com> <20180809174444.31705-5-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-5-paul.burton@mips.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 9 Aug 2018 20:12:27 +0200
Message-ID: <CAK8P3a2WVrPc0yu3SXL4qRHsC0C8y=t_4srEy1ELdSBYx4ME=w@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] MIPS: Workaround GCC __builtin_unreachable
 reordering bug
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-arch <linux-arch@vger.kernel.org>, linux-um@lists.infradead.org

On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:

> +/*
> + * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
> + * compiler that a particular code path will never be hit. This allows it to be
> + * optimised out of the generated binary.
> + *
> + * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
> + * 2016 suffer from a bug that can lead to instructions from beyond an

Has anything happened to address this in gcc in the meantime?
Could you update this text to reflect whatever is in current gcc-9?

      Arnd
