From: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/11] Generic smp_call_function() #2
Date: Tue, 22 Apr 2008 20:50:16 +0200
Message-ID: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

Hi,

OK, so here's version #2 of the patchset. Changes since the last
posting:

- Better Kconfig setup, thanks Sam.
- Fix data leak, thanks Linus.
- Misplaced sparc64 bit in the s390 patch, thanks Martin.
- Arm should work, thanks Catalin.

-- 
Jens Axboe
