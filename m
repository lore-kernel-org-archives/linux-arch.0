Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:57128 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbeIEPAD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Sep 2018 11:00:03 -0400
Date: Wed, 5 Sep 2018 12:30:09 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 11/16] x86/kvm: enable Hygon support to KVM
 infrastructure
Message-ID: <20180905103009.GF2237@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <37fd42bcf50eccfc3aad18051492144056e2f0fb.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37fd42bcf50eccfc3aad18051492144056e2f0fb.1535459013.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org
Message-ID: <20180905103009.T7hd_s5OzHGquycKWO3KTYIb-T4c2VyaGx2TDbgmK8s@z>

On Wed, Aug 29, 2018 at 08:45:05PM +0800, Pu Wen wrote:
> Hygon Dhyana CPU has the SVM feature as AMD family 17h does.
> Add Hygon support in the KVM infrastructure.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/include/asm/kvm_emulate.h |  4 ++++
>  arch/x86/include/asm/virtext.h     |  5 +++--
>  arch/x86/kvm/emulate.c             | 11 ++++++++++-
>  3 files changed, 17 insertions(+), 3 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
