From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 07/11] sysctl: s390 Use the compat_sys_sysctl
Date: Fri, 6 Nov 2009 10:12:17 +0100
Message-ID: <200911061012.17239.borntraeger@de.ibm.com>
References: <m1tyx8trik.fsf@fess.ebiederm.org> <1257468114-6823-7-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:50605 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbZKFJMN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2009 04:12:13 -0500
In-Reply-To: <1257468114-6823-7-git-send-email-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Carsten Otte <cotte@de.ibm.com>

Am Freitag 06 November 2009 01:41:50 schrieb Eric W. Biederman:
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> Now that we have a generic 32bit compatibility implementation
> there is no need for s390 to implement it's own.
> 
> Cc: Carsten Otte <cotte@de.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>

You should have CCed Martin & Heiko, since this is cleary not KVM.
I took a look anyway ;-)

> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Patch looks good.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
