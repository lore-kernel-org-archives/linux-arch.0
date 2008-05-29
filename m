From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 11/37] infiniband: use get/put_endian helpers
Date: Thu, 29 May 2008 15:24:19 -0700
Message-ID: <1212099859.28403.149.camel@brick>
References: <1212092297.28403.113.camel@brick>  <adak5hcoir4.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:32258 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbYE2WYV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 18:24:21 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3113239wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 15:24:21 -0700 (PDT)
In-Reply-To: <adak5hcoir4.fsf@cisco.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Roland Dreier <rolandd@cisco.com>

On Thu, 2008-05-29 at 15:19 -0700, Roland Dreier wrote:
> OK, I guess, assuming
> 
> a) all of the conversions were done automatically and/or checked very carefully
> b) we've made a global decision that this conversion has benefits that
> outweigh all the churn it causes.
> 

Well, assuming it's wanted, I can send you a sed-based patch instead and
a follow-on patch that does the additional codingstyle bits on the
changed lines that adds up to this patch.

This was to get the discussion going on your point b).

Harvey
