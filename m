From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [RFC PATCH 0/4] make memtest a generic kernel feature
Date: Tue, 03 Mar 2015 09:28:39 +0000
Message-ID: <54F57EC7.1060202@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com> <20150302151400.GI15668@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38904 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbbCCJ2o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Mar 2015 04:28:44 -0500
In-Reply-To: <20150302151400.GI15668@tarshish>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <Mark.Rutland@arm.com>, "lauraa@codeaurora.org" <lauraa@codeaurora.org>, "arnd@arndb.de" <arnd@arndb.de>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tglx@linutronix.de" <tglx@linutronix.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On 02/03/15 15:14, Baruch Siach wrote:
> Hi Vladimir,
> 
> On Mon, Mar 02, 2015 at 02:55:41PM +0000, Vladimir Murzin wrote:
>> Memtest is a simple feature which fills the memory with a given set of
>> patterns and validates memory contents, if bad memory regions is detected it
>> reserves them via memblock API. Since memblock API is widely used by other
>> architectures this feature can be enabled outside of x86 world.
>>
>> This patch set promotes memtest to live under generic mm umbrella and enables
>> memtest feature for arm/arm64.
> 
> Please update the architectures list in the 'memtest' entry at 
> Documentation/kernel-parameters.txt.

Thanks for pointing at it. I'll add updates for documentation to my next
version.

Vladimir

> 
> baruch
> 
