Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:43503 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755755AbeCHNgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2018 08:36:43 -0500
MIME-Version: 1.0
In-Reply-To: <152050252646.30856.16654455402435277982.stgit@warthog.procyon.org.uk>
References: <152050252646.30856.16654455402435277982.stgit@warthog.procyon.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Mar 2018 14:36:41 +0100
Message-ID: <CAK8P3a2R+ROQbH-9gioP1mg-dck27qaFpxBufJo2S12odseeZg@mail.gmail.com>
Subject: Re: [PATCH] mn10300: Remove the architecture
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-am33-list@redhat.com
Message-ID: <20180308133641.Zbe5sLvYmrmCtqlWfItoT6Zbwyp39kSABCIek1nLRpA@z>

On Thu, Mar 8, 2018 at 10:48 AM, David Howells <dhowells@redhat.com> wrote:
> Remove the MN10300 arch as the hardware is defunct.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> cc: linux-am33-list@redhat.com

Thanks! I've added it to my asm-generic tree now, along with the other
removed architectures. I'll post the remaining patches later when I
have covered the arch specific drivers.

      Arnd
