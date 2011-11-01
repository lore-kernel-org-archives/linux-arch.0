From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 6/6 V2] Add age out of guest paused flag
Date: Tue, 01 Nov 2011 14:58:23 -0500
Message-ID: <4EB04F5F.4010709@us.ibm.com>
References: <1320091650-24682-1-git-send-email-emunson@mgebm.net>	<1320091650-24682-7-git-send-email-emunson@mgebm.net>	<4EB049C3.7080206@us.ibm.com> <20111101195111.GA9852@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56056 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab1KAT6e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Nov 2011 15:58:34 -0400
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aliguori@us.ibm.com>;
	Tue, 1 Nov 2011 15:58:32 -0400
In-Reply-To: <20111101195111.GA9852@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, ryanh@linux.vnet.ibm.com

On 11/01/2011 02:51 PM, Eric B Munson wrote:
> On Tue, 01 Nov 2011, Anthony Liguori wrote:
>
>> On 10/31/2011 03:07 PM, Eric B Munson wrote:
>>> The KVM_GUEST_PAUSED flag will prevent a guest from compaining about a soft
>>> lockup but it can mask real soft lockups if the flag isn't cleared when it is
>>> no longer relevant.  This patch adds a kvm ioctl that the hypervisor will use
>>> when it resumes a guest to start a timer for aging out the flag.  The time out
>>> will be specified by the hypervisor in the ioctl call.
>>>
>>> Signed-off-by: Eric B Munson<emunson@mgebm.net>
>>
>> Why not have the guest clear the flag when it acknowledges it?
>>
>> The hypervisor would unconditionally set the bit, and the guest
>> would do a testandclear to check if the bit is set.  I think that
>> avoids the whole aging business.
>>
>> Regards,
>>
>> Anthony Liguori
>
> If you have a look at patch 5 of this series, the flag is cleared when the
> guest checks the validity of a soft lockup.  However, the aging is meant to
> cover the case where the guest never sees a soft lockup.  We don't want this
> flag to be stored for ever and end up delaying real soft lockup messages.  With
> that case in mind, I thought this was a good/simple compramise.

If the guest clears the flag, then I don't think you have to worry about this.

Regards,

Anthony Liguori
