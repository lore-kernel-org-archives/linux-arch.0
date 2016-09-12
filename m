Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:44408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759457AbcILPDy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 11:03:54 -0400
Subject: Re: Build failures in -next: sys_pkey_mprotect etc. undefined
References: <9d74497b-1522-b350-42fa-49df2df48c4a@roeck-us.net>
 <9369809.1DWhqOZ7mo@wuerfel>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <57D6C3D7.2040606@linux.intel.com>
Date: Mon, 12 Sep 2016 08:03:51 -0700
MIME-Version: 1.0
In-Reply-To: <9369809.1DWhqOZ7mo@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "open list:ABI/API" <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20160912150351.C8bW1z0ozk8G8G6b8xnZuNAA7AswjVSm8jx-j7VxggA@z>

On 09/12/2016 07:59 AM, Arnd Bergmann wrote:
> On Monday, September 12, 2016 7:55:33 AM CEST Guenter Roeck wrote:
>> Building h8300:allnoconfig ... failed
>> Building h8300:h8300h-sim_defconfig ... failed
>> Building c6x:dsk6455_defconfig ... failed
>>
>> [ and more builds for the same architectures ]
>>
>> --------------
>> Error log:
>> arch/h8300/kernel/built-in.o:(.data+0x480): undefined reference to `sys_pkey_mprotect'
>> arch/h8300/kernel/built-in.o:(.data+0x484): undefined reference to `sys_pkey_alloc'
>> arch/h8300/kernel/built-in.o:(.data+0x488): undefined reference to `sys_pkey_free'
>>
>> Other architectures (frv, xtensa, score) currently fail to build for other reasons,
>> so I don't really know if the above are the only ones affected.
> 
> I think the best solution would be to add them to kernel/sys_ni.c so we can
> assign syscall numbers for all architectures regardless of whether they use it
> or not (most of them will never use these AFAICT).

Urg, sorry about the breakage.  I'll see if I can reproduce it and get a
patch out later today that does this.

