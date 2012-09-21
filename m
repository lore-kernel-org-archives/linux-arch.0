From: Mark Salter <msalter@redhat.com>
Subject: Re: [RFC] status of execve() work - per-architecture patches solicited
Date: Fri, 21 Sep 2012 12:26:36 -0400
Message-ID: <1348244799-16013-1-git-send-email-msalter@redhat.com>
References: <20120917032651.GU13973@ZenIV.linux.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54736 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab2IUQ04 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Sep 2012 12:26:56 -0400
In-Reply-To: <20120917032651.GU13973@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>

Here are a set of c6x patches to work with your experimental-kernel_thread
branch.

Mark Salter (3):
  c6x: add ret_from_kernel_thread(), simplify kernel_thread()
  c6x: switch to generic kernel_execve
  c6x: switch to generic sys_execve

 arch/c6x/include/asm/syscalls.h |    5 ---
 arch/c6x/include/asm/unistd.h   |    3 ++
 arch/c6x/kernel/entry.S         |   56 +++++++++++++++++-------------------
 arch/c6x/kernel/process.c       |   60 ++++++++-------------------------------
 4 files changed, 41 insertions(+), 83 deletions(-)

-- 
1.7.9.1
