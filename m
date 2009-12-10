From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/5] More unreachable() conversions.
Date: Thu, 10 Dec 2009 09:25:00 -0800
Message-ID: <4B212EEC.3060808@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Kyle McMartin <kyle@mcm>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Back in commit 38938c879eb0c39edf85d5164aa0cffe2874304c the new macro
unreachable() was added.  We can use it in BUG instead of a variety of
ad hoc endless loops.

This patch set consists of the patches from the original set that were
never Acked-by anyone.  Although they are completely untested, they
seem plausible.

I don't plan on pushing these things out any more, so if you
like them please merge them via your architecture trees.

I will reply with the 5 patches.

David Daney (5):
   mn10300: Convert BUG() to use unreachable()
   parisc: Convert BUG() to use unreachable()
   powerpc: Convert BUG() to use unreachable()
   alpha: Convert BUG() to use unreachable()
   blackfin: Convert BUG() to use unreachable()

  arch/alpha/include/asm/bug.h    |    3 ++-
  arch/blackfin/include/asm/bug.h |    2 +-
  arch/mn10300/include/asm/bug.h  |    3 ++-
  arch/parisc/include/asm/bug.h   |    4 ++--
  arch/powerpc/include/asm/bug.h  |    2 +-
  5 files changed, 8 insertions(+), 6 deletions(-)

