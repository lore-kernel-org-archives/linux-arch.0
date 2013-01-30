From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 43/44] tty/metag_da: Add metag DA TTY driver
Date: Wed, 30 Jan 2013 10:43:51 +0000
Message-ID: <5108F967.8070808@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <1357831872-29451-44-git-send-email-james.hogan@imgtec.com> <50F3E3FF.4080803@imgtec.com> <51026E55.80905@imgtec.com> <20130130051418.GB26687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:38630 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab3A3KpY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Jan 2013 05:45:24 -0500
In-Reply-To: <20130130051418.GB26687@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-arch@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Cesar Eduardo Barros <cesarb@cesarb.net>, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>

On 30/01/13 05:14, Greg Kroah-Hartman wrote:
> On Fri, Jan 25, 2013 at 11:36:53AM +0000, James Hogan wrote:
>> Hi,
>>
>> On 14/01/13 10:54, James Hogan wrote:
>>> Here's a new version addressing Jiri's feedback.
>>>
>>> Add a TTY driver for communicating over a Meta DA (Debug Adapter)
>>> channel using the bios channel SWITCH operation.
>>>
>>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>>> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Jiri Slaby <jslaby@suse.cz>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
>>> Cc: Cesar Eduardo Barros <cesarb@cesarb.net>
>>> Cc: Joe Perches <joe@perches.com>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>
>> If this looks okay, I'd appreciate if somebody could Ack it.
>>
>> I have some further patches ready to simplify the code around
>> tty_prepare_flip_string and tty_flip_buffer_push to avoid taking a tty
>> kref, after Jiri's changes in that area in linux-next. I guess these can
>> be applied once both sets of changes are merged.
> 
> At first glance, it looks good to me:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Thanks Greg.

Cheers
James
