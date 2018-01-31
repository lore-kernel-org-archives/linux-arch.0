From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] vfs.git: poll annotations
Date: Tue, 30 Jan 2018 19:19:19 -0800
Message-ID: <CA+55aFyMh_cHUb37X6=8=DU2Zm8Cz=mhXYJcGGWqiC8LKLAoFA@mail.gmail.com>
References: <20180130183939.GB29051@ZenIV.linux.org.uk> <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
 <20180131031300.GE29051@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:52482 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeAaDTV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jan 2018 22:19:21 -0500
In-Reply-To: <20180131031300.GE29051@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Jan 30, 2018 at 7:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> As for the place for mangle/demangle... where would you prefer them?

If we can make gcc generate ok code for the generic case and not need
any arch-specific ones, why not just do in <linux/poll.h>?

(And I guess POLLIN/OUT/ERR are standard, so it's only a couple that
need to have potential help translating? That would make the helper
inline smaller and simpler)

                Linus
