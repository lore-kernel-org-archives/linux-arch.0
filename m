From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] regset ->get() API
Date: Thu, 20 Feb 2020 15:31:56 -0800
Message-ID: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
References: <20200217183340.GI23230@ZenIV.linux.org.uk> <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk> <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
 <20200220232929.GU23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43901 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXcR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 18:32:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so240837ljm.10
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 15:32:14 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q26sm520390lfp.85.2020.02.20.15.32.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:32:12 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b15so98503lfc.4
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 15:32:12 -0800 (PST)
In-Reply-To: <20200220232929.GU23230@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Thu, Feb 20, 2020 at 3:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We do know that caller does not want more than the value it has passed in
> 'size' argument, though.

Ok, fair enough. That's probably a good way to handle the "allocate in
the caller".

So then I have no issues with that approach.

          Linus
