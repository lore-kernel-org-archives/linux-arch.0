Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35326 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752685AbeCOPyO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 11:54:14 -0400
Received: by mail-qk0-f195.google.com with SMTP id s188so7822248qkb.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Mar 2018 08:54:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521111028-19856-11-git-send-email-aaron.wu@analog.com>
References: <1521111028-19856-1-git-send-email-aaron.wu@analog.com> <1521111028-19856-11-git-send-email-aaron.wu@analog.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 16:54:11 +0100
Message-ID: <CAK8P3a2MKK4gNfP6jN8+ZXpUgS56UBqwdM5aPnbe3e--0BWr5w@mail.gmail.com>
Subject: Re: [Blackfin removal] [PATCH 11/28] misc: Remove Blackfin DSP echo support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aaron Wu <aaron.wu@analog.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Steve Underwood <steveu@coppice.org>, David Rowe <david@rowetel.com>, gregkh <gregkh@linuxfoundation.org>

On Thu, Mar 15, 2018 at 11:50 AM, Aaron Wu <aaron.wu@analog.com> wrote:
> Signed-off-by: Aaron Wu <aaron.wu@analog.com>
>
> Remove Blackfin DSP echo support
> ---
>  drivers/misc/echo/echo.c | 73 ------------------------------------------------
>  drivers/misc/echo/fir.h  | 50 ---------------------------------
>  2 files changed, 123 deletions(-)

I had picked up this patch at first, but now took a closer look and found no
users of this module. It sounds to me like we should remove the entire
directory rather than just the blackfin portion.

Adding the original authors to Cc for clarification.

      Arnd
