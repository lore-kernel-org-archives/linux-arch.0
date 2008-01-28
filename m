Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:38994 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764045AbYA1XTT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jan 2008 18:19:19 -0500
Date: Mon, 28 Jan 2008 16:19:18 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: down_killable implementations for every architecture
Message-ID: <20080128231918.GB31101@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


As part of the TASK_KILLABLE changes, we're going to need
down_killable().  Unfortunately, semaphores are implemented for every
architecture, which we should probably fix at some point.

On the plane ride down here, I did the necessary changes for each
architecture:

http://parisc-linux.org/~willy/down-killable/

I may have made mistakes.  Things to check:

 - The *_killable* functions should be exported for use by modules.
 - The down_killable implementation needs to check fatal_signal_pending,
   not signal_pending.
 - The task state needs to be set to TASK_KILLABLE, not
   TASK_INTERRUPTIBLE

It should only take a couple of minutes to verify your architecture.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
