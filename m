From: Peter Zijlstra <peterz@infradead.org>
Subject: mips octeon memory model questions
Date: Tue, 4 Feb 2014 19:41:50 +0100
Message-ID: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: David Daney <ddaney@caviumnetworks.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Hi all,

I have a number of questions in regards to commit 6b07d38aaa520ce.

Given that the octeon doesn't reorder reads; the following:

"      sync
       ll ...
       .
       .
       .
       sc ...
       .
       .
       sync

  The second SYNC was redundant, but harmless.  "

Still doesn't make sense, because if we need the first sync to stop
writes from being re-ordered with the ll-sc, we also need the second
sync to avoid the same.

Suppose:
   STORE a
   sync
   LL-SC b
   (not a sync)
   STORE c

What avoids this becoming visible as:

  a
  c
  b

?

Then there is:

"       syncw;syncw
        ll
        .
        .
        .
        sc
        .
        .

    Has identical semantics to the first sequence, but is much faster.
    The SYNCW orders the writes, and the SC will not complete successfully
    until the write is committed to the coherent memory system.  So at the
    end all preceeding writes have been committed.  Since Octeon does not
    do speculative reads, this functions as a full barrier."

Read Documentation/memory-barrier.txt:TRANSITIVITY, the above doesn't
sound like syncw is actually multi-copy atomic, and therefore doesn't
provide transitivity, and therefore is not a valid sequence for
operations that are supposed to imply a full memory-barrier.

Please as to explain.
