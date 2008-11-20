From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: O_DIRECT patch for processors with VIPT cache for mainline kernel (specifically arm in our case)
Date: Thu, 20 Nov 2008 13:28:03 +0100
Message-ID: <b647ffbd0811200428u2b41b108ifb02872563c871ab@mail.gmail.com>
References: <d8dd82df0811180606w503563ach8650ab07dcd0a35c@mail.gmail.com>
	 <200811191740.23638.nickpiggin@yahoo.com.au>
	 <20081119204315.GB17209@flint.arm.linux.org.uk>
	 <200811201759.01039.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:47709 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbYKTM2E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Nov 2008 07:28:04 -0500
Received: by rv-out-0506.google.com with SMTP id k40so436793rvb.1
        for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2008 04:28:03 -0800 (PST)
In-Reply-To: <200811201759.01039.nickpiggin@yahoo.com.au>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fsdevel@vger.kernel.org, Naval Saini <navalnovel@gmail.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, naval.saini@nxp.com, Ralf Baechle <ralf@linux-mips.org>

2008/11/20 Nick Piggin <nickpiggin@yahoo.com.au>:
>
> [ ... ]
>
> - The page is sent to the block layer, which stores into the page. Some
>  block devices like 'brd' will potentially store via the kernel linear map
>  here, and they probably don't do enough cache flushing.

btw., if someone is curious, here is another case of what may happen
on VIPT systems when someone uses a "virtual" block device (like
'brd') as, heh, a swap :-)

http://www.linux-mips.org/archives/linux-mips/2008-11/msg00038.html


-- 
Best regards,
Dmitry Adamushko
