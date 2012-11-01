From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 31/40] char: don't build rtc or genrtc on METAG
Date: Thu, 1 Nov 2012 17:33:43 +0000
Message-ID: <5092B277.7080805@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-32-git-send-email-james.hogan@imgtec.com> <20121101153949.GA8529@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:26211 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920Ab2KARdp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Nov 2012 13:33:45 -0400
In-Reply-To: <20121101153949.GA8529@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org

On 01/11/12 15:39, Greg KH wrote:
> On Wed, Oct 31, 2012 at 04:14:12PM +0000, James Hogan wrote:
>> The metag architecture doesn't have a PC RTC or implement the RTC
>> interface that genrtc expects, so add METAG to the list of architectures
>> not to build RTC or GEN_RTC on.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> ---
>>  drivers/char/Kconfig |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
>> index ea6f632..09b64a8 100644
>> --- a/drivers/char/Kconfig
>> +++ b/drivers/char/Kconfig
>> @@ -283,7 +283,8 @@ if RTC_LIB=n
>>  config RTC
>>  	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
>>  	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
>> -			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
>> +			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN \
>> +			&& !UML && !METAG
> 
> This is getting huge, would it be easier to reverse it and just list the
> arches that it does work for?

Hi Greg,

Yes, I think I agree.

I'll probably also squash together all these similar !METAG patches into
one for v2.

Thanks for taking a look
James
