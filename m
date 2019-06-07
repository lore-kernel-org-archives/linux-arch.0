From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [RFC PATCH 0/5]: Removing saved_sigmask
Date: Fri, 07 Jun 2019 16:39:54 -0500
Message-ID: <87k1dxaxcl.fsf_-_@xmission.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190606140814.GA13440@redhat.com> (Oleg Nesterov's message of
        "Thu, 6 Jun 2019 16:08:14 +0200")
Sender: stable-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, stable@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


While reviewing Oleg's patches I realized a bunch of the logic around
saved_sigmask was redundant.  So I dug just to see what I could see.

I turns out that real_blocked and saved_sigmask were different
implementations of the same idea for slightly different purposes.
Which means we only need either real_blocked or saved_sigmask.

I chose real_blocked as it has just a little bit of code associated
with it to disable optimizations on the signal sending path that do
not apply to blocked signals.

I did a little bit of cleanup of the users.  Modified the core to keep
real_blocked in sync with blocked except while a clever system call that
like pselect or sigtimedwait is running.

After the dust cleared this allowed restore_sigmask and all of the logic
to keep it valid to be removed entirely.

I have only done the most cursory of testing at this point.  Does anyone
have any thoughts in cleaning up the code in this direction?

Eric W. Biederman (5):
      signal: Teach sigsuspend to use set_user_sigmask
      signal/kvm:  Stop using sigprocmask in kvm_sigset_(activate|deactivate)
      signal: Always keep real_blocked in sync with blocked
      signal: Remove saved_sigmask
      signal: Remove the unnecessary restore_sigmask flag

 arch/arc/include/asm/thread_info.h       |  1 -
 arch/arm/include/asm/thread_info.h       |  1 -
 arch/arm64/include/asm/thread_info.h     |  1 -
 arch/c6x/include/asm/thread_info.h       |  1 -
 arch/csky/include/asm/thread_info.h      |  2 -
 arch/h8300/include/asm/thread_info.h     |  1 -
 arch/hexagon/include/asm/thread_info.h   |  1 -
 arch/m68k/include/asm/thread_info.h      |  1 -
 arch/mips/include/asm/thread_info.h      |  1 -
 arch/nds32/include/asm/thread_info.h     |  2 -
 arch/nios2/include/asm/thread_info.h     |  2 -
 arch/riscv/include/asm/thread_info.h     |  1 -
 arch/s390/include/asm/thread_info.h      |  1 -
 arch/sparc/include/asm/thread_info_32.h  |  1 -
 arch/um/include/asm/thread_info.h        |  1 -
 arch/unicore32/include/asm/thread_info.h |  1 -
 arch/xtensa/include/asm/thread_info.h    |  1 -
 include/linux/sched.h                    |  5 --
 include/linux/sched/signal.h             | 84 +-------------------------------
 kernel/ptrace.c                          | 15 ++----
 kernel/signal.c                          | 56 +++++++++------------
 virt/kvm/kvm_main.c                      | 11 +----
 22 files changed, 31 insertions(+), 160 deletions(-)

Eric
