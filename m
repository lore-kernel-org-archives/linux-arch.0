Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:35870 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965105AbeALUan (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jan 2018 15:30:43 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87373b6ghs.fsf@xmission.com>
Date: Fri, 12 Jan 2018 14:29:55 -0600
In-Reply-To: <87373b6ghs.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 11 Jan 2018 18:57:35 -0600")
Message-ID: <87vag6zupo.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 0/2] siginfo fixes
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>, linux-arch@vger.kernel.org
Message-ID: <20180112202955.un9m053hWO1L5zP1mFZjlQeljbUyQgof6KgjhgSUIpM@z>


These are two additional siginfo fixes I overlooked yesterday.
Thankfully the confusion was not arch specific, and did not set an ABI
to userspace that I had to worry about breaking, so I could fix these
two issues properly.

Eric W. Biederman (2):
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy
      x86/mm/pkeys: Fix fill_sig_info_pkey

 arch/mn10300/mm/misalignment.c | 2 +-
 arch/x86/mm/fault.c            | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)
