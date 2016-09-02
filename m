Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753834AbcIBOJR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Sep 2016 10:09:17 -0400
Date: Fri, 2 Sep 2016 16:09:13 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 05/20] x86: Add the Secure Memory Encryption cpu
 feature
Message-ID: <20160902140913.GA23808@nazgul.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223622.29880.17779.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223622.29880.17779.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160902140913.vb3hvzFAD_iWNbec6ZomR9ef59T62PNhXVCnDXLPdu0@z>

On Mon, Aug 22, 2016 at 05:36:22PM -0500, Tom Lendacky wrote:
> Update the cpu features to include identifying and reporting on the
> Secure Memory Encryption feature.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/cpufeature.h        |    7 +++++--
>  arch/x86/include/asm/cpufeatures.h       |    5 ++++-
>  arch/x86/include/asm/disabled-features.h |    3 ++-
>  arch/x86/include/asm/required-features.h |    3 ++-
>  arch/x86/kernel/cpu/scattered.c          |    1 +
>  5 files changed, 14 insertions(+), 5 deletions(-)

...

> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 8cb57df..d86d9a5 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -37,6 +37,7 @@ void init_scattered_cpuid_features(struct cpuinfo_x86 *c)
>  		{ X86_FEATURE_HW_PSTATE,	CR_EDX, 7, 0x80000007, 0 },
>  		{ X86_FEATURE_CPB,		CR_EDX, 9, 0x80000007, 0 },
>  		{ X86_FEATURE_PROC_FEEDBACK,	CR_EDX,11, 0x80000007, 0 },
> +		{ X86_FEATURE_SME,		CR_EAX, 0, 0x8000001f, 0 },

If this is in scattered CPUID features, it doesn't need any of the
(snipped) changes above - you solely need to reuse one of the free
defines, i.e., something like this:

---
--- a/arch/x86/include/asm/cpufeatures.h	2016-09-02 15:49:08.853374323 +0200
+++ b/arch/x86/include/asm/cpufeatures.h	2016-09-02 15:52:34.477365610 +0200
@@ -100,7 +100,7 @@
 #define X86_FEATURE_XTOPOLOGY	( 3*32+22) /* cpu topology enum extensions */
 #define X86_FEATURE_TSC_RELIABLE ( 3*32+23) /* TSC is known to be reliable */
 #define X86_FEATURE_NONSTOP_TSC	( 3*32+24) /* TSC does not stop in C states */
-/* free, was #define X86_FEATURE_CLFLUSH_MONITOR ( 3*32+25) * "" clflush reqd with monitor */
+#define X86_FEATURE_SME		( 3*32+25) /* Secure Memory Encryption */
 #define X86_FEATURE_EXTD_APICID	( 3*32+26) /* has extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM     ( 3*32+27) /* multi-node processor */
 #define X86_FEATURE_APERFMPERF	( 3*32+28) /* APERFMPERF */
--- a/arch/x86/kernel/cpu/scattered.c	2016-09-02 15:48:52.753375005 +0200
+++ b/arch/x86/kernel/cpu/scattered.c	2016-09-02 15:51:32.437368239 +0200
@@ -37,6 +37,7 @@ void init_scattered_cpuid_features(struc
 		{ X86_FEATURE_HW_PSTATE,	CR_EDX, 7, 0x80000007, 0 },
 		{ X86_FEATURE_CPB,		CR_EDX, 9, 0x80000007, 0 },
 		{ X86_FEATURE_PROC_FEEDBACK,	CR_EDX,11, 0x80000007, 0 },
+		{ X86_FEATURE_SME,		CR_EAX, 0, 0x8000001f, 0 },
 		{ 0, 0, 0, 0, 0 }
 	};

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
