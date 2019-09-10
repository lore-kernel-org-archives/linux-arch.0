From: Arnd Bergmann <arnd@arndb.de>
Subject: [GIT PULL] ipc: fix regressions from y2038 patches
Date: Tue, 10 Sep 2019 11:49:00 +0200
Message-ID: <CAK8P3a1Q0ec50n2ueWDKHirpem+SQvsv3sYXzw9EFRqXiUqxUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Anatoly Pugachev <matorola@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guo Ren <guoren@kernel.org>, Stafford Horne <shorne@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/ipc-fixes

for you to fetch changes up to fb377eb80c80339b580831a3c0fcce34a4c9d1ad:

  ipc: fix sparc64 ipc() wrapper (2019-09-07 21:42:25 +0200)

----------------------------------------------------------------
ipc: fix regressions from y2038 patches

These are two regression fixes for bugs that got introduced
during the system call rework that went into linux-5.1
but only bisected and fixed now:

- One patch affects semtimedop() on many of the less
  common 32-bit architectures, this just needs a single-line
  bugfix.

- The other affects only sparc64 and has a slightly more
  invasive workaround to apply the same change to sparc64
  that was done to the generic code used everywhere else.

----------------------------------------------------------------
Arnd Bergmann (2):
      ipc: fix semtimedop for generic 32-bit architectures
      ipc: fix sparc64 ipc() wrapper

 arch/sparc/kernel/sys_sparc_64.c  | 33 ++++++++++++++++++---------------
 include/linux/syscalls.h          | 19 +++++++++++++++++++
 include/uapi/asm-generic/unistd.h |  2 +-
 ipc/util.h                        | 25 ++-----------------------
 4 files changed, 40 insertions(+), 39 deletions(-)
