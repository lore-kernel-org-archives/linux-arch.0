Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:60900 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYDWP6p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Apr 2008 11:58:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 11/11] s390: convert to generic helpers for IPI function calls
Date: Thu, 24 Apr 2008 01:56:27 +1000
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <20080423114744.GA29422@osiris.boeblingen.de.ibm.com> <1208954573.5090.10.camel@localhost>
In-Reply-To: <1208954573.5090.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200804240156.27894.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, peterz@infradead.org, sam@ravnborg.org
Message-ID: <20080423155627.IqPZpuB-ND-asddvZxsO-ZOy1wiZlUhJpm_hHN-SluQ@z>

On Wednesday 23 April 2008 22:42:53 Martin Schwidefsky wrote:
> Looking at the stop_machine() code it doesn't seem to be to hard to get
> this implemented. stop_machine_run() would get a second function
> argument that replaces the call to cpu_relax() in stopmachine().
> The default if the additional function argument is NULL would be
> cpu_relax(). For the etr sync code it would be etr_sync_cpu_start().

Sure.  I've got changes for stop_machine planned, so please send a patch and 
I'll merge it in.

Cheers,
Rusty.
