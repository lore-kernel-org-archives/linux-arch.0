Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:53626 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbeHWLz4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Aug 2018 07:55:56 -0400
Date: Thu, 23 Aug 2018 10:27:15 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180823082715.GA11742@nazgul.tnic>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
 <20180821112020.GB29972@nazgul.tnic>
 <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
 <20180821130430.GB30528@nazgul.tnic>
 <36de11c7-8448-2967-2032-ef31d8e8a979@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36de11c7-8448-2967-2032-ef31d8e8a979@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180823082715.BVyHhx9k1ZeIrCCz28q9pMhkY855CvfNm3wDRfesMR0@z>

On Wed, Aug 22, 2018 at 09:07:20PM +0800, Pu Wen wrote:
> Current I think we'd better try to follow the following way:
> For current version, we will try to minimize the modification and share
> codes,
> For later big modification, will try to split codes to make code path
> more clear.

Yes, makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
