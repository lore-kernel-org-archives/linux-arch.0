From: Oskar Andero <oskar.andero@sonymobile.com>
Subject: [PATCH v3 0/4] kprobes: split blacklist into common and arch
Date: Fri, 5 Apr 2013 15:26:36 +0200
Message-ID: <1365168400-17954-1-git-send-email-oskar.andero@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:6158 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161369Ab3DEN1M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Apr 2013 09:27:12 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, davem@davemloft.net, anil.s.keshavamurthy@intel.com, ananth@in.ibm.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>, radovan.lekanovic@sonymobile.com, bjorn.davidsson@sonymobile.com, oskar.andero@sonymobile.com

Hi,

This is version 3 of the patch-set for splitting arch and common kprobe
blackpoints.

Changes since last version are:
- 1/4: Add write memory barrier at blacklist initialization.
- 1/4: Change kprobe_blacklist_initialized type to boolean.
- 2/4: Fix racing of kprobe_blacklist.
- 2/4: Define arch_kprobes_blacksyms.* as __weak symbols.

-Oskar

Bj=C3=B6rn Davidsson (1):
  kprobes: move x86-specific blacklist symbols to arch directory

Oskar Andero (2):
  kprobes: split blacklist into common and arch
  kprobes: replace printk with pr_-functions

Toby Collett (1):
  kprobes: delay blacklist symbol lookup until we actually need it

 arch/x86/kernel/kprobes/core.c |   7 ++
 kernel/kprobes.c               | 159 +++++++++++++++++++++++++++------=
--------
 2 files changed, 112 insertions(+), 54 deletions(-)

--=20
1.8.1.5
