From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
Date: Tue, 25 Sep 2018 14:30:35 +0200
Message-ID: <20180925123035.GC23986@zn.tnic>
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
 <20180924152448.GE20187@zn.tnic>
 <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 25, 2018 at 08:27:15PM +0800, Pu Wen wrote:
> All right, I will change these in the next version patch set.

Just send two patches as a reply to this thread here:

1. add the vendor check to both amd_gart_present() and early_is_amd_nb()
2. redo 7/16 ontop of the first patch.

I don't think you need to resend the whole patchset as the rest is still
good.

Right?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
