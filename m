From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 5/5] blackfin: Convert BUG() to use
 	unreachable()
Date: Thu, 10 Dec 2009 13:35:36 -0800
Message-ID: <4B2169A8.5080503@caviumnetworks.com>
References: <4B212EEC.3060808@caviumnetworks.com> <1260466101-17545-5-git-send-email-ddaney@caviumnetworks.com> <8bd0f97a0912101333x2ba210d8ib1936bffa0ef2d7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12519 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbZLJVgw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 16:36:52 -0500
In-Reply-To: <8bd0f97a0912101333x2ba210d8ib1936bffa0ef2d7b@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, uclinux-dist-devel@blackfin.uclinux.org

Mike Frysinger wrote:
> On Thu, Dec 10, 2009 at 12:28, David Daney wrote:
>> Use the new unreachable() macro instead of for(;;);
> 
> sorry, i guess i missed this back in Sept.  change looks fine to me
> (i'll test it later when finishing putting together other patches).
> you want me to push though my queue ?  doesnt matter to me.

Yes, if you test it and are happy with it.  I have no queue and plan no 
further action.

David Daney
