Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:27572 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbYDVSty (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 14:49:54 -0400
From: Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH 0/11] Generic smp_call_function() #2
Date: Tue, 22 Apr 2008 20:50:16 +0200
Message-ID: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org
Cc: peterz@infradead.org, sam@ravnborg.org
Message-ID: <20080422185016.IGEoq70XH9-gl4YijcfloO6uAyTJbYj8ves4T_Y-mnk@z>

Hi,

OK, so here's version #2 of the patchset. Changes since the last
posting:

- Better Kconfig setup, thanks Sam.
- Fix data leak, thanks Linus.
- Misplaced sparc64 bit in the s390 patch, thanks Martin.
- Arm should work, thanks Catalin.

-- 
Jens Axboe


