From: Ley Foon Tan <lftan@altera.com>
Subject: Generic syscall ABI support
Date: Thu, 28 Mar 2013 11:09:42 +0800
Message-ID: <1364440182.2289.45.camel@leyfoon-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from co1ehsobe002.messaging.microsoft.com ([216.32.180.185]:25288
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753251Ab3C1DJv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Mar 2013 23:09:51 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, arnd@arndb.de
Cc: linux-arch@vger.kernel.org

Need advise regarding the generic syscall ABI support.

We are planning to upstream our Nios II kernel (arch/nios2) to mainline.
But it doesn't support generic syscall ABI yet (It requires an updated
Glibc port as well). 

The question is, is it a requirement for new arch to support generic
syscall ABI when upstreaming? Can we upstream a non-generic syscall ABI
first and migrate to generic syscall ABI in future?
Thanks.

Regards
LFTAN
