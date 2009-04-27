From: Greg Ungerer <gerg@snapgear.com>
Subject: Re:
Date: Tue, 28 Apr 2009 09:52:37 +1000
Message-ID: <49F64545.9050002@snapgear.com>
References: <20090427143737.247838642@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rex.securecomputing.com ([203.24.151.4]:54560 "EHLO
	cyberguard.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754541AbZD0Xwk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2009 19:52:40 -0400
In-Reply-To: <20090427143737.247838642@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org

Hi Arnd,

arnd@arndb.de wrote:
>>From arnd@arndb.de Mon Apr 27 16:28:40 2009
> References: <20090427142010.587518220@arndb.de>
> User-Agent: quilt/0.46-1
> Date: Mon, 27 Apr 2009 16:20:14 +0200
> From: arnd@arndb.de
> To: linux-kernel@vger.kernel.org
> Cc: john.williams@petalogix.com,
>  monstr@monstr.eu,
>  linux-api@vger.kernel.org,
>  linux-arch@vger.kernel.org,
>  liqin.chen@sunplusct.com,
>  Sam Ravnborg <sam@ravnborg.org>,
>  Remis Lima Baima <remis.developer@googlemail.com>
> Subject: [RFC 04/17] asm-generic: introduce asm/bitsperlong.h
> Content-Disposition: inline; filename=0020-define-__BITS_PER_LONG-64-on-all-64-bit-architectu.patch
> X-Provags-ID: V01U2FsdGVkX1/jLb8P+uRl1RcCf5V+QdVp81YPPHSqBrYSMpY
>  iDoTcq0iAP5RFAPDuBCPUAkN/qpEfUbUueLJkB/uWbn2OBFAX9
>  K5gcqKXdxwJlLU3abFV6g==
> 
> This provides a reliable way for asm-generic/types.h and other
> files to find out if it is running on a 32 or 64 bit platform.
> 
> We cannot use CONFIG_64BIT for this in headers that are included
> from user space because CONFIG symbols are not available there.
> We also cannot do it inside of asm/types.h because some headers
> need the word size but cannot include types.h.
> 
> The solution is to introduce a new header <asm/bitsperlong.h>
> that defines both __BITS_PER_LONG for user space and
> BITS_PER_LONG for usage in the kernel. The asm-generic
> version falls back to 32 bit unless the architecture overrides
> it, which I did for all 64 bit platforms.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Remis Lima Baima <remis.developer@googlemail.com>
> ---
>  arch/alpha/include/asm/bitsperlong.h      |    8 	8 +	0 -	0 !
>  arch/alpha/include/asm/types.h            |    3 	0 +	3 -	0 !
>  arch/arm/include/asm/bitsperlong.h        |    1 	1 +	0 -	0 !
>  arch/avr32/include/asm/bitsperlong.h      |    1 	1 +	0 -	0 !
>  arch/blackfin/include/asm/bitsperlong.h   |    1 	1 +	0 -	0 !
>  arch/cris/include/asm/bitsperlong.h       |    1 	1 +	0 -	0 !
>  arch/frv/include/asm/bitsperlong.h        |    1 	1 +	0 -	0 !
>  arch/h8300/include/asm/bitsperlong.h      |    1 	1 +	0 -	0 !
>  arch/ia64/include/asm/bitsperlong.h       |    8 	8 +	0 -	0 !
>  arch/ia64/include/asm/types.h             |    7 	0 +	7 -	0 !
>  arch/m32r/include/asm/bitsperlong.h       |    1 	1 +	0 -	0 !
>  arch/m68k/include/asm/bitsperlong.h       |    1 	1 +	0 -	0 !
>  arch/m68knommu/include/asm/bitsperlong.h  |    1 	1 +	0 -	0 !

All the m68knommu includes have merged into the m68k includes.
There is no arch/m68knommu/include directory any more.

Regards
Greg



>  arch/microblaze/include/asm/bitsperlong.h |    1 	1 +	0 -	0 !
>  arch/mips/include/asm/bitsperlong.h       |    8 	8 +	0 -	0 !
>  arch/mips/include/asm/types.h             |    3 	0 +	3 -	0 !
>  arch/mn10300/include/asm/bitsperlong.h    |    1 	1 +	0 -	0 !
>  arch/parisc/include/asm/bitsperlong.h     |   20 	20 +	0 -	0 !
>  arch/parisc/include/asm/types.h           |    8 	0 +	8 -	0 !
>  arch/powerpc/include/asm/bitsperlong.h    |   12 	12 +	0 -	0 !
>  arch/powerpc/include/asm/types.h          |    9 	0 +	9 -	0 !
>  arch/s390/include/asm/bitsperlong.h       |   13 	13 +	0 -	0 !
>  arch/s390/include/asm/types.h             |    6 	0 +	6 -	0 !
>  arch/sh/include/asm/bitsperlong.h         |    1 	1 +	0 -	0 !
>  arch/sparc/include/asm/bitsperlong.h      |   13 	13 +	0 -	0 !
>  arch/sparc/include/asm/types.h            |    4 	0 +	4 -	0 !
>  arch/x86/include/asm/bitsperlong.h        |   13 	13 +	0 -	0 !
>  arch/x86/include/asm/types.h              |    6 	0 +	6 -	0 !
>  arch/xtensa/include/asm/bitsperlong.h     |    1 	1 +	0 -	0 !
>  include/asm-generic/bitsperlong.h         |   32 	32 +	0 -	0 !
>  include/asm-generic/int-l64.h             |    2 	2 +	0 -	0 !
>  include/asm-generic/int-ll64.h            |    2 	2 +	0 -	0 !
>  32 files changed, 144 insertions(+), 46 deletions(-)


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
