Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41513 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeIXQq3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 12:46:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so15848612edd.8
        for <linux-arch@vger.kernel.org>; Mon, 24 Sep 2018 03:45:01 -0700 (PDT)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH] tools/memory-model: Model smp_mb__after_unlock_lock()
Date: Mon, 24 Sep 2018 12:44:49 +0200
Message-ID: <20180924104449.8211-1-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20180924104449.reOtgj1zvY8JXw6xJd_uzcHZvDsIiyvPgR9bp7eG94g@z>
