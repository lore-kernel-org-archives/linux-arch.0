Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:49074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeHUQYm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 12:24:42 -0400
Date: Tue, 21 Aug 2018 15:04:30 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180821130430.GB30528@nazgul.tnic>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
 <20180821112020.GB29972@nazgul.tnic>
 <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180821130430.s0ffBNJg-kIuAFtPVxIOjt6l8R6gMNRAVXJ8myNSRZc@z>

On Tue, Aug 21, 2018 at 01:26:13PM +0200, Paolo Bonzini wrote:
> But then I don't see the point of adding the Hygon vendor, since any
> check can be simplified:

I think Hygon wanted to superficially show it is not really an AMD. For
example, the Hygon thing doesn't do SME/SEV. AFAIK.

So we can just as well check only family but I'd say the vendor thing is
laying the grounds for the future where reportedly it will differ more
from an AMD. And then we can start splitting code more based on vendor
and not look at family at all.

But for right now I think we should strive to keep the changes as small
as possible and only do real splitting when they start adding new
functionality. Which would mean having a hygon_edac.c too, for example.

All, IMHO, of course. Sharing code between vendors is always yucky.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
