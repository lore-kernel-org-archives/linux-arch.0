Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:56806 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759452AbWLBK7S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:18 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809405nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:12 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 00/26] Dynamic kernel command-line
Date: Sat, 2 Dec 2006 12:47:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021247.43291.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Hello,

This is take 3 of submission, I submit this patch
once in a few monthes to collect some more signatures :)
Until now, I got three:
- avr32
- sh
- sh64

I know this is not one of major priorities, but it
should be simple enough to be reviewed and included.

I will also be happy to get a REJECT response, so I
stop trying to get it included. Any suggestions of
how to push this farward will also be appreciated.

Current implementation stores a static command-line
buffer allocated to COMMAND_LINE_SIZE size. Most
architectures stores two copies of this buffer, one
for future reference and one for parameter parsing.

Current kernel command-line size for most architecture
is much too small for module parameters, video settings,
initramfs paramters and much more. The problem is that
setting COMMAND_LINE_SIZE to a grater value, allocates
static buffers.

In order to allow a greater command-line size, these
buffers should be dynamically allocated or marked
as init disposable buffers, so unused memory can be
released.

This patch renames the static saved_command_line
variable into boot_command_line adding __initdata
attribute, so that it can be disposed after
initialization. This rename is required so applications
that use saved_command_line will not be affected
by this change.

It reintroduces saved_command_line as dynamically
allocated buffer to match the data in boot_command_line.

It also mark secondary command-line buffer as __initdata,
and copies it to dynamically allocated static_command_line
buffer components may hold reference to it after
initialization.

This patch is for linux-2.6.19 and is divided to
target each architecture. I could not check this in any
architecture so please forgive me if I got it wrong.

The per-architecture modification is very simple, use
boot_command_line in place of saved_command_line. The
common code is the change into dynamic command-line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

