Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:42570 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbbEFL4s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2015 07:56:48 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
	Wed, 6 May 2015 17:26:45 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 2/3] kvm/x86: report guest steal time in host
Date: Wed,  6 May 2015 17:26:35 +0530
Message-ID: <356cdc25b8339ab742b349d1432c69fbdeeb204d.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de, mingo@redhat.com, ego@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com
Message-ID: <20150506115635.Po6bfI7H9-mQJ97ULyzSMjH95a_Qb1ChJzDAegguj5o@z>

Report guest steal time in host task statistics. On x86, this is just
the scheduler run_delay.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c73efcd..7107b7d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2128,6 +2128,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.st.steal.steal += vcpu->arch.st.accum_steal;
 	vcpu->arch.st.steal.version += 2;
+	current->gstime += vcpu->arch.st.accum_steal;
 	vcpu->arch.st.accum_steal = 0;
 
 	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-- 
2.3.7

