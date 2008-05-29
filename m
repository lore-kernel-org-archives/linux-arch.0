From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 11/37] infiniband: use get/put_endian helpers
Date: Thu, 29 May 2008 15:19:59 -0700
Message-ID: <adak5hcoir4.fsf@cisco.com>
References: <1212092297.28403.113.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:17996 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbYE2WUB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 18:20:01 -0400
In-Reply-To: <1212092297.28403.113.camel@brick> (Harvey Harrison's message of
	"Thu, 29 May 2008 13:18:17 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Roland Dreier <rolandd@cisco.com>

OK, I guess, assuming

a) all of the conversions were done automatically and/or checked very carefully
b) we've made a global decision that this conversion has benefits that
outweigh all the churn it causes.

 - R.
