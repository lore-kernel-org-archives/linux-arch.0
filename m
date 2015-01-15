Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:43574 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbbAOLHV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jan 2015 06:07:21 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 15 Jan 2015 11:07:19 -0000
Message-ID: <54B79F5F.1040806@de.ibm.com>
Date: Thu, 15 Jan 2015 12:07:11 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 3/8] x86/xen/p2m: Replace ACCESS_ONCE with
 READ_ONCE
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com> <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com> <54B799DC.1050008@citrix.com>
In-Reply-To: <54B799DC.1050008@citrix.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Vrabel <david.vrabel@citrix.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20150115110711.mBgFH8pNXmKEY41UcSsNd2lzMZ0_Y5nvlLA_OQzZPEM@z>

Am 15.01.2015 um 11:43 schrieb David Vrabel:
> On 15/01/15 08:58, Christian Borntraeger wrote:
>> ACCESS_ONCE does not work reliably on non-scalar types. For
>> example gcc 4.6 and 4.7 might remove the volatile tag for such
>> accesses during the SRA (scalar replacement of aggregates) step
>> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
>>
>> Change the p2m code to replace ACCESS_ONCE with READ_ONCE.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>

Thanks

> Let me know if you want me to merge this via the Xen tree.


With your Acked-by, I can easily carry this in my tree. We can 
then ensure that this patch is merged before the ACCESS_ONCE is
made stricter - making bisecting easier.

Christian

