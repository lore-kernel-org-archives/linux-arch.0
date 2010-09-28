Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40261 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995Ab0I1C5Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 22:57:16 -0400
Date: Tue, 28 Sep 2010 03:57:12 +0100
Subject: [patches] avr32 signal fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <E1P0QNV-0008RZ-1H@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hans-christian.egtvedt@atmel.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100928025712.HJQ7HpzFblqbEAfg13UFRg1uekYmA7hqpC1z_KA9tVw@z>


	Most of that stuff is quite obvious; the interesting
part is #6; there I'd taken a large chunk out of the asm glue
and hopefully sanitized it into something that just might
work correctly wrt syscall restarts.

