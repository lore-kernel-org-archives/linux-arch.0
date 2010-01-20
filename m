Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.wifiinternet.cz ([89.31.42.6]:35055 "EHLO monstr.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752811Ab0ATKo0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Jan 2010 05:44:26 -0500
From: monstr@monstr.eu
Subject: Generic DMA - BUG_ON
Date: Wed, 20 Jan 2010 11:08:30 +0100
Message-ID: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com
Message-ID: <20100120100830.fqcU7EUszLoI5QEBEFOLfFtosNZxhr2RL7_Y1Kspy5w@z>

Hi All,

I have this patch in my repo. I just added BUG_ON for dma ops.
The reason for that is if driver not setup ops correctly than
the system do bad access to any memory space without any visible reason.
BUG_ON points to it and helps to solve where the problem is.

Thanks for your review,
Michal



