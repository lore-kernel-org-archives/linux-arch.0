From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
Date: Mon, 19 Jun 2017 10:27:33 -0700
Message-ID: <f9839beb-ea66-18c3-c541-b78080b560b3@gmail.com>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
 <20170618235108.peaxdi367jpkt542@yury-thinkpad>
 <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35103 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdFSR1m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 13:27:42 -0400
In-Reply-To: <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org

On 06/19/2017 08:18 AM, Yury Norov wrote:
> On Mon, Jun 19, 2017 at 02:51:08AM +0300, Yury Norov wrote:
>> Hi Florian,
>>
>> Some questions and thoughts inline.
>>
>> Yury
>>
>> On Fri, Jun 16, 2017 at 05:07:42PM -0700, Florian Fainelli wrote:
>>> Define a generic fncpy() implementation largely based on the ARM version
>>> that requires an 8 bytes alignment for the destination address where to
>>> copy this function as well as the function's own address.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  include/asm-generic/fncpy.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 93 insertions(+)
>>>  create mode 100644 include/asm-generic/fncpy.h
> 
> One else thing I forgot to ask - now you have the generic
> implementation for fncpy(), so do you really need to save arm
> version of it?

Yes, it needs to deal with the Thumb bit, and there is no point in
making the generic implementation extremely flexible to support that
special case.

Thanks
-- 
Florian
