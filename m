From: Al Viro <viro@ftp.linux.org.uk>
Subject: [patches] avr32 signal fixes
Date: Tue, 28 Sep 2010 03:57:12 +0100
Message-ID: <E1P0QNV-0008RZ-1H@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hans-christian.egtvedt@atmel.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


	Most of that stuff is quite obvious; the interesting
part is #6; there I'd taken a large chunk out of the asm glue
and hopefully sanitized it into something that just might
work correctly wrt syscall restarts.
