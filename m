From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Mon, 24 Nov 2008 10:02:40 -0800
Message-ID: <492AEC40.5060009@zytor.com>
References: <20081105222911.d76e7e1c.mitake@clustcom.com>	<413709.12821.qm@web50106.mail.re2.yahoo.com>	<20081106164641.ed369060.akpm@linux-foundation.org>	<20081107152830.a42766f3.mitake@clustcom.com>	<20081106223122.8a255211.akpm@linux-foundation.org>	<20081107153824.0ec934e6.mitake@clustcom.com>	<20081106231102.aab83cd4.akpm@linux-foundation.org>	<a6b9f31a0811090710y17e956bawf20675d6678b145e@mail.gmail.com>	<20081109112646.97c594b5.akpm@linux-foundation.org>	<20081118121620.GB8625@linux-mips.org>	<20081118123215.GB30509@flint.arm.linux.org.uk> <20081121011941.26e05a25.h.mitake@gmail.com> <4929ECB7.8080108@zytor.com> <57C9024A16AD2D4C97DC78E552063EA35C517F42@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33279 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYKXSGk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2008 13:06:40 -0500
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA35C517F42@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Hitoshi Mitake <h.mitake@gmail.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, "dougthompson@xmission.com" <dougthompson@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Luck, Tony wrote:
>>       volatile u32 __iomem *__p = addr;
>>       u32 __l, __h;
> 
> Do we really need all the "__" inside an inline function?  Why
> not just call these "p", "l" and "h"?

Sorry, user space habit (in userspace, and in anything that can be
included from userspace, one needs the __ to keep the namespace clean.)

	-hpa
