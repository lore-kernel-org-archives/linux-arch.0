From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline kernel (specifically arm in our case)
Date: Thu, 20 Nov 2008 14:59:06 +0100
Message-ID: <b647ffbd0811200559k7f0ca3e4ge2f8c71f6b1c8f69@mail.gmail.com>
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com>
	 <200811201759.01039.nickpiggin@yahoo.com.au>
	 <b647ffbd0811200428u2b41b108ifb02872563c871ab@mail.gmail.com>
	 <200811210025.39568.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <200811210025.39568.nickpiggin@yahoo.com.au>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fsdevel@vger.kernel.org, Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

2008/11/20 Nick Piggin <nickpiggin@yahoo.com.au>:
> On Thursday 20 November 2008 23:28, Dmitry Adamushko wrote:
>> 2008/11/20 Nick Piggin <nickpiggin@yahoo.com.au>:
>> > [ ... ]
>> >
>> > - The page is sent to the block layer, which stores into the page. Some
>> >  block devices like 'brd' will potentially store via the kernel linear
>> > map here, and they probably don't do enough cache flushing.
>>
>> btw., if someone is curious, here is another case of what may happen
>> on VIPT systems when someone uses a "virtual" block device (like
>> 'brd') as, heh, a swap :-)
>>
>> http://www.linux-mips.org/archives/linux-mips/2008-11/msg00038.html
>
> Right... Now I'm lacking knowledge when it comes to devices, but I
> think it is probably reasonable for the block device layer to ensure
> the physical memory is uptodate after it signals request completion.
>
> That is, there shouldn't be any potentially aliasing dirty lines.
> Block devices which do any writeout via the kernel linear address
> (eg. brd) should do a flush_dcache_page.
>

Yeah, but my point is that flush_dcache_page() in its current
incarnation will _not_ always match the expectetions of such block
devices (e.g. brd or compcache) when those devices are used as "swap"
:-)

IOW, although flush_dcache_page() is in place, it won't work as expected.

-- 
Best regards,
Dmitry Adamushko
