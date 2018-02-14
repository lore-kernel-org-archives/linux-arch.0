Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44513 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967863AbeBNUGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Feb 2018 15:06:51 -0500
Received: by mail-pg0-f65.google.com with SMTP id j9so2403603pgp.11
        for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2018 12:06:51 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
Subject: [RESEND][PATCH 0/3] exec: Pin stack limit during exec
Date: Wed, 14 Feb 2018 12:06:33 -0800
Message-ID: <1518638796-20819-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Rik van Riel <riel@redhat.com>, Laura Abbott <labbott@redhat.com>, Greg KH <greg@kroah.com>, Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Message-ID: <20180214200633.HTA1zYMZqch8EGX-SfMUdSfYWhS9Nwdb6V4jOsTmu1U@z>

Attempts to solve problems with the stack limit changing during exec
continue to be frustrated[1][2]. In addition to the specific issues around
the Stack Clash family of flaws, Andy Lutomirski pointed out[3] other
places during exec where the stack limit is used and is assumed to be
unchanging. Given the many places it gets used and the fact that it can be
manipulated/raced via setrlimit() and prlimit(), I think the only way to
handle this is to move away from the "current" view of the stack limit and
instead attach it to the bprm, and plumb this down into the functions that
need to know the stack limits. This series implements the approach.

Neither I nor 0-day have found issues with this series, so I'd like to
get it into -mm for further testing.

Thanks!

-Kees

[1] 04e35f4495dd ("exec: avoid RLIMIT_STACK races with prlimit()")
[2] 779f4e1c6c7c ("Revert "exec: avoid RLIMIT_STACK races with prlimit()"")
[3] to security@kernel.org, "Subject: existing rlimit races?"
