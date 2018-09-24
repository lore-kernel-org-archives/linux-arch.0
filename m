From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [REVIEW][PATCH 0/2] signal/arc: siginfo cleanups
Date: Mon, 24 Sep 2018 16:47:44 +0200
Message-ID: <874lef2bqn.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>
List-Id: linux-arch.vger.kernel.org


I have been slowly cleaning up the architectues ever since I discovered
that the pattern of passing in struct siginfo is error prone, and
occassionally results in borken siginfo being sent to userspace.

What is happening on arc is pretty tame and I have compile tested
these changes, so I don't expect problems.

Still I would appreciate if people can look over the code and perhaps
test it and see if they can spot anything that has perhaps gone wrong.
appreciate it.

My intention is to merge this through my siginfo tree.  If you feel it
should go through your arch tree let me know.   All of the prerequisites
should have been merged several releases ago.

Eric W. Biederman (2):
      signal/arc: Push siginfo generation into unhandled_exception
      signal/arc: Use force_sig_fault where appropriate

 arch/arc/kernel/traps.c | 22 ++++++++--------------
 arch/arc/mm/fault.c     | 20 +++++---------------
 2 files changed, 13 insertions(+), 29 deletions(-)
