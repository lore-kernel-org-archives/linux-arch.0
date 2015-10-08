Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:47454 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbbJHJlI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2015 05:41:08 -0400
Date: Thu, 8 Oct 2015 10:40:55 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V4 2/3] arm64: support initrd outside kernel linear map
Message-ID: <20151008094055.GC32532@n2100.arm.linux.org.uk>
References: <1439830867-14935-1-git-send-email-msalter@redhat.com>
 <1439830867-14935-3-git-send-email-msalter@redhat.com>
 <20150908113113.GA20562@leverpostej>
 <20151006171140.GE26433@leverpostej>
 <1444151812.10788.14.camel@redhat.com>
 <20151008084953.GA20114@cbox>
 <FC378C09-F140-4A62-9FFA-09293E65E866@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FC378C09-F140-4A62-9FFA-09293E65E866@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Mark Salter <msalter@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20151008094055.POpJKSwG3h5VzzTp4Fvjf5CskhY0Zrolyrpstq7wAhY@z>

On Thu, Oct 08, 2015 at 05:18:14PM +0800, yalin wang wrote:
> is it also possible to implement it on ARM platforms?
> ARM64 platform don’t have HIGH_MEM zone .
> but ARM platform have .
> i remember boot loader must put init rd  into low memory region,
> so if some boot loader put init rd into HIGH men zone
> we can also relocate it to low men region ?
> then boot loader don’t need care about this ,
> and since vmalloc= boot option will change HIGH mem region size,
> if we can relocate init rd , boot loader don’t need care about init rd load address,
> when change vmalloc= boot options .

I'd be more inclined to say yes if the kernel wasn't buggering around
passing virtual addresses (initrd_start) of the initrd image around,
but instead used a physical address.  initrd_start must be a lowmem
address.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
