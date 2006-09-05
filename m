Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:62917 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965224AbWIERxQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Sep 2006 13:53:16 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k85HrEGi008277
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 13:53:14 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k85HrEA0294328
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 13:53:14 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k85HrDw1025260
	for <linux-arch@vger.kernel.org>; Tue, 5 Sep 2006 13:53:13 -0400
Subject: Re: [PATCH 3/9] actual generic PAGE_SIZE infrastructure
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1157434669.2413.30.camel@shinybook.infradead.org>
References: <20060901190805.C906A21A@localhost.localdomain>
	 <20060901190807.522EDD97@localhost.localdomain>
	 <1157434085.2413.22.camel@shinybook.infradead.org>
	 <1157434669.2413.30.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 10:52:51 -0700
Message-Id: <1157478771.3186.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-04 at 22:37 -0700, David Woodhouse wrote:
> The above can be summarised: In general, please remember to run 
> 'make headers_install' and check the sanity of the result if you're
> making changes which are going to affect user-visible headers.

Did you spot anything that looked like a problem?

How do I check the sanity?  Just that none of my headers showed up in
the new include directory.  Or, if they did, that all of their meat is
inside of an #ifdef __KERNEL__?

-- Dave

