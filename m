Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:47557 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030620AbWFVMKM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Jun 2006 08:10:12 -0400
From: Keith Owens <kaos@sgi.com>
Subject: Re: [patch 2.6.17] Standardize i386/x86_64 handling of NMI_VECTOR 
In-reply-to: Your message of "Thu, 22 Jun 2006 13:59:46 +0200."
             <200606221359.46092.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Jun 2006 22:09:42 +1000
Message-ID: <29012.1150978182@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen (on Thu, 22 Jun 2006 13:59:46 +0200) wrote:
>On Thursday 22 June 2006 13:46, Keith Owens wrote:
>> Andi Kleen (on Thu, 22 Jun 2006 12:48:21 +0200) wrote:
>> >On Thursday 22 June 2006 11:01, Keith Owens wrote:
>> >> x86_64 and i386 behave inconsistently when sending an IPI on vector 2
>> >> (NMI_VECTOR).  Make both behave the same, so IPI 2 is sent as NMI.
>> >> 
>> >> The crash code was abusing send_IPI_allbutself() by passing a code
>> >> instead of a vector, it only worked because crash knew about the
>> >> internal code of send_IPI_allbutself().  Change crash to use NMI_VECTOR
>> >> instead, and remove the comment about how crash was abusing the function.
>> >
>> >Does that fix anything? 
>> 
>> This patch is a pre-requisite for fixing the problem where sending an
>> IPI as NMI would reboot some Dell Xeon systems.  I cannot fix that
>> problem while crash continus to abuse send_IPI_allbutself().
>
>I merged it with the updated description. Thanks.

Merged how much and into which tree?  Most of the change is i386, with
a one line change to x86_64.  I have to ensure that the i386 bits get
into the main tree.

