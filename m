Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49283 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752882AbcGYO1S (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jul 2016 10:27:18 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6PEOCXN117570
	for <linux-arch@vger.kernel.org>; Mon, 25 Jul 2016 10:27:17 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 24c2qv7sg7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Mon, 25 Jul 2016 10:27:15 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Mon, 25 Jul 2016 15:27:03 +0100
Date: Mon, 25 Jul 2016 16:26:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: Is THREAD_INFO_IN_TASK appropriate for -mm for 4.8?
References: <CALCETrUf_7=Tr4JrDj+3UPT5kUT1MsRtypvfqkOg_MVHAJu=PA@mail.gmail.com>
 <578DE406.9060902@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578DE406.9060902@de.ibm.com>
Message-ID: <20160725142640.GA4337@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, x86 <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20160725142640.KTUjQUvsjTQFLygCQZH9n9NZxOtnzKg2IgAuvjdYYCU@z>

On Tue, Jul 19, 2016 at 10:25:42AM +0200, Christian Borntraeger wrote:
> On 07/19/2016 01:47 AM, Andy Lutomirski wrote:
> > Hi all-
> > 
> > There are four core patches needed for the THREAD_INFO_IN_TASK thing,
> > and they apply cleanly to -mm now.  The x86 patch to flip the feature
> > on does not apply cleanly anywhere because it depends on changes in
> > -tip *and* in -mm.  I'd like to get all of this as well as the rest of
> > the vmap-stacks stuff in by 4.9, but I'm wondering if it might make
> > sense to get the core THREAD_INFO_IN_TASK stuff into -mm for 4.8
> > instead.
> > 
> > Pros:
> >  - It reduces the amount of core code that -tip will have to carry until 4.9.
> >  - It may benefit other architectures.  Christian Borntraeger
> > expressed an interest in enabling the feature for s390, but it'll be
> > awkward for him until the core bit landed.  Similarly, arm64 seems to
> > be interested.
> 
> I have not yet talked to Martin/Heiko about this, so not sure yet if and when
> s390 is going to use this - so no pressure from our side yet.

I wrote a patch four weeks ago which converts s390 based on Linus' orginal
patches. So yes, we will convert s390 as soon as this hits upstream.

