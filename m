From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [GIT PULL] siginfo updares for 4.17-rc1
Date: Thu, 05 Apr 2018 11:14:03 -0500
Message-ID: <87sh898wc4.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 4be33329d46f80e87afe7db61271d1370607260a m68k: Verify the offsets in struct siginfo never change.

The work on cleaning up and getting the bugs out of siginfo generation
was largely stalled this round.  The progress that was made was the
definition of FPE_FLTUNK.  Which is usable to fix many of the cases
where siginfo generation is erroneously generating SI_USER by setting
si_code to 0, that has recently been tagged as FPE_FIXME.

You already have the change by way of the arm64 tree as that definition
was pulled into the arm64 tree to allow fixing the problem there.

What remains is the second round of fixing for what I thought was a
trivial change to the struct siginfo when put the union in _sigfault
where it belongs.  Do to historical reasons 32bit m68k only ensures that
pointers are 2 byte aligned.  So I have added a m68k test case made of
BUILD_BUG_ONs to verify I have this fix correct and possibly catch
problems, and I have computed the number of bytes of padding needed for
the _addr_bnd and _addr_pkey cases and just use an array of characters
that size.

For pure paranoia I have written the code so if there is an architecture
out there that does not perform any alignment of structures it should
still work.

With the removal of all of the stale arechitectures this cycle future
work on cleaning up struct siginfo should be much easier.  Almost all
of the conflicting si_code definitions have been removed with
the removal of (blackfin, tile, and frv).   Plus some of the most
difficult to test cases have simply been removed from the tree.

Which means that with a little luck copy_siginfo_to_user can
become a light weight wrapper around copy_to_user in the next
cycle.

Dave Martin (1):
      signal: Add FPE_FLTUNK si_code for undiagnosable fp exceptions

Eric W. Biederman (2):
      signal: Correct the offset of si_pkey and si_lower in struct siginfo on m68k
      m68k: Verify the offsets in struct siginfo never change.

 arch/m68k/kernel/signal.c          | 62 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/signal_compat.c    |  2 +-
 include/linux/compat.h             |  6 ++--
 include/uapi/asm-generic/siginfo.h | 10 ++++--
 4 files changed, 74 insertions(+), 6 deletions(-)

Eric
