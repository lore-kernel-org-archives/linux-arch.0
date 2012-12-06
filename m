From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 12/44] metag: TBX source
Date: Thu, 6 Dec 2012 09:35:21 +0000
Message-ID: <50C066D9.9010700@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>  <1354723742-6195-13-git-send-email-james.hogan@imgtec.com> <1354733607.8320.3.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:52749 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932377Ab2LFJfZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Dec 2012 04:35:25 -0500
In-Reply-To: <1354733607.8320.3.camel@joe-AO722>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 05/12/12 18:53, Joe Perches wrote:
> On Wed, 2012-12-05 at 16:08 +0000, James Hogan wrote:
>> Add source files from the Thread Binary Interface (TBI) library which
>> provides useful low level operations and traps/context management.
> []
>>  arch/metag/tbx/tbicache.c  |  462 ++++++++++++++++++++++++++++++++++++++++++++
> 
> Could you please run checkpatch on this file?

Hi Joe,

Thanks for taking a look.

I'd prefer to avoid making style modifications to the tbx/ files if
possible to ease maintenance, as the code is shared with other projects
and maintained by a separate group.

Of course if cleaning up the style is deemed absolutely necessary then
so be it.

Cheers
James
