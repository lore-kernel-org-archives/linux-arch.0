Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39164 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753948AbeAKCJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 21:09:42 -0500
Received: by mail-pg0-f65.google.com with SMTP id z20so1620814pgv.6
        for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2018 18:09:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 36/38] kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl
Date: Wed, 10 Jan 2018 18:03:08 -0800
Message-ID: <1515636190-24061-37-git-send-email-keescook@chromium.org>
In-Reply-To: <1515636190-24061-1-git-send-email-keescook@chromium.org>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>, kernel-hardening@lists.openwall.com, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Windsor <dave@nullcore.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Rik van Riel <riel@redhat.com>, Matthew Garrett <mjg59@google.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20180111020308.STKIgDahugNoAcH01X1YQHEudc9Otr7teJ4LAm6P45Y@z>

From: Paolo Bonzini <pbonzini@redhat.com>

This ioctl is obsolete (it was used by Xenner as far as I know) but
still let's not break it gratuitously...  Its handler is copying
directly into struct kvm.  Go through a bounce buffer instead, with
the added benefit that we can actually do something useful with the
flags argument---the previous code was exiting with -EINVAL but still
doing the copy.

This technically is a userspace ABI breakage, but since no one should be
using the ioctl, it's a good occasion to see if someone actually
complains.

Cc: kernel-hardening@lists.openwall.com
Cc: Kees Cook <keescook@chromium.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kvm/x86.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eee8e7faf1af..6c16461e3a86 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4238,13 +4238,14 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_XEN_HVM_CONFIG: {
+		struct kvm_xen_hvm_config xhc;
 		r = -EFAULT;
-		if (copy_from_user(&kvm->arch.xen_hvm_config, argp,
-				   sizeof(struct kvm_xen_hvm_config)))
+		if (copy_from_user(&xhc, argp, sizeof(xhc)))
 			goto out;
 		r = -EINVAL;
-		if (kvm->arch.xen_hvm_config.flags)
+		if (xhc.flags)
 			goto out;
+		memcpy(&kvm->arch.xen_hvm_config, &xhc, sizeof(xhc));
 		r = 0;
 		break;
 	}
-- 
2.7.4
