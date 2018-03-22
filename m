Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:38507 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCVU3W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 16:29:22 -0400
MIME-Version: 1.0
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Mar 2018 13:29:20 -0700
Message-ID: <CA+55aFwTZgivpcx6keE1vX7EyvmMmQaiux25U39-r2tDBUzfBQ@mail.gmail.com>
Subject: Re: [PATCH 00/45] remove in-kernel syscall invocations (part 3 ==
 remainder outside arch/)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180322202920.hbY78P9F6CzhnECj-By2WjP2ZMTk0__500uoeqMsLnk@z>

On Thu, Mar 22, 2018 at 2:00 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> Here is a third series of patches which reduce the number of syscall
> invocations from within the kernel. Once this long-term goal is achieved,
> the syscall entry path can be streamlined.

Looks good to me.

              Linus
