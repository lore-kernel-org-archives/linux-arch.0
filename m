From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 37/40] metag: Various sysfs drivers
Date: Wed, 31 Oct 2012 19:41:03 +0000
Message-ID: <50917ECF.7060103@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-38-git-send-email-james.hogan@imgtec.com> <20121031193037.GA2109@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55141 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab2JaTlG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 15:41:06 -0400
In-Reply-To: <20121031193037.GA2109@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org

On 31/10/12 19:30, Greg KH wrote:
> On Wed, Oct 31, 2012 at 04:14:18PM +0000, James Hogan wrote:
>> Add various Meta specific sysfs drivers.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> 
> As you are creating new sysfs files, please also create new
> Documentation/ABI/ files describing what those sysfs files do at the
> same time.

Good point, I'll make sure Documentation is added.

Thanks,
James
