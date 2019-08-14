Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f172.google.com ([209.85.214.172]:38989 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNPLs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 11:11:48 -0400
Subject: [PATCH 0/2] tools/memory-model: Update comment of jugdelitmus.sh
References: <20190801222026.GA11315@linux.ibm.com>
 <20190801222056.12144-27-paulmck@linux.ibm.com>
 <beb07965-eb83-9cd1-2b49-cfc24928dce5@gmail.com>
 <20190812180649.GM28441@linux.ibm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <277937a7-0f50-ec1c-09ec-95ffbf85541e@gmail.com>
Date: Thu, 15 Aug 2019 00:11:36 +0900
MIME-Version: 1.0
In-Reply-To: <20190812180649.GM28441@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>
Message-ID: <20190814151136.p5VQ_QxKqtJmd5WG3AZEupUTOi7XBVRNqPnadVIq4Fw@z>

Hi Paul,

I see some inconsistency between the header comment of judgelitmus.sh
and the updated script.

This patch set updates the header. It is relative to current lkmm-dev
of -rcu.

Patch 1/2 corresponds to ("tools/memory-model: Move from
.AArch64.litmus.out to .litmus.AArch.out").

Patch 2/2 corresponds to ("tools/memory-model: Add data-race
capabilities to judgelitmus.sh").

You should be able to use each patch as a fix-up commit respectively.
I'm OK either with them applied at the head of the branch or
with them merged into your commits.

        Thanks, Akira
--
Akira Yokosawa (2):
  tools/memory-model: Reflect updated file name convention in
    judgelitmus.sh
  tools/memory-model: Mention data-race capability in jugdelitmus.sh's
    header

 tools/memory-model/scripts/judgelitmus.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.17.1
