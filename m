From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 01/11] sysctl: Separate the binary sysctl logic into it's own file.
Date: Fri, 6 Nov 2009 10:04:00 +0100
Message-ID: <200911061004.01007.borntraeger@de.ibm.com>
References: <m1tyx8trik.fsf@fess.ebiederm.org> <1257468114-6823-1-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:57558 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbZKFJEW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2009 04:04:22 -0500
In-Reply-To: <1257468114-6823-1-git-send-email-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Am Freitag 06 November 2009 01:41:44 schrieb Eric W. Biederman:
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> In preparation for more invasive cleanups separate the core
> binary sysctl logic into it's own file.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Hmm, with your patches on Linus git I get the following on s390:

kernel/sysctl_binary.c: In function 'SYSC_sysctl':
kernel/sysctl_binary.c:126: error: implicit declaration of function 
'lock_kernel'
kernel/sysctl_binary.c:129: error: implicit declaration of function 
'unlock_kernel'

Christian
