From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 0/4] stack based kmap_atomic -v2
Date: Fri, 09 Oct 2009 01:22:26 +0200
Message-ID: <20091008232226.768382977@chello.nl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932254AbZJHX06@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, Ingo Molnar <mingo@elte.hu>, David Howells <dh>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Latest bits..

Maybe FRV can do a kind of kmap-stack switch on (soft)irq enter/exit
in order to stay below 5 entries.

Will continue prodding tomorrow, sleep time here.
