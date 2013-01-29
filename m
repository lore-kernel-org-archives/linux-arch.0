From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: ARC Port for linux-next (was Re: [PATCH v3 00/44] Meta Linux Kernel
 Port)
Date: Tue, 29 Jan 2013 18:15:55 +0530
Message-ID: <5107C483.7090503@synopsys.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <5102BB38.3050207@imgtec.com> <201301260025.10020.arnd@arndb.de> <51062460.9060902@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:56202 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756692Ab3A2Mrs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jan 2013 07:47:48 -0500
In-Reply-To: <51062460.9060902@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Hi Stephen,

On Monday 28 January 2013 12:40 PM, Vineet Gupta wrote:
> Hi Arnd / Stephen,
> 
> On Saturday 26 January 2013 05:55 AM, Arnd Bergmann wrote:

>> I'd suggest that you both ask Stephen to add the trees to linux-next
>> now (I thought you had done that already, but I don't see them there
>> at the moment).
> 
> Stephen, can you please add the following branch (rebased off 3.8-rc5) to linux-next
> 
> git://github.com/foss-for-synopsys-dwc-arc-processors/linux.git  arc-next
> 
> With next-20130125, there's a trivial conflict in init/Kconfig - fixable by
> accepting both the hunks.

Please let me know if I'm missing anything before ARC Port could be added to
linux-next.

Thx,
-Vineet
