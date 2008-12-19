From: y@redhat.com
Subject: [PATCH v5 0/6] Add preadv & pwritev system calls.
Date: Fri, 19 Dec 2008 16:58:19 +0100
Message-ID: <31732.1622315378$1229702439@news.gmane.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:36392 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbYLSP6f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Dec 2008 10:58:35 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Cc: aarcange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

  Hi folks,

Next round of the preadv & pwritev patch series, addressing review
comments:

 * Common code for the compat syscall versions is factored
   out in preparing patches.  
 * Added prototypes to syscall.h
 * Fixup some whitespace damage.

It's also the last release before I fall off the internet for the x-mas
and new-year holidays.  I'll be online again starting Jan 5th and will
deal with the remaining issues (if any) then.

cheers,
  Gerd
