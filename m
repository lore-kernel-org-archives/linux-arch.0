From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/3] exec: Pin stack limit during exec
Date: Tue,  9 Jan 2018 12:23:00 -0800
Message-ID: <1515529383-35695-1-git-send-email-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Rik van Riel <riel@redhat.com>, Laura Abbott <labbott@redhat.com>, Greg KH <greg@kroah.com>, Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
List-Id: linux-arch.vger.kernel.org

Attempts to solve problems with the stack limit changing during exec             continue to be frustrated[1][2]. In addition to the specific issues              around the Stack Clash family of flaws, Andy Lutomirski pointed out[3]
other places during exec where the stack limit is used and is assumed
to be unchanging. Given the many places it gets used and the fact that
it can be manipulated/raced via setrlimit() and prlimit(), I think the
only way to handle this is to move away from the "current" view of the
stack limit and instead attach it to the bprm, and plumb this down into
the functions that need to know the stack limits. This series implements
the approach. I'd be curious to hear feedback on alternatives.

Thanks!

-Kees

[1] 04e35f4495dd ("exec: avoid RLIMIT_STACK races with prlimit()")
[2] 779f4e1c6c7c ("Revert "exec: avoid RLIMIT_STACK races with prlimit()"")
[3] to security@kernel.org, "Subject: existing rlimit races?"
