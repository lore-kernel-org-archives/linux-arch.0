From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 18/22] Fix M68K irqflags
Date: Wed, 1 Sep 2010 21:22:53 +1000
Message-ID: <4C7E378D.5090907@snapgear.com>
References: <4C7DF3B7.7010305@snapgear.com> <4C7B59E1.6010904@snapgear.com> <20100827015905.27277.39167.stgit@warthog.procyon.org.uk> <20100827020038.27277.27239.stgit@warthog.procyon.org.uk> <26799.1283201411@redhat.com> <2281.1283337985@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:40088 "HELO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753832Ab0IALXT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2010 07:23:19 -0400
In-Reply-To: <2281.1283337985@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/09/10 20:46, David Howells wrote:
> Greg Ungerer<gerg@snapgear.com>  wrote:
>
>> -#define local_save_flags(x) asm volatile ("movew %%sr,%0":"=d" (x) : :
>> "memory")
>> -#define local_irq_restore(x) asm volatile ("movew %0,%%sr": :"d" (x) :
>> "memory")
>
> Your patch got partially word-wrapped.

Bugger :-(  Sorry about that. After I test it tomorrow I'll
resend an updated version.

Regards
Greg
