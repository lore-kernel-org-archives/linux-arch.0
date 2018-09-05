Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:35502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeIERps (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Sep 2018 13:45:48 -0400
Date: Wed, 5 Sep 2018 15:15:10 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
Message-ID: <20180905131427.GI2237@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
 <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180905131510.wTmOTwgYpFX3BY9Fzk3fn2mnPSo4V9aVIcIk-8oqH9A@z>

On Wed, Sep 05, 2018 at 08:59:24PM +0800, Pu Wen wrote:
> If CONFIG_X86_MCE_AMD=n, mce_hygon_feature_init will call the other
> one mce_amd_feature_init which is a null function and located in the
> else branch of "#ifdef CONFIG_X86_MCE_AMD". The compilation is OK and
> the kernel will run without MCE support.

So my question was rather ironic but I guess irony can't travel through
mail. So let me paraphrase: is that a use case you wanna support?
Because I'd advise very strongly against !MCE kernels.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
