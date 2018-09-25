Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45453 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIYSOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2018 14:14:09 -0400
MIME-Version: 1.0
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
In-Reply-To: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 25 Sep 2018 14:06:38 +0200
Message-ID: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: alexander.lochmann@tu-dortmund.de
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180925120638.MSuCWRDkFM8IwNP2hRX8_at3QNoXUjs6ZQl6Bi8xuss@z>

On Tue, Sep 25, 2018 at 1:35 PM Alexander Lochmann
<alexander.lochmann@tu-dortmund.de> wrote:
>
> Hi Arnd,
>
> I recently tried to disable the BUG macros on x86-32. I disabled the
> config item in 'General Setup -> Configure standard kernel features
> (expert users) -> BUG() support'.
> However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
> include/asm-generic/bug.h (line 181) the code checks for the existence
> of architecture-specific variants of those macros.
> Since x86 defines its own version of BUG(), line 182 is *not* used.
> In the following, the x86 variant of BUG() is then used to define the
> BUG_ON() macro.
>
> I propose a patch that really disables both macros if the developer
> wants it.
> It undefines the respective x86 variants, and defines both macros as
> 'empty' macros.

Maybe we should update the documentation instead. Note that the
generic version is using 'while (1)' rather than 'while (0)', so this is
not an empty macro but rather one that does more than the
arch-specific one-instruction version does.

We don't really want an empty macro any more, this was used in
the past, but causes compile-time warnings and undefined behavior
for no good reason.

       Arnd
