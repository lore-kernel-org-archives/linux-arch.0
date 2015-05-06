From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 2/3] kvm/x86: report guest steal time in host
Date: Wed,  6 May 2015 16:28:44 +0530
Message-ID: <eb56ce41d29c43529bc390d5ea2d5aaab191c918.1429696326.git.naveen.n.rao__29748.3722134077$1430910012$gmane$org@linux.vnet.ibm.com>
References: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1429696326.git.naveen.n.rao@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de, mingo@redhat.com, ego@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Report guest steal time in host task statistics. On x86, this is just
the scheduler run_delay.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/x86/kvm/x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0ee725f..737b0e4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2094,6 +2094,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.st.steal.steal += vcpu->arch.st.accum_steal;
 	vcpu->arch.st.steal.version += 2;
+	current->gstime += vcpu->arch.st.accum_steal;
 	vcpu->arch.st.accum_steal = 0;
 
 	kvm_write_guest_cached(vcpu->kvm, &vcpu->arch.st.stime,
-- 
2.3.5
