Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36576 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965095AbXDAUz0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Apr 2007 16:55:26 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: missing syscalls
Date: Sun, 1 Apr 2007 22:54:53 +0200
References: <20070401160123.GA9178@uranus.ravnborg.org>
In-Reply-To: <20070401160123.GA9178@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704012254.53224.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> ============== x86_64 ================
>   CALL    /home/sam/kernel/kbuild.git/scripts/checksyscalls.sh
> <stdin>:1356:2: warning: #warning syscall getcpu not implemented

It's implemented as a vsyscall.

> <stdin>:1360:2: warning: #warning syscall epoll_pwait not implemented

That one is missing.

-Andi
