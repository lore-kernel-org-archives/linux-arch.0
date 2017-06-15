From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/3] ARM: Generalize fncpy implementation
Date: Thu, 15 Jun 2017 16:23:44 -0700
Message-ID: <577f22f3-ff16-05a0-8204-39e86d47dd9f@gmail.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
 <20170615232117.29727-2-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35694 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdFOXXx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2017 19:23:53 -0400
In-Reply-To: <20170615232117.29727-2-f.fainelli@gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>

On 06/15/2017 04:21 PM, Florian Fainelli wrote:
> ARM's fncpy implementation is actually suitable for a large number of
> platforms since the only assumption it makes is just the function's
> alignment (8 bytes) which also happens to fulfil other architectures,
> including but not limited to ARM64.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/include/asm/fncpy.h | 77 ++----------------------------------
>  include/asm-generic/fncpy.h  | 94 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 74 deletions(-)
>  create mode 100644 include/asm-generic/fncpy.h
> 
> diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncpy.h
> index de5354746924..32465aef7932 100644
> --- a/arch/arm/include/asm/fncpy.h
> +++ b/arch/arm/include/asm/fncpy.h
> @@ -16,79 +16,8 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>   */
> +#ifndef _ASMARM_FNCPY_H

and of course I missed a

#define _ASMARM_FNCPY_H

I will wait for feedback on whether this is acceptable before
resubmitting...
-- 
Florian
