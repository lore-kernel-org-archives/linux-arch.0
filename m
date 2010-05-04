From: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC][PATCH 9/12] KVM: introduce a wrapper function of
 set_bit_user_non_atomic()
Date: Tue, 4 May 2010 22:06:20 +0900
Message-ID: <20100504220620.97e90535.takuya.yoshikawa@gmail.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100504215645.6448af8f.takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

This is not to break the build for other architectures than x86 and ppc.

Signed-off-by: Takuya Yoshikawa <yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
Signed-off-by: Fernando Luis Vazquez Cao <fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
---
 arch/ia64/include/asm/kvm_host.h    |    5 +++++
 arch/powerpc/include/asm/kvm_host.h |    6 ++++++
 arch/s390/include/asm/kvm_host.h    |    6 ++++++
 arch/x86/include/asm/kvm_host.h     |    5 +++++
 4 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/include/asm/kvm_host.h b/arch/ia64/include/asm/kvm_host.h
index a362e67..938041b 100644
--- a/arch/ia64/include/asm/kvm_host.h
+++ b/arch/ia64/include/asm/kvm_host.h
@@ -589,6 +589,11 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu);
 int kvm_pal_emul(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run);
 void kvm_sal_emul(struct kvm_vcpu *vcpu);
 
+static inline int kvm_set_bit_user(int nr, void __user *addr)
+{
+	return 0;
+}
+
 #endif /* __ASSEMBLY__*/
 
 #endif
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 0c9ad86..9463524 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <linux/kvm_types.h>
 #include <asm/kvm_asm.h>
+#include <asm/uaccess.h>
 
 #define KVM_MAX_VCPUS 1
 #define KVM_MEMORY_SLOTS 32
@@ -287,4 +288,9 @@ struct kvm_vcpu_arch {
 #endif
 };
 
+static inline int kvm_set_bit_user(int nr, void __user *addr)
+{
+	return set_bit_user_non_atomic(nr, addr);
+}
+
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 27605b6..36710ee 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -238,4 +238,10 @@ struct kvm_arch{
 };
 
 extern int sie64a(struct kvm_s390_sie_block *, unsigned long *);
+
+static inline int kvm_set_bit_user(int nr, void __user *addr)
+{
+	return 0;
+}
+
 #endif
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3f0007b..9e22df9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -795,4 +795,9 @@ void kvm_set_shared_msr(unsigned index, u64 val, u64 mask);
 
 bool kvm_is_linear_rip(struct kvm_vcpu *vcpu, unsigned long linear_rip);
 
+static inline int kvm_set_bit_user(int nr, void __user *addr)
+{
+	return set_bit_user_non_atomic(nr, addr);
+}
+
 #endif /* _ASM_X86_KVM_HOST_H */
-- 
1.7.0.4
