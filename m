From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 65/76] ARC: UAPI Disintegrate arch/arc/include/asm
Date: Wed, 23 Jan 2013 18:33:01 +0530
Message-ID: <50FFDF85.9070600@synopsys.com>
References: <50FFCAC4.1050002@synopsys.com> <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-66-git-send-email-vgupta@synopsys.com> <10760.1358945425@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:40956 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122Ab3AWNEr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jan 2013 08:04:47 -0500
In-Reply-To: <10760.1358945425@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On Wednesday 23 January 2013 06:20 PM, David Howells wrote:
> Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
>> I generated this patch using the scripts you provided. If these look OK to
>> you, can you please ACK.
> You need to take a look at uapi/asm/setup.h.  It's created as an empty file -
> which will get discarded by patch.  Do you actually need a UAPI instance of
> that?
>
> David

Nope, I don't - but ./genfilelist.pl seems to be generating a reference to it
(even if I add #ifdef __KERNEL__)
How do I work around this ! Do I skip it when running ./disintegrate-one.pl - but
then it won't be completely scripted :-(

-Vineet
