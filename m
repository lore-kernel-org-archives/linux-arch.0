From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] vfs.git: poll annotations
Date: Thu, 1 Feb 2018 22:00:01 +0000
Message-ID: <20180201220001.GE30522@ZenIV.linux.org.uk>
References: <20180130183939.GB29051@ZenIV.linux.org.uk>
 <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
 <20180131031300.GE29051@ZenIV.linux.org.uk>
 <CA+55aFyMh_cHUb37X6=8=DU2Zm8Cz=mhXYJcGGWqiC8LKLAoFA@mail.gmail.com>
 <20180131044620.GF29051@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40600 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeBAWAE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Feb 2018 17:00:04 -0500
Content-Disposition: inline
In-Reply-To: <20180131044620.GF29051@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Wed, Jan 31, 2018 at 04:46:20AM +0000, Al Viro wrote:
> On Tue, Jan 30, 2018 at 07:19:19PM -0800, Linus Torvalds wrote:
> > On Tue, Jan 30, 2018 at 7:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > As for the place for mangle/demangle... where would you prefer them?
> > 
> > If we can make gcc generate ok code for the generic case and not need
> > any arch-specific ones, why not just do in <linux/poll.h>?
> 
> Umm...  I'll try and see how well does that work.

FWIW, it does generate sane code and bulk rename itself is not hard.
What I've got is in vfs.git#work.poll:
      smc: missing poll annotations
      xen: fix poll misannotation
      use linux/poll.h instead of asm/poll.h
      add EPOLLNVAL, annotate EPOLL... and event_poll->event
      preparation to switching ->poll() to returning EPOLL...
      ep_send_events_proc(): return result via esed->res
      annotate ep_scan_ready_list()
      switch users of kernel-side POLL... to EPOLL...
      unify {de,}mangle_poll(), get rid of kernel-side POLL...
The first 7 commits are preparation, then mechanical bulk rename with
for V in IN OUT PRI ERR RDNORM RDBAND WRNORM WRBAND HUP RDHUP NVAL MSG; do
  L=`git grep -l -w POLL$V | grep -v '^t' | grep -v /um/ | grep -v '^sa' | grep -v '/poll.h$'|grep -v '^D'`
  for f in $L; do sed -i "-es/^\([^\"]*\)\(\<POLL$V\>\)/\\1E\\2/" $f; done
done
then consolidation of mangle_poll/demangle_poll and making those
ifndef __KERNEL__ poll.h unconditional.

FWIW, with the entire series applied __poll_t warnings (with CF=-D__CHECK_POLL)
are down to the following:

* genuine bugs in ->poll() instances, of the "return -EINVAL/-ERESTARTSYS/etc."
sort -
kernel/trace/ring_buffer.c:643:32:    expected restricted __poll_t
drivers/media/pci/saa7164/saa7164-vbi.c:632:24:    expected restricted __poll_t
drivers/media/pci/saa7164/saa7164-vbi.c:637:40:    expected restricted __poll_t
drivers/media/pci/saa7164/saa7164-vbi.c:647:40:    expected restricted __poll_t
drivers/media/platform/exynos-gsc/gsc-m2m.c:718:24:    expected restricted __poll_t
drivers/media/platform/s3c-camif/camif-capture.c:602:21:    expected restricted __poll_t [usertype] ret
drivers/media/radio/radio-wl1273.c:1099:24:    expected restricted __poll_t
drivers/platform/goldfish/goldfish_pipe.c:549:24:    expected restricted __poll_t
drivers/tty/n_r3964.c:1239:24:    expected restricted __poll_t [assigned] [usertype] result
drivers/uio/uio.c:505:24:    expected restricted __poll_t
drivers/xen/pvcalls-front.c:921:24:    expected restricted __poll_t
sound/core/seq/seq_clientmgr.c:1097:24:    expected restricted __poll_t
sound/core/seq/oss/seq_oss.c:206:24:    expected restricted __poll_t

* misannotation around SAA6588_CMD_POLL and struct saa6588_command -
drivers/media/i2c/saa6588.c:416:35:    right side has type restricted __poll_t
drivers/media/pci/bt8xx/bttv-driver.c:3347:20:    got restricted __poll_t [assigned] [usertype] res
drivers/media/pci/bt8xx/bttv-driver.c:3350:19:    expected restricted __poll_t
drivers/media/pci/saa7134/saa7134-video.c:1243:16: warning: restricted __poll_t degrades to integer
drivers/media/pci/saa7134/saa7134-video.c:1243:19:    expected restricted __poll_t

* misannotations around perf ring_buffer->poll -
kernel/events/core.c:4541:24:    expected restricted __poll_t [usertype] events
kernel/events/ring_buffer.c:22:39:    got restricted __poll_t [usertype] <noident>

IOW, not much and fairly low on false positives.

Are you OK with that approach?  I could send a pull request for the first 7
in that series (it should be bisect-safe), then you'd run the bulk rename
script just before -rc1 and apply the last one on top of that.
