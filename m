From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [RFA][PATCH 26/27] s390/ftrace: remove check of obsolete
 variable function_trace_stop
Date: Fri, 27 Jun 2014 08:01:02 +0200
Message-ID: <20140627060102.GA4396@osiris>
References: <20140626165221.736847419@goodmis.org>
 <20140626165853.685458770@goodmis.org>
 <20140626134141.18d92f1d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:56787 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaF0GBH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jun 2014 02:01:07 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 27 Jun 2014 07:01:05 +0100
Content-Disposition: inline
In-Reply-To: <20140626134141.18d92f1d@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Jun 26, 2014 at 01:41:41PM -0400, Steven Rostedt wrote:
> 
> I know you wrote this patch, but you may want to test it out with
> the ftrace: Remove check for HAVE_FUNCTION_TRACE_MCOUNT_TEST patch
> applied too.

In order to compile this, I'd have to apply all common code patches, I think.
But they don't apply against Linus' master tree and I wouldn't know which
tree these patches are against.
But anyway, it all looks good ;)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
