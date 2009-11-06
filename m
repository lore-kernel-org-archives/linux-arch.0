From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 07/11] sysctl: s390 Use the compat_sys_sysctl
Date: Fri, 06 Nov 2009 02:19:51 -0800
Message-ID: <m13a4srm48.fsf@fess.ebiederm.org>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
	<1257468114-6823-7-git-send-email-ebiederm@xmission.com>
	<200911061012.17239.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:45446 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbZKFKTw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2009 05:19:52 -0500
In-Reply-To: <200911061012.17239.borntraeger@de.ibm.com> (Christian Borntraeger's message of "Fri\, 6 Nov 2009 10\:12\:17 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>

Christian Borntraeger <borntraeger@de.ibm.com> writes:

> Am Freitag 06 November 2009 01:41:50 schrieb Eric W. Biederman:
>> From: Eric W. Biederman <ebiederm@xmission.com>
>> 
>> Now that we have a generic 32bit compatibility implementation
>> there is no need for s390 to implement it's own.
>> 
>> Cc: Carsten Otte <cotte@de.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>
> You should have CCed Martin & Heiko, since this is cleary not KVM.
> I took a look anyway ;-)

Groan. I got the wrong s390 line in MAINTAINERS.

>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> Patch looks good.
>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
