From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] remove compat_sys_getdents64() (was Re: [RFC] why do we
 still keep __{get,put}_user_unaligned()?)
Date: Sat, 8 Apr 2017 11:54:57 -0700
Message-ID: <CA+55aFyAy-hMKfzmfW3mahTjxbKB0eQW-oh0sEm2wwwcQaH4-w@mail.gmail.com>
References: <20170408062115.GZ29622@ZenIV.linux.org.uk> <20170408183619.GA29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37745 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbdDHSy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2017 14:54:59 -0400
In-Reply-To: <20170408183619.GA29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, Apr 8, 2017 at 11:36 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Let's at least remove compat_sys_getdents64()...  Linus, do you
> have any problems with the following?

Hmm. Trying to compare compat_sys_getdents64n and sys_getdents64 side
by side, I think you're right. The patch looks sane.

                   Linus
