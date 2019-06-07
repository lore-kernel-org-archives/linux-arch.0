Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:53098 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbfFGVmN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 17:42:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
        <20190529161157.GA27659@redhat.com>
        <20190604134117.GA29963@redhat.com>
        <20190606140814.GA13440@redhat.com> <87k1dxaxcl.fsf_-_@xmission.com>
Date: Fri, 07 Jun 2019 16:41:58 -0500
In-Reply-To: <87k1dxaxcl.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 07 Jun 2019 16:39:54 -0500")
Message-ID: <878sudax95.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [RFC PATCH 2/5] signal/kvm:  Stop using sigprocmask in kvm_sigset_(activate|deactivate)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de, axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, omar.kilani@gmail.com, tglx@linutronix.de, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, David Laight <David.Laight@ACULAB.COM>, linux-arch@vger.kernel.org
Message-ID: <20190607214158.GSew5U9umtlQ-BmZpmMfInGu8b-oArtJGS8ozXIP8R4@z>


Instead of jumping through hoops call __set_current_blocked directly.
As well as directly manipulating real_blocked.

This is in preparation for modifying the code to always keep
real_blocked in sync with blocked except in the rare cases when the
kernel needs to override it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 virt/kvm/kvm_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f0d13d9d125d..8575a1010bfc 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2240,7 +2240,8 @@ void kvm_sigset_activate(struct kvm_vcpu *vcpu)
 	 * ->real_blocked don't care as long ->real_blocked is always a subset
 	 * of ->blocked.
 	 */
-	sigprocmask(SIG_SETMASK, &vcpu->sigset, &current->real_blocked);
+	current->real_blocked = current->blocked;
+	__set_current_blocked(&vcpu->sigset);
 }
 
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
@@ -2248,7 +2249,7 @@ void kvm_sigset_deactivate(struct kvm_vcpu *vcpu)
 	if (!vcpu->sigset_active)
 		return;
 
-	sigprocmask(SIG_SETMASK, &current->real_blocked, NULL);
+	__set_current_blocked(&current->real_blocked);
 	sigemptyset(&current->real_blocked);
 }
 
-- 
2.21.0.dirty
