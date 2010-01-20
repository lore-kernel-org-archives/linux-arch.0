From: monstr@monstr.eu
Subject: Generic DMA - BUG_ON
Date: Wed, 20 Jan 2010 11:08:30 +0100
Message-ID: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753246Ab0ATKog@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com
List-Id: linux-arch.vger.kernel.org

Hi All,

I have this patch in my repo. I just added BUG_ON for dma ops.
The reason for that is if driver not setup ops correctly than
the system do bad access to any memory space without any visible reason.
BUG_ON points to it and helps to solve where the problem is.

Thanks for your review,
Michal
