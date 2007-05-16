Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:37708 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011AbXEPQfF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 May 2007 12:35:05 -0400
Subject: [RFC] Explicitly mark global functions with vmlinux with __global
From: David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Date: Thu, 17 May 2007 00:34:33 +0800
Message-Id: <1179333273.2859.282.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

A while ago, I played with using '-fwhole-program --combine' for
building kernel objects -- http://lwn.net/Articles/197097/

A found a few compiler bugs which I think should mostly be fixed now, so
I'm revisiting the kernel bits. The original patches I had looked
something like this:

http://david.woodhou.se/combine/combine-diff-1-fixes.patch
http://david.woodhou.se/combine/combine-diff-2-core.patch
http://david.woodhou.se/combine/combine-diff-3-global.patch
http://david.woodhou.se/combine/combine-diff-4-hacks.patch

Essentially, it added a CONFIG_COMBINED_COMPILE option which would build
every multi-part object (including built-in.o) with the -fwhole-program
and --combine flags. We saw savings of up to 14% in size in a few
places, and a more realistic 5-6% in many more.

Since -fwhole-program makes the compiler assume everything is 'static' I
needed to explicitly mark some stuff as _not_ static, if it was used by
other things outside the same directory. EXPORT_SYMBOL could obviously
be used for that, but then there were some things which were global
_within_ vmlinux but not exported to modules -- and marking those with
__global was the majority of the patchset above; the third patch.

Before I steam ahead and do it all again, I'd like to revisit that. My
old patches had
	 #define __global __attribute__((externally_visible,used))
and went on to look a bit like the patch below. For the OLPC test build
I was playing with, I had:
 75 files changed, 238 insertions(+), 239 deletions(-)

Another way of doing it would be to add an 'EXPORT_SYMBOL_INTERNAL' or
some such, instead of __global. To be perfectly honest, I don't recall
my reasons for choosing __global over that.

Anyway, the point of the RFC... should I go ahead with creating patches
which add this __global marking where it's needed (it can be a no-op for
now anyway)? Or does anyone have any better plans? It wouldn't be as
_much_ of a pain for Andrew as the irc_reqs thing was, but it's possibly
still worth co-ordinating it -- if I go ahead and do it, when would be
the best time to merge it?

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 65814b0..f5c63c8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3037,7 +3037,7 @@ static struct kobj_type md_ktype = {
        .default_attrs  = md_default_attrs,
 };
 
-int mdp_major = 0;
+int __global mdp_major = 0;
 
 static struct kobject *md_probe(dev_t dev, int *part, void *data)
 {
@@ -5747,13 +5747,12 @@ static int __init md_init(void)
 static dev_t detected_devices[128];
 static int dev_cnt;
 
-void md_autodetect_dev(dev_t dev)
+void __global md_autodetect_dev(dev_t dev)
 {
        if (dev_cnt >= 0 && dev_cnt < 127)
                detected_devices[dev_cnt++] = dev;
 }
 
-
 static void autostart_arrays(int part)
 {
        mdk_rdev_t *rdev;

What I had before was...

 arch/i386/mm/extable.c         |    2 -
 arch/i386/mm/fault.c           |   10 ++++----
 arch/i386/mm/hugetlbpage.c     |   14 +++++------
 arch/i386/mm/init.c            |   26 +++++++++++-----------
 arch/i386/mm/ioremap.c         |    4 +--
 arch/i386/mm/mmap.c            |    2 -
 arch/i386/mm/pgtable.c         |   12 +++++-----
 drivers/ide/ppc/pmac.c         |    2 -
 drivers/md/md.c                |    5 +---
 drivers/video/fbcvt.c          |    2 -
 fs/aio.c                       |    6 ++---
 fs/bio.c                       |    8 +++---
 fs/block_dev.c                 |    2 -
 fs/buffer.c                    |   10 ++++----
 fs/char_dev.c                  |    2 -
 fs/compat.c                    |    4 +--
 fs/dcache.c                    |    8 +++---
 fs/devpts/inode.c              |    6 ++---
 fs/dnotify.c                   |    2 -
 fs/drop_caches.c               |    4 +--
 fs/exec.c                      |   12 +++++-----
 fs/fcntl.c                     |    6 ++---
 fs/file.c                      |    8 +++---
 fs/file_table.c                |   16 ++++++-------
 fs/filesystems.c               |    2 -
 fs/fs-writeback.c              |    4 +--
 fs/hugetlbfs/inode.c           |   10 ++++----
 fs/inode.c                     |    8 +++---
 fs/inotify_user.c              |    2 -
 fs/locks.c                     |    8 +++---
 fs/namei.c                     |    4 +--
 fs/namespace.c                 |   12 +++++-----
 fs/pipe.c                      |    4 +--
 fs/proc/base.c                 |    2 -
 fs/proc/generic.c              |    2 -
 fs/proc/kcore.c                |    2 -
 fs/proc/proc_devtree.c         |   10 ++++----
 fs/proc/proc_tty.c             |    4 +--
 fs/proc/root.c                 |    4 +--
 fs/ramfs/inode.c               |    2 -
 fs/splice.c                    |    2 -
 fs/super.c                     |    8 +++---
 init/calibrate.c               |    2 -
 init/do_mounts.c               |   11 ++++-----
 init/do_mounts_initrd.c        |    7 +++--
 init/do_mounts_rd.c            |    4 +--
 init/main.c                    |   14 +++++------
 ipc/compat.c                   |   14 +++++------
 ipc/msg.c                      |    6 ++---
 ipc/sem.c                      |    6 ++---
 ipc/shm.c                      |    8 +++---
 kernel/sys_ni.c                |    1 
 net/core/dev.c                 |   10 ++++----
 net/core/dv.c                  |    3 --
 net/core/flow.c                |    2 -
 net/core/iovec.c               |    3 +-
 net/core/neighbour.c           |    4 +--
 net/core/request_sock.c        |    2 -
 net/core/rtnetlink.c           |    4 +--
 net/core/skbuff.c              |    2 -
 net/core/sock.c                |   10 ++++----
 net/core/sysctl_net_core.c     |    2 -
 net/core/user_dma.c            |    4 +--
 net/ipv4/inet_hashtables.c     |    4 +--
 net/ipv4/sysctl_net_ipv4.c     |    2 -
 net/ipv4/tcp_timer.c           |    3 --
 net/netfilter/core.c           |    2 -
 net/sched/sch_generic.c        |   10 ++++----
 net/xfrm/xfrm_policy.c         |    4 +--
 security/selinux/avc.c         |    4 +--
 security/selinux/exports.c     |   10 ++++----
 security/selinux/hooks.c       |    4 +--
 security/selinux/netlink.c     |    2 -
 security/selinux/ss/policydb.c |    2 -
 security/selinux/ss/services.c |   48 ++++++++++++++++++++---------------------
 75 files changed, 238 insertions(+), 239 deletions(-)

-- 
dwmw2

