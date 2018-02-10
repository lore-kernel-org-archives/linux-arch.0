From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [git pull] poll annotations - second round
Date: Sat, 10 Feb 2018 19:23:56 +0000
Message-ID: <20180210192356.GP30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

	Preparations to solving the problems you've mentioned in the original poll
series.  After this series, run

for V in IN OUT PRI ERR RDNORM RDBAND WRNORM WRBAND HUP RDHUP NVAL MSG; do
    L=`git grep -l -w POLL$V | grep -v '^t' | grep -v /um/ | grep -v '^sa' | grep -v '/poll.h$'|grep -v '^D'`
    for f in $L; do sed -i "-es/^\([^\"]*\)\(\<POLL$V\>\)/\\1E\\2/" $f; done
done

(ideally - just before -rc1) for bulk search-and-replace.  Then cherry-pick
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git#work.poll on top
of that and we should be done with that stuff - {de,}mangle_poll() unified,
no more separate kernel-side POLL... definitions.

Basically, that's what you suggested wrt KPOLL..., except that we can use
EPOLL... instead - they already are arch-independent (and equal to what is
currently kernel-side POLL...).  After the preparations (in this series)
switch to returning EPOLL... from ->poll() instances is completely mechanical
and kernel-side POLL... can go away.  The last step (killing kernel-side
POLL... and unifying {de,}mangle_poll() has to be done after the
search-and-replace job, since we need userland-side POLL... for unified
{de,}mangle_poll(), thus the cherry-pick at the last step.

After that we get
	* POLL{IN,OUT,...} *not* in __poll_t, so any stray instances of ->poll()
still using those will be caught by sparse.
	* eventpoll.c and select.c warning-free wrt __poll_t
	* no more kernel-side definitions of POLL... - userland ones are
visible through the entire kernel (and used pretty much only for mangle/demangle)
	* same behavior as after the first series (i.e. sparc et.al. epoll(2)
working correctly).

The following changes since commit b2fe5fa68642860e7de76167c3111623aa0d5de1:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next (2018-01-31 14:31:10 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.poll2

for you to fetch changes up to d85e2aa2e34dac793e70b900d865f48c69ecbc27:

  annotate ep_scan_ready_list() (2018-02-01 16:30:06 -0500)

----------------------------------------------------------------
Al Viro (7):
      smc: missing poll annotations
      xen: fix poll misannotation
      use linux/poll.h instead of asm/poll.h
      add EPOLLNVAL, annotate EPOLL... and event_poll->event
      preparation to switching ->poll() to returning EPOLL...
      ep_send_events_proc(): return result via esed->res
      annotate ep_scan_ready_list()

 drivers/xen/pvcalls-front.h    |  2 +-
 fs/coda/psdev.c                |  2 +-
 fs/debugfs/file.c              |  2 +-
 fs/eventpoll.c                 | 41 +++++++++++++++++++++++------------------
 fs/fcntl.c                     |  2 +-
 include/linux/poll.h           |  3 ++-
 include/uapi/linux/eventpoll.h | 33 +++++++++++++++++----------------
 net/smc/af_smc.c               |  2 +-
 8 files changed, 47 insertions(+), 40 deletions(-)
