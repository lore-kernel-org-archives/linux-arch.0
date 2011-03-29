Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tango.tkos.co.il ([62.219.50.35]:48905 "EHLO tango.tkos.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab1C2HCC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Mar 2011 03:02:02 -0400
Date: Tue, 29 Mar 2011 08:50:55 +0200
From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: MACH_TYPE undeclared error
Message-ID: <20110329065055.GA26987@jasper.tkos.co.il>
References: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimSWBx-FTj1WXpOgFXyH6rLSWFNzayLd_yOj7d_@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Madhavi Manchala <madhavi.linux@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20110329065055.dObvje7gG7Kmh1RDuO9jf6NxLF5gO5wCphsQC2PEUDw@z>

Hi Medhavi,

On Tue, Mar 29, 2011 at 12:01:40PM +0530, Madhavi Manchala wrote:
> arch/arm/mach-s3c2510/s3c2510.c:35:1: error: 'MACH_TYPE_S3C2510'
> undeclared here (not in a function)

See 6f82f4db80189281a8ac42f2e72396accb719b57 (ARM: Update (and cut down) 
mach-types), and the recent discussion in this list 
(http://thread.gmane.org/gmane.linux.ports.arm.kernel/110967).

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
