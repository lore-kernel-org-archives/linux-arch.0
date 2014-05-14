From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 04/25] avr32: Add 32 bit time_t and clock_t
Date: Wed, 14 May 2014 09:44:57 +0200
Message-ID: <20140514074456.GB17409@samfundet.no>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
 <1399971769-4116-1-git-send-email-lftan@altera.com>
 <20140513201944.GA14023@samfundet.no>
 <CAFiDJ5_5ret2H-OynLMhBStzyDDBLpF6Tsy4bbEUX+mKu2V4uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:39610 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaENHpA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 03:45:00 -0400
Content-Disposition: inline
In-Reply-To: <CAFiDJ5_5ret2H-OynLMhBStzyDDBLpF6Tsy4bbEUX+mKu2V4uA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>

Around Wed 14 May 2014 09:54:25 +0800 or thereabout, Ley Foon Tan wrote:
> On Wed, May 14, 2014 at 4:19 AM, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
>> Around Tue 13 May 2014 17:02:49 +0800 or thereabout, Ley Foon Tan wrote:
>>> Override time_t and clock_t in include/uapi/asm-generic.
>>>
>>> Signed-off-by: Ley Foon Tan <lftan@altera.com>
>>
>> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>>
>> Quickly looked over some of the other patches in the series, and they all
>> seem to add the same. Could this be generic, with the possibility for arch to
>> override?
> In this patchset, the generic one will be 64 bit (long long). So, the
> existing 32 bit users need to override this.

Would it be wrong to use the architecture defined size, or does some 32-bit
architectures use 64-bit time types?

-- 
Hans-Christian Egtvedt
