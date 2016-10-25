Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33332 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932547AbcJYRDr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2016 13:03:47 -0400
Subject: Re: [PATCH 2/3] ARM: convert to generated system call tables
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
 <3851270.xZRcP9hae0@wuerfel> <20161025091210.rjfhvq4mqtuquei5@tower>
 <4146248.jXuviLlvH5@wuerfel>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d113bb21-cf52-6531-10b4-f73fc0b9e809@twiddle.net>
Date: Tue, 25 Oct 2016 10:03:43 -0700
MIME-Version: 1.0
In-Reply-To: <4146248.jXuviLlvH5@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Michael Cree <mcree@orcon.net.nz>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, linux-alpha@vger.kernel.org
Message-ID: <20161025170343.BXT_1HyOn06wdkFsciEiCyoCQQW3fmUl4i8yP3IbikI@z>

On 10/25/2016 03:28 AM, Arnd Bergmann wrote:
> On Tuesday, October 25, 2016 10:12:10 PM CEST Michael Cree wrote:
>> On Fri, Oct 21, 2016 at 03:06:45PM +0200, Arnd Bergmann wrote:
>>> I see your point, but I think there are serious issues with the current
>>> approach as well:
>>>
>>> - a lot of the less common architectures just don't get updated
>>>   in time, out of 22 architectures that don't use asm-generic/unistd.h,
>>>   only 12 have pwritev2 in linux-next, and only three have pkey_mprotect
>>>
>>> - some architectures that add all syscalls sometimes make a mistake
>>>   and forget one, e.g. alpha apparently never added __NR_bpf, but it
>>>   did add the later __NR_execveat.
>>
>> __NR_bpf was not forgotten on Alpha.  It was not wired up because
>> extra architecture support is needed which has not been implemented.
>>
>> But maybe we should just wire it up to sys_ni_syscall in the meantime
>> so a syscall number is reserved for it, and user space can call it to
>> get -ENOSYS returned.
> 
> Ah, I must have misinterpreted the code then. I assumed that the
> bpf syscall always works on all architectures, but that only the
> jit compiler for it required architecture specific code to make it
> more efficient.

That was my interpretation as well.  What's the problem, Michael?


r~
