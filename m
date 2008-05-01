From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] Change long to unsigned long in ptrace functions to
 fix sparse warnings
Date: Thu,  1 May 2008 16:20:17 -0700 (PDT)
Message-ID: <20080501232017.C333C26FA07@magilla.localdomain>
References: <18458.19939.138289.173048@cargo.ozlabs.ibm.com>
	<20080501.161608.150609265.davem@davemloft.net>
	<20080501231942.2B5C426FA07@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031AbYEAXUw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 May 2008 19:20:52 -0400
In-Reply-To: Roland McGrath's message of  Thursday, 1 May 2008 16:19:41 -0700 <20080501231942.2B5C426FA07@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, paulus@samba.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

> I don't know of any problems off hand, but I would testify that there
						    ^not
