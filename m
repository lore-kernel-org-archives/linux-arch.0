From: Christophe Guillon <christophe.guillon@st.com>
Subject: Re: [PATCH v2 0/4] add support for gcov format introduced in gcc 4.7
Date: Thu, 26 Sep 2013 23:11:28 +0000 (UTC)
Message-ID: <loom.20130927T010952-341@post.gmane.org>
References: <1378305776-3644-1-git-send-email-fhrbata@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35581 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab3I0IUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Sep 2013 04:20:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glka-linux-arch@m.gmane.org>)
	id 1VPTHS-00049V-Tv
	for linux-arch@vger.kernel.org; Fri, 27 Sep 2013 10:20:07 +0200
Received: from 95.172.68.146 ([95.172.68.146])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-arch@vger.kernel.org>; Fri, 27 Sep 2013 10:20:06 +0200
Received: from christophe.guillon by 95.172.68.146 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-arch@vger.kernel.org>; Fri, 27 Sep 2013 10:20:06 +0200
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Frantisek Hrbata <fhrbata <at> redhat.com> writes:

> 
> This is an attempt to bring support for modified gcov format in gcc 4.7 
to
> the kernel. It tries to leverage the existing layout/abstraction, which 
was
> designed keeping in mind that the gcov format could change, but some 
changes had
> to be make. Mostly because the current model does not take into account 
that
> even the core gcov structures, like gcov_info, could change. One part 
that could
> be problematic is the addition of the .init_array section for 
constructors.
> 
> Tested with lcov and seems to be working fine, giving similar results as 
for the
> older format.
> 
> v2: Included suggestions/code provided by Peter Oberparleiter. Detailed
>     description in patches.
> 

With suggested changes, verified on:
- gcc ARM 4.6.2
- gcc ARM 4.6.3

Christophe
