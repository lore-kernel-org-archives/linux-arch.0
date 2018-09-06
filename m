Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:42678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbeIFNOF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 09:14:05 -0400
Date: Thu, 6 Sep 2018 10:39:24 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
Message-ID: <20180906083924.GB10768@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
 <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
 <20180905131427.GI2237@zn.tnic>
 <a9b7aa87-c99a-42ee-48df-69bec64bb468@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9b7aa87-c99a-42ee-48df-69bec64bb468@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180906083924.nEbD9qBdZDGLs6bTTEtAxkuKrw-ABeuQRY6hDLq3R_o@z>

On Thu, Sep 06, 2018 at 11:52:42AM +0800, Pu Wen wrote:
> In most of the normal use cases MCE is necessary. Rarely in some cases
> such as for test purpose MCE may be unselected.

Test with MCE disabled? Please elaborate.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
