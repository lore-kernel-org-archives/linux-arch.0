From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] poll annotations - second round
Date: Sun, 11 Feb 2018 14:45:28 -0800
Message-ID: <CA+55aFyaoLAh0Ar4a+xHzVZtvP=0423jCWtc3kV5Ncm-UqCHiA@mail.gmail.com>
References: <20180210192356.GP30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:40510 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932168AbeBKWpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Feb 2018 17:45:30 -0500
In-Reply-To: <20180210192356.GP30522@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Sat, Feb 10, 2018 at 11:23 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> (ideally - just before -rc1)

Ok, merged and scripted and final patch applied. It's going through
the allmodconfig test after that final patch, but I'll make -rc1 once
that's done, and hopefully we are done with the whole EPOLL/POLL
confusion.

.. and yes, I'm sure we'll be picking up straggling new uses of the
POLL* macros for months or years.

            Linus
