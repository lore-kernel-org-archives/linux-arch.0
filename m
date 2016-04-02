Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42321 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755544AbcDBA2y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 Apr 2016 20:28:54 -0400
Date: Fri, 1 Apr 2016 17:28:40 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 01/11] locking, rwsem: get rid of __down_write_nested
Message-ID: <20160402002840.GA5329@linux-uzut.site>
References: <1459508695-14915-1-git-send-email-mhocko@kernel.org>
 <1459508695-14915-2-git-send-email-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1459508695-14915-2-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Message-ID: <20160402002840.Pmf-dm02-rZbTrZEaSd4VECCEP0dx9J4aYC0eaFWZuw@z>

On Fri, 01 Apr 2016, Michal Hocko wrote:

>From: Michal Hocko <mhocko@suse.com>
>
>This is no longer used anywhere and all callers (__down_write) use
>0 as a subclass. Ditch __down_write_nested to make the code easier
>to follow.
>
>This shouldn't introduce any functional change.
>
>Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
