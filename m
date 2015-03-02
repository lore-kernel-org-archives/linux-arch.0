From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [RFC PATCH 0/4] make memtest a generic kernel feature
Date: Mon, 2 Mar 2015 17:14:00 +0200
Message-ID: <20150302151400.GI15668@tarshish>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:58237 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbbCBPOI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Mar 2015 10:14:08 -0500
Content-Disposition: inline
In-Reply-To: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, lauraa@codeaurora.org, arnd@arndb.de, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, hpa@zytor.com, linux@arm.linux.org.uk, tglx@linutronix.de, akpm@linux-foundation.org

Hi Vladimir,

On Mon, Mar 02, 2015 at 02:55:41PM +0000, Vladimir Murzin wrote:
> Memtest is a simple feature which fills the memory with a given set of
> patterns and validates memory contents, if bad memory regions is detected it
> reserves them via memblock API. Since memblock API is widely used by other
> architectures this feature can be enabled outside of x86 world.
> 
> This patch set promotes memtest to live under generic mm umbrella and enables
> memtest feature for arm/arm64.

Please update the architectures list in the 'memtest' entry at 
Documentation/kernel-parameters.txt.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
