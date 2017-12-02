From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] audit: Avoid build failures on systems without renameat
Date: Fri, 1 Dec 2017 16:16:44 -0800
Message-ID: <CAOesGMis1VX5eCuKZcOjgJEcxLFjzhUVvd27i7CiJ8mjygAnvg@mail.gmail.com>
References: <20171201204956.8332-1-palmer@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:46559 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbdLBAQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Dec 2017 19:16:47 -0500
Received: by mail-lf0-f44.google.com with SMTP id r143so13454156lfe.13
        for <linux-arch@vger.kernel.org>; Fri, 01 Dec 2017 16:16:46 -0800 (PST)
In-Reply-To: <20171201204956.8332-1-palmer@sifive.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Dec 1, 2017 at 12:49 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> renameat has been deprecated in favor of renameat2 for new ports.  This
> allows the audit tests to build on RISC-V.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> CC: Olof Johansson <olof@lixom.net>

Acked-by: Olof Johansson <olof@lixom.net>

> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>


-Olof
