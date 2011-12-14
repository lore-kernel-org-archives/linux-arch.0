From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
Date: Wed, 14 Dec 2011 17:01:11 +0200
Message-ID: <4EE8BA37.5070607@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net>	<4EDF7B0D.4060001@redhat.com> <20111214121622.GB18317@amt.cnet> <4EE8B53C.6070502@redhat.com> <4EE8B78F.9090104@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab1LNPBa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Dec 2011 10:01:30 -0500
In-Reply-To: <4EE8B78F.9090104@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Eric B Munson <emunson@mgebm.net>, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 12/14/2011 04:49 PM, Anthony Liguori wrote:
>>
>>> About SIGSTOP, that is a corner case. Unsure if its even properly
>>> supported
>>> by QEMU.
>>
>> It works from my experience.
>
>
> We don't adjust vm_clock's offset on SIGSTOP/SIGCONT so while it may
> appear to work okay, QEMU isn't exhibiting the behavior it is supposed
> to.

Should we trap and handle SIGCONT?

-- 
error compiling committee.c: too many arguments to function
