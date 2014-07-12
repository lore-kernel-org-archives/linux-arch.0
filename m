From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 2/3] ARM: Use include/asm-generic/io.h
Date: Sat, 12 Jul 2014 15:18:11 +0100
Message-ID: <ED7E6275-79B2-4610-9DA2-CFAC3D026798@arm.com>
References: <1405092672-18549-1-git-send-email-thierry.reding@gmail.com> <1405092672-18549-2-git-send-email-thierry.reding@gmail.com> <20140711162422.GF16321@arm.com> <201407121427.22668.arnd@arndb.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:52863 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaGLOSQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jul 2014 10:18:16 -0400
In-Reply-To: <201407121427.22668.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 Jul 2014, at 13:27, Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 11 July 2014, Catalin Marinas wrote:
>> 
>> On Fri, Jul 11, 2014 at 04:31:11PM +0100, Thierry Reding wrote:
>>> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
>>> index a78562f21aab..ef54f5c8a7ae 100644
>>> --- a/arch/arm/include/asm/io.h
>>> +++ b/arch/arm/include/asm/io.h
>> [...]
>>> -#define iowrite16be(v,p) ({ __iowmb(); __raw_writew((__force __u16)cpu_to_be16(v), p); })
>>> -#define iowrite32be(v,p) ({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
>> 
>> Aren't you losing the barrier semantics here? The generic iowrite*be()
>> functions call __raw_write*() directly which don't have a barrier
>> (write* accessors do).
> 
> Indeed, sorry for missing this. The generic implementation still makes sense for
> include/asm-generic, but arm32 and arm64 must provide their own versions here.

I think this would be the easiest. But the asm-generic/io.h needs some
#ifndef iowrite16be checks.

(in arm64 we missed the iowrite*be barriers completely, so not broken by
this patch; Thierry could update arm64 as well with patch 3/3)

Catalin