Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:44398 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbeHUOkR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 10:40:17 -0400
Date: Tue, 21 Aug 2018 13:20:20 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180821112020.GB29972@nazgul.tnic>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180821112020.qY5yx06VqLW_FWugJGVrUGaHCg5xxWwYv8LYUfkj7n4@z>

On Tue, Aug 21, 2018 at 07:04:23PM +0800, Pu Wen wrote:
> Sure, JV will negotiate with AMD and make sure only JV use family 18h and
> AMD won't use family 0x18h, which will make the patch tight and clear.
> 
> What's the best way to adapt for EDAC driver?
> * To simplify the code based on AMD won't do family 0x18 and remove
>   vendor checking.

That, provided AMD won't use family 0x18.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
