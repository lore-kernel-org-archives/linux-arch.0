Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:62818 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965729AbbEERKh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2015 13:10:37 -0400
Message-ID: <5548F965.9070302@dawncrow.de>
Date: Tue, 05 May 2015 19:09:57 +0200
From: =?windows-1252?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: Preserve the user r/w register tpidr_el0 on context
 switch and fork in compat mode
References: <55464BB2.7030401@dawncrow.de> <20150505105111.GB1550@arm.com>
In-Reply-To: <20150505105111.GB1550@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Jonathan Austin <Jonathan.Austin@arm.com>, Nathan Lynch <nathan_lynch@mentor.com>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20150505170957.5qghiPMmmYQT4KYvHhvuZVOmBKar7UuCvW9fv1kHE_c@z>

Am 05.05.2015 um 12:51 schrieb Will Deacon:
> On Sun, May 03, 2015 at 05:24:18PM +0100, André Hentschel wrote:
>> From: André Hentschel <nerv@dawncrow.de>
>>
>> Since commit a4780adeefd042482f624f5e0d577bf9cdcbb760 the user writeable TLS
>> register on ARM is preserved per thread.
>>
>> This patch does it analogous to the ARM patch, but for compat mode on ARM64.
>>
>> Signed-off-by: André Hentschel <nerv@dawncrow.de>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Jonathan Austin <jonathan.austin@arm.com> 
>>
>> ---
>> This patch is against Linux 4.1-rc1 (b787f68c36d49bb1d9236f403813641efa74a031)
> 
> Curious, but why do you need this? iirc, we added this for arch/arm/ because
> of some windows rt (?) emulation in wine. Is that still the case here and is
> anybody actually using that?

Yes, Windows ARM binaries are the well known use case, but also the compat mode should do
what the arm kernel is doing I’d think and the code wasn't adjusted yet.

What i'm curious about is why the main TLS register on arm64 is the user writeable,
I'm not an security expert but this looks odd. I could easily provoke a crash by writing
to it...

CCing Catalin Marinas
