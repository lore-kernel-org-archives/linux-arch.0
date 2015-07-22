From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 09/10] arch: introduce memremap()
Date: Tue, 21 Jul 2015 21:04:22 -0700
Message-ID: <CAPcyv4jXyHzXUmr1LNL3vTzgced8Onrq9OZR2Ub1E85HnOru1Q@mail.gmail.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150721235848.GI30479@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36521 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbbGVEEY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2015 00:04:24 -0400
Received: by wicgb10 with SMTP id gb10so79645684wic.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2015 21:04:23 -0700 (PDT)
In-Reply-To: <20150721235848.GI30479@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jul 21, 2015 at 4:58 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Sun, Jul 19, 2015 at 08:18:23PM -0400, Dan Williams wrote:
>> diff --git a/include/linux/io.h b/include/linux/io.h
>> index 080a4fbf2ba4..2983b6e63970 100644
>> --- a/include/linux/io.h
>> +++ b/include/linux/io.h
>> @@ -192,4 +192,15 @@ static inline int arch_phys_wc_index(int handle)
>>  #endif
>>  #endif
>>
>> +enum {
>> +     MEMREMAP_WB = 1 << 0,
>> +     MEMREMAP_WT = 1 << 1,
>> +     MEMREMAP_WC = 1 << 2,
>> +     MEMREMAP_STRICT = 1 << 3,
>> +     MEMREMAP_CACHE = MEMREMAP_WB,
>> +};
>
> A few things:
>
> 1) You'll need MEMREMAP_UC now as well now.

Why?  I don't think it fits.  If there are any I/O areas (non-memory)
in the range then it simply is not "memory" and should not be using
memremap().  In other words it seems like you really do need to heed
the __iomem annotation in the return value from ioremap_uc().

> 2) as you are doing all this sweep over architectures on this please
> also address the lack of ioremap_*() variant implemention to return
> NULL, ie not supported, because we've decided for now that so long
> as the semantics are not well defined we can't expect architectures
> to get it right unless they are doing the work themselves, and the
> old strategy of just #defin'ing a variant to iorempa_nocache() which
> folks tended to just can lead to issues. In your case since you are
> jumping to the flags implementation this might be knocking two birds
> with one stone.

I'm not going to do a general sweep for this as the expectation that
ioremap silently falls back if a mapping type is not supported is
buried all over the place.  That said, new usages and conversions to
memremap() can be strict about this. For now, I'm only handling
ioremap_cache() and ioremap_wt() conversions.

> 3) For the case that architectures have no MMU we currently do a direct
> mapping such as what you try to describe to do with memremap(). I wonder
> if its worth it to then enable that code to just map to memremap(). That
> throws off your usage of CONFIG_ARCH_HAS_MEMREMAP if we want to repurpose
> that implementation for no the MMU case, unless of course you just have a
> __memremap() which does the default basic direct mapping implementation.

Yes, in the next rev of this series I am having it fall back to direct
mappings where it makes sense.

> 4) Since we are all blaming semantics on our woes I'd like to ask for
> some effort on semantics to be well defined. Semantics here sholud cover
> some form of Documentation but also sparse annotation checks and perhaps
> Coccinelle grammar rules for how things should be done. This should not only
> cover general use but also if there are calls which depend on a cache
> type to have been set. If we used sparse annotations it  may meen a
> different return type for each cache type.  Not sure if we want this.
> If we went with grammar rules I'm looking to for instance have in place
> rules on scripts/coccinelle which would allow developers to use

memremap() explicitly does not want get into arch semantics debates.
The pointer returned from memremap() is a "void *" that can be used as
normal memory.  If it is a normal pointer I don't see the role for
sparse annotation.

>
> make coccicheck M=foo/
>
> to find issues. I can perhaps help with this, but we'd need to do a good
> sweep here to not only cover good territory but also get folks to agree
> on things.
>
> 5) This may be related to 4), not sure. There are aligment requirements we
> should probably iron out for architectures. How will we annotate these
> requirements or allow architectures to be pedantic over these requirements?

What requirements beyond PAGE_SIZE alignment would we need to worry about?
