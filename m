From: Michal Simek <michal.simek@petalogix.com>
Subject: Re: USE_ELF_CORE_DUMP?
Date: Fri, 24 Apr 2009 09:17:26 +0200
Message-ID: <49F16786.7010401@petalogix.com>
References: <20090423183331.GA19899@lst.de>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:19698 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbZDXHRb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2009 03:17:31 -0400
In-Reply-To: <20090423183331.GA19899@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

Christoph Hellwig wrote:
> Currently all architectures but microblaze unconditionally define
> USE_ELF_CORE_DUMP.  The microblaze ommision seems like an error to
> me, so can we just kill this ifdef and make sure we are the same
> everywhere?
>   
Where did you find it?
I haven't seen in in mainline (noMMU kernel). It is in my MMU patches
which I want to send for review soon.

For noMMU I use CONFIG_BINFMT_FLAT (binfmt_flat.c) where I don't need
USE_ELF_CORE_DUMP
For MMU I use CONFIG_BINFMT_ELF (binfmt_elf.c) where USE_ELF_CORE_DUMP
make sense to me.

Can you give me some clue what you are trying to fix?

Thanks,
Michal


> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
