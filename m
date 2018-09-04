From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
Date: Tue, 4 Sep 2018 10:02:41 +0200
Message-ID: <20180904080241.GB32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
 <20180903190438.GF10249@zn.tnic>
 <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 04, 2018 at 11:02:41AM +0800, Pu Wen wrote:
> > > -	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> > > -	      (boot_cpu_data.x86 >= 0x0f)))
> > > +	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> > > +	       boot_cpu_data.x86 >= 0x0f) ||
> > > +	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
> > 
> > Why are you even touching this statement? The function returns early on
> > !X86_VENDOR_AMD.
> 
> The statement is briefly equal to !(X86_VENDOR_AMD || X86_VENDOR_HYGON).
> So the function will not return early on !X86_VENDOR_AMD. :-)

I meant the *original* version - not yours!

My question is why are you even touching a K8-old BIOS workaround?! Your
commit message says:

    The MtrrFixDramModEn bit on Hygon platform should also be set to 1
    during BIOS initialization of the fixed MTRRs, then cleared to 0 for
    operation.

Is your BIOS already broken?

Searching the net for

                pr_err(FW_WARN "MTRR: CPU %u: SYSCFG[MtrrFixDramModEn]"
                       " not cleared by BIOS, clearing this bit\n",

shows only old mails so I'm going to assume this got fixed, finally! And
you probably have received a *fixed* BIOS even, allegedly.

So what's up?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
