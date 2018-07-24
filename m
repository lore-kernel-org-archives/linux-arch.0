From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 01/17] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
Date: Tue, 24 Jul 2018 20:14:29 +0200
Message-ID: <ed090643-09da-cde7-6edd-970d973afd4d@redhat.com>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-2-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532352037-7151-2-git-send-email-puwen@hygon.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

On 23/07/2018 15:20, Pu Wen wrote:
> Add x86 architecture support for new processor Hygon Dhyana Family 18h.
> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
> AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU. In
> this way we can remove old AMD architecture support codes from Hygon
> code path and generate a clear initialization flow for Hygon processors,
> it also reduce long-term maintenance effort.
> Also add hygon.c Maintainer information in accordance.
> 
> To identify Hygon processors, add a new vendor type X86_VENDOR_HYGON(9)
> for system recognition.
> 
> To enable Hygon processor config, add a separated Kconfig entry(CPU_SUP_
> HYGON) for Dhyana CPU in kernel config setup.

If Hygon processors are currently the same as AMD, I don't see the point
in creating a new file just for them.  Likewise for example in patch 6


+	case X86_VENDOR_HYGON:
+		ideal_nops = p6_nops;
+		return;
+
 	case X86_VENDOR_AMD:
 		if (boot_cpu_data.x86 > 0xf) {
 			ideal_nops = p6_nops;

Should only need to add "case X86_VENDOR_HYGON:".  Or you could even
reuse X86_VENDOR_AMD.

Paolo
