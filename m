Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43809 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfILIs5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 04:48:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id l22so28631586qtp.10
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2019 01:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190912084032.16927-1-giometti@enneenne.com> <20190912084032.16927-2-giometti@enneenne.com>
In-Reply-To: <20190912084032.16927-2-giometti@enneenne.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 12 Sep 2019 10:48:40 +0200
Message-ID: <CAK8P3a2=3OYezzrkdgcfoef7S0ZFh=cZuNMhFrWgd1vQTE56Sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: add bits to manage multidrop mode
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, Rodolfo Giometti <giometti@linux.it>, Joshua Henderson <joshua.henderson@microchip.com>

On Thu, Sep 12, 2019 at 10:40 AM Rodolfo Giometti <giometti@enneenne.com> wrote:

> diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
> index 2fbaf9ae89dd..ead5eaebdd3b 100644
> --- a/include/uapi/asm-generic/termbits.h
> +++ b/include/uapi/asm-generic/termbits.h
> @@ -141,6 +141,8 @@ struct ktermios {
>  #define HUPCL  0002000
>  #define CLOCAL 0004000
>  #define CBAUDEX 0010000
> +#define PARMD   040000000
> +#define SENDA   0100000000
>  #define    BOTHER 0010000
>  #define    B57600 0010001
>  #define   B115200 0010002


If you add these to the asm-generic version of this file, please also
add them to
the architecture specific ones that don't use asm-generic/termbits.h:
alpha, ia64, mips, parisc, powerpc, sparc, and xtensa.

Please pick values that are the same everywhere and do not clash with
any of the existing bits of any of the above (this is probably the case, but
I have not checked)

      Arnd
