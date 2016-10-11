Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:41467 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbcJKSFR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Oct 2016 14:05:17 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Is conditional calling of restore_altstack() correct for ARC
Message-ID: <c8ead7fd-9444-da25-74e9-f755da6296d5@synopsys.com>
Date: Tue, 11 Oct 2016 11:04:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20161011180441.NPdAdpGN5Yx0pjazFzk5BYsNEnnMZpD_bwL65ONgqGc@z>

Hi Al,

I spotted a possible anomaly with ARC sigaltstack() handling and was wondering if
you could confirm if it was wrong (I don't have a test case to prove one way or
the other).

We have a micro-optimization which elides calling restore_altstack() in sigreturn
path, based on a "magic" value, set at the time of sigaction (SA_SIGINFO). So
essentially we only restore ss_{sp,size,flags} if SA_SIGINFO was set.

Do you think this needs to be done unconditionally like other ports do ?

Thx,
-Vineet


