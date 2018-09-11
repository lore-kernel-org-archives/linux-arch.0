Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:37166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbeIKPly (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Sep 2018 11:41:54 -0400
Date: Tue, 11 Sep 2018 12:43:06 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 10/16] x86/mce: Add Hygon Dhyana support to MCE
 infrastructure
Message-ID: <20180911104306.GG12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <08410d871a1165d994265f20c2b979268de773be.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08410d871a1165d994265f20c2b979268de773be.1536550550.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180911104306.bub2cKJP3U6aDCwkY4aaZ7_jLLA0TQR0jlJb5cnXjCI@z>

On Mon, Sep 10, 2018 at 09:17:54PM +0800, Pu Wen wrote:
> The machine check architecture for Hygon Dhyana CPU is similar to the
> AMD family 17h one. To make MCE working on Hygon platforms, add vendor
> checking for Hygon Dhyana to share the code path of AMD family 17h.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/include/asm/mce.h                |  2 ++
>  arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
>  arch/x86/kernel/cpu/mcheck/mce.c          | 20 +++++++++++++++-----
>  3 files changed, 19 insertions(+), 6 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
