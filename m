From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] raw_copy_from_user() semantics
Date: Sun, 19 Jul 2020 12:34:11 -0700
Message-ID: <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
References: <20200719031733.GI2786714@ZenIV.linux.org.uk> <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGSTea (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 15:34:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E9DC0619D4
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:34:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so18014578ljm.1
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:34:29 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j17sm1065754lfr.32.2020.07.19.12.34.27
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 12:34:27 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q4so18044049lji.2
        for <linux-arch@vger.kernel.org>; Sun, 19 Jul 2020 12:34:27 -0700 (PDT)
In-Reply-To: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Jul 19, 2020 at 12:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think we should try to get rid of the exact semantics.

Side note: I think one of the historical reasons for the exact
semantics was that we used to do things like the mount option copying
with a "copy_from_user()" iirc.

And that could take a fault at the end of the stack etc, because
"copy_mount_options()" is nasty and doesn't get a size, and just
copies "up to 4kB" of data.

It's a mistake in the interface, but it is what it is. But we've
always handled the inexact count there anyway by originally doing byte
accesses, and at some point you optimized it to just look at where
page boundaries might be..

I think that was the only truly _valid_ case of "we actually copy data
from user space, and we might need to handle a partial case", and
exactly because of that, it had already long avoided the whole "assume
copy_from_user gives us byte-accurate data before the fault".

              Linus
